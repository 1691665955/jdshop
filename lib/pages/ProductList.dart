import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../generated/json/base/json_convert_content.dart';
import '../config/Config.dart';
import '../services/ScreenAdapter.dart';
import '../model/product_model_entity.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// ignore: must_be_immutable
class ProductListPage extends StatefulWidget {
  Map arguments;

  ProductListPage(this.arguments);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  //用于触发筛选侧边栏的
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //分页
  int _page = 1;
  int _pageSize = 10;
  String _sort = "";
  bool _hasMore = true;
  bool _nullData = false;
  List _subHeaderList = [
    {"id": 1, "title": "综合", "fileds": "all", "sort": -1},
    {"id": 2, "title": "销量", "fileds": "salecount", "sort": -1},
    {"id": 3, "title": "价格", "fileds": "price", "sort": -1},
    {"id": 4, "title": "筛选"},
  ];
  int _selectHeaderId = 1;
  ScrollController _controller = new ScrollController();
  List<ProductModelResult> _productList = [];

  @override
  void initState() {
    super.initState();

    _getProductListData();
  }

  _getProductListData() async {
    var cid = widget.arguments["sid"];
    var keywords = widget.arguments["keywords"];
    var api =
        "${Config.domain}/api/plist?cid=${cid==null?'':cid}&search=${keywords==null?'':keywords}&page=${this._page}&pageSize=${this._pageSize}&sort=${this._sort}";
    var result = await Dio().get(api);
    var productList =
        JsonConvert.fromJsonAsT<ProductModelEntity>(result.data).result;
    setState(() {
      if (_page == 1) {
        _productList.clear();
        _controller.jumpTo(0);
      }
      _nullData = (_page == 1 && productList.length == 0);
      _productList.addAll(productList);
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {
          this._hasMore = (productList.length == _pageSize);
        });
      });
    });
  }

  Widget _productListWidget() {
    if (_nullData) {
      return Center(
        child: Text("暂无数据!"),
      );
    }
    return Container(
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
      child: EasyRefresh.custom(
          scrollController: _controller,
          header: ClassicalHeader(
              refreshText: "下拉刷新",
              refreshReadyText: "释放刷新",
              refreshedText: "刷新完成",
              refreshingText: "正在刷新...",
              infoText: "更新于 %T"),
          footer: _hasMore?ClassicalFooter(
                  loadingText: "正在加载...",
                  loadedText: "加载完成",
                  noMoreText: "没有更多数据",
                  infoText: "更新于 %T"):null,
          onRefresh: () async {
            this._page = 1;
            this._getProductListData();
          },
          onLoad: this._hasMore
              ? () async {
                  this._page++;
                  this._getProductListData();
                }
              : null,
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Image.network(
                          "${Config.domain}/${_productList[index].sPic.replaceAll("\\", "/")}",
                          fit: BoxFit.cover,
                        ),
                        width: ScreenAdapter.width(180),
                        height: ScreenAdapter.width(180),
                      ),
                      Expanded(
                        child: Container(
                          height: ScreenAdapter.width(180),
                          margin:
                              EdgeInsets.only(left: ScreenAdapter.width(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${_productList[index].title}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(28)),
                              ),
                              Row(
                                children: _getTagList([]),
                              ),
                              Text(
                                "¥${_productList[index].price}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: ScreenAdapter.fontSize(24)),
                              )
                            ],
                          ),
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                  Divider(
                    height: ScreenAdapter.width(40),
                  ),
                ],
              );
            }, childCount: _productList.length))
          ]),
    );
  }

  List<Widget> _getTagList(List<String> tags) {
    return tags.map((tag) {
      return Container(
        margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
        padding: EdgeInsets.fromLTRB(
            ScreenAdapter.width(20),
            ScreenAdapter.height(6),
            ScreenAdapter.width(20),
            ScreenAdapter.height(6)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
            color: Color.fromRGBO(230, 230, 230, 0.9)),
        child: Text(
          tag,
          style: TextStyle(fontSize: ScreenAdapter.fontSize(24)),
        ),
      );
    }).toList();
  }

  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (_subHeaderList[id-1]["sort"] == 1)
        return Icon(Icons.arrow_drop_down);
      return Icon(Icons.arrow_drop_up);
    }
    return Text("");
  }

  Widget _subHeaderWidget() {
    return Positioned(
      child: Container(
        width: ScreenAdapter.getScreenWidth(),
        height: ScreenAdapter.height(80),
        child: Row(
          children: _subHeaderList.map((value){
            return Expanded(
              child: InkWell(
                child: Container(
                  height: ScreenAdapter.height(80),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value["title"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: value["id"]==_selectHeaderId?Colors.red:Colors.black54,
                          ),
                        ),
                        _showIcon(value["id"])
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  int id = value["id"];
                  if (id == 4) {
                    _scaffoldKey.currentState.openEndDrawer();
                  } else {
                    setState(() {
                      _selectHeaderId = value["id"];
                      _sort = "${_subHeaderList[value["id"]-1]["fileds"]}_${_subHeaderList[value["id"]-1]["sort"]}";
                      _subHeaderList[value["id"]-1]["sort"] = _subHeaderList[value["id"]-1]["sort"]*-1;
                      _page = 1;
                      _getProductListData();
                    });
                  }
                },
              ),
              flex: 1,
            );
          }).toList(),
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(223, 223, 223, 0.9)))),
      ),
      top: 0,
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.height(80),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("商品列表"),
          actions: [Text("")],
        ),
        endDrawer: Drawer(
          child: Container(
            child: Center(
              child: Text("实现筛选功能"),
            ),
          ),
        ),
        body: Stack(
          children: [_subHeaderWidget(), _productListWidget()],
        ));
  }
}

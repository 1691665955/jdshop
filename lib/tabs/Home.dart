import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../config/Config.dart';
import '../generated/json/base/json_convert_content.dart';
import '../model/focus_model_entity.dart';
import '../model/product_model_entity.dart';
import '../services/ScreenAdapter.dart';

//轮播图类模型
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<FocusModelResult> _focusData = [];
  List<ProductModelResult> _hotProductData = [];
  List<ProductModelResult> _bestProductData = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
  }

  ///获取轮播图数据
  Future<void> _getFocusData() async {
    var api = "${Config.domain}/api/focus";
    var result = await Dio().get(api);
    FocusModelEntity focusModel =
        JsonConvert.fromJsonAsT<FocusModelEntity>(result.data);
    setState(() {
      this._focusData = focusModel.result;
    });
  }

  ///获取猜你喜欢的数据
  Future<void> _getHotProductData() async {
    var api = "${Config.domain}/api/plist?is_hot=1";
    var result = await Dio().get(api);
    ProductModelEntity productModel =
        JsonConvert.fromJsonAsT<ProductModelEntity>(result.data);
    setState(() {
      this._hotProductData = productModel.result;
    });
  }

  ///获取热门推荐的数据
  Future<void> _getBestProductData() async {
    var api = "${Config.domain}/api/plist?is_best=1";
    var result = await Dio().get(api);
    ProductModelEntity productModel =
        JsonConvert.fromJsonAsT<ProductModelEntity>(result.data);
    setState(() {
      this._bestProductData = productModel.result;
    });
  }

  ///轮播图
  Widget _swiperWidget() {
    if (_focusData.length > 0) {
      return Container(
        child: AspectRatio(
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                  "${Config.domain}/${_focusData[index].pic.replaceAll("\\", "/")}",
                  fit: BoxFit.cover);
            },
            itemCount: _focusData.length,
            pagination: SwiperPagination(),
            autoplay: true,
            onTap: (index) {
              print(ScreenAdapter.getBottomBarHeight());
              print(ScreenAdapter.getStatusBarHeight());
              print(ScreenAdapter.getScreenHeight());
              print(ScreenAdapter.getScreenWidth());
            },
          ),
          aspectRatio: 2,
        ),
      );
    } else {
      return Text("加载中...");
    }
  }

  Widget _titleWidget(String title) {
    return Container(
      height: ScreenAdapter.height(32),
      margin: EdgeInsets.only(left: ScreenAdapter.width(10)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(5)),
      alignment: Alignment(-1, 0), //Container垂直居中
      decoration: BoxDecoration(
          border: Border(left: BorderSide(width: 6, color: Colors.red))),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black54, fontSize: ScreenAdapter.fontSize(24)),
      ),
    );
  }

  Widget _likeProductListWidget() {
    if (_hotProductData.length > 0) {
      return Container(
        height: ScreenAdapter.width(220),
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        width: double.infinity,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Image.network(
                    "${Config.domain}/${_hotProductData[index].sPic.replaceAll("\\", "/")}",
                    width: ScreenAdapter.width(140),
                    height: ScreenAdapter.width(140),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: ScreenAdapter.width(10),
                  ),
                  Container(
                    width: ScreenAdapter.width(140),
                    height: ScreenAdapter.width(30),
                    child: Text(
                      "¥${_hotProductData[index].price}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(24),
                          color: Colors.red),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.only(
                  left: ScreenAdapter.width(index == 0 ? 0 : 20)),
            );
          },
          itemCount: _hotProductData.length,
          scrollDirection: Axis.horizontal,
        ),
      );
    } else {
      return Text("加载中...");
    }
  }

  Widget _recommendProductItemWidget(ProductModelResult item) {
    var itemWidth =
        (ScreenAdapter.getScreenWidth() - ScreenAdapter.width(60)) / 2;

    return InkWell(
      child: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        width: itemWidth,
        decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.network(
                  "${Config.domain}/${item.sPic.replaceAll("\\", "/")}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.width(10)),
              child: Text(
                "${item.title}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: ScreenAdapter.fontSize(24)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.width(10)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "¥${item.price}",
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(28),
                          color: Colors.red),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "¥${item.oldPrice}",
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(24),
                          color: Colors.black54,
                          decoration: TextDecoration.lineThrough),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/productDetail',
            arguments: {'id': item.sId});
      },
    );
  }

  Widget _recommendProductListWidget() {
    if (_bestProductData.length > 0) {
      return Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: Wrap(
          runSpacing: ScreenAdapter.width(20),
          spacing: ScreenAdapter.width(20),
          children: _bestProductData.map((value) {
            return _recommendProductItemWidget(value);
          }).toList(),
        ),
      );
    } else {
      return Text("加载中...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.center_focus_weak),
          onPressed: () {},
        ),
        title: InkWell(
          child: Container(
            height: 36,
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(18)),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 20,
                ),
                Text(
                  "商务笔记本",
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, "/search");
          },
        ),
        actions: [IconButton(icon: Icon(Icons.message), onPressed: () {})],
      ),
      body: ListView(
        children: [
          _swiperWidget(),
          SizedBox(
            height: ScreenAdapter.height(10),
          ),
          _titleWidget("猜你喜欢"),
          _likeProductListWidget(),
          _titleWidget("热门推荐"),
          _recommendProductListWidget()
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../generated/json/base/json_convert_content.dart';
import 'prodcutDetail/ProductDetailFirst.dart';
import 'prodcutDetail/ProductDetailSecond.dart';
import 'prodcutDetail/ProductDetailThird.dart';
import '../services/ScreenAdapter.dart';
import '../widget/MZButton.dart';
import 'package:dio/dio.dart';
import '../model/product_detail_model_entity.dart';
import '../config/Config.dart';
import '../services/EventBus.dart';
import '../services/CartServices.dart';
import '../provider/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetailPage extends StatefulWidget {
  final Map arguments;

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();

  ProductDetailPage(this.arguments);
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductDetailModelResult _productDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductDetailData();
  }

  _getProductDetailData() async {
    var api = "${Config.domain}/api/pcontent?id=${widget.arguments['id']}";
    var result = await Dio().get(api);
    var detail =
        JsonConvert.fromJsonAsT<ProductDetailModelEntity>(result.data).result;
    setState(() {
      _productDetail = detail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: ScreenAdapter.width(430),
                  child: TabBar(
                    indicatorColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        child: Text("商品"),
                      ),
                      Tab(
                        child: Text("详情"),
                      ),
                      Tab(
                        child: Text("评价"),
                      )
                    ],
                  ),
                )
              ],
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            ScreenAdapter.width(600),
                            ScreenAdapter.getStatusBarHeight() + 44,
                            ScreenAdapter.width(10),
                            ScreenAdapter.width(0)),
                        items: [
                          PopupMenuItem(
                              child: Row(
                            children: [Icon(Icons.home), Text("首页")],
                          )),
                          PopupMenuItem(
                              child: Row(
                            children: [Icon(Icons.search), Text("搜索")],
                          ))
                        ]);
                  })
            ],
          ),
          body: _productDetail == null
              ? Text("")
              : Stack(
                  children: [
                    TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ProductDetailFirst(_productDetail),
                        ProductDetailSecond(_productDetail),
                        ProductDetailThird(_productDetail),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: ScreenAdapter.width(750),
                        height: 50 + ScreenAdapter.getBottomBarHeight(),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.black12, width: 1))),
                              child: Row(
                                children: [
                                  InkWell(
                                    child: Container(
                                      width: 80,
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.shopping_cart,size: 24,),
                                          Text("购物车")
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/cart');
                                    },
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: MZButton(
                                      margin: EdgeInsets.only(
                                          right: ScreenAdapter.width(20)),
                                      color: Color.fromRGBO(253, 1, 0, 0.9),
                                      title: "加入购物车",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      onTap: () async {
                                        if (_productDetail.attr.length > 0) {
                                          //广播 弹出筛选
                                          eventBus.fire(
                                              ProductDetailEvent("加入购物车"));
                                        } else {
                                          await CartServices.addCart(_productDetail);
                                          //调用Provider更新数据
                                          context.read<CartProvider>().updateCartList();
                                          Fluttertoast.showToast(msg: "加入购物车成功",gravity: ToastGravity.CENTER);
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: MZButton(
                                      margin: EdgeInsets.only(
                                          right: ScreenAdapter.width(20)),
                                      color: Color.fromRGBO(255, 165, 0, 0.9),
                                      title: "立即购买",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      onTap: () {
                                        if (_productDetail.attr.length > 0) {
                                          //广播 弹出筛选
                                          eventBus
                                              .fire(ProductDetailEvent("立即购买"));
                                        } else {
                                          print("立即购买");
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ));
  }
}

import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/MZButton.dart';
import '../../model/product_detail_model_entity.dart';
import '../../config/Config.dart';

class ProductDetailFirst extends StatefulWidget {
  final ProductDetailModelResult productDetail;

  @override
  _ProductDetailFirstState createState() => _ProductDetailFirstState();

  ProductDetailFirst(this.productDetail);
}

class _ProductDetailFirstState extends State<ProductDetailFirst> with AutomaticKeepAliveClientMixin {

  String _selectedAttrString = "";

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAttr();
  }

  void _initAttr() {
    var attr = widget.productDetail.attr;
    for (var i = 0; i <attr.length; i++) {
      for (var j = 0; j < attr[i].xList.length; j++) {
        if (j == 0) {
          attr[i].attrList.add({
            "title": attr[i].xList[j],
            "checked": true
          });
        } else {
          attr[i].attrList.add({
            "title": attr[i].xList[j],
            "checked": false
          });
        }
      }
    }
    _getSelectedAttrValue();
  }

  void _getSelectedAttrValue() {
    var selectedAttr = [];
    var attr = widget.productDetail.attr;
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].attrList.length; j++) {
        if (attr[i].attrList[j]["checked"]) {
          selectedAttr.add(attr[i].attrList[j]["title"]);
        }
      }
    }
    setState(() {
      _selectedAttrString = selectedAttr.join("，");
    });
  }

  void _changeAttr(cate, title, setBottomState) {
    var attr = widget.productDetail.attr;
    for (var i = 0; i <attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].xList.length; j++) {
          attr[i].attrList[j]["checked"] = false;
          if (attr[i].attrList[j]["title"] == title) {
            attr[i].attrList[j]["checked"] = true;
          }
        }
      }
    }
    setBottomState(() {
      widget.productDetail.attr = attr;
    });
    _getSelectedAttrValue();
  }

  //选择商品规格
  void _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setBottomState){
            return Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(500),
              child: Stack(
                children: [
                  Container(
                    height: ScreenAdapter.height(500) -
                        50 -
                        ScreenAdapter.getBottomBarHeight(),
                    child: ListView(
                      children: [
                        Column(
                          children: widget.productDetail.attr.map((attrItem) {
                            return Wrap(
                              children: [
                                Container(
                                  width: ScreenAdapter.width(150),
                                  padding: EdgeInsets.only(left: 10, top: 20),
                                  height: 60,
                                  child: Text(
                                    "${attrItem.cate}",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  width: ScreenAdapter.getScreenWidth() -
                                      ScreenAdapter.width(150),
                                  child: Wrap(
                                    children: attrItem.attrList.map((cateItem) {
                                      return Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: InkWell(
                                          child: Chip(
                                            label: Text("${cateItem["title"]}",style: TextStyle(color: cateItem["checked"]?Colors.white:Colors.black54),),
                                            backgroundColor: cateItem["checked"]?Colors.red:Colors.black12,
                                          ),
                                          onTap: () {
                                            _changeAttr(attrItem.cate, cateItem["title"],setBottomState);
                                          },
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    width: ScreenAdapter.width(750),
                    height: 50 + ScreenAdapter.getBottomBarHeight(),
                    child: Column(
                      children: [
                        Container(
                          width: ScreenAdapter.width(750),
                          height: 50,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: MZButton(
                                    color: Color.fromRGBO(251, 1, 0, 0.9),
                                    title: "加入购物车",
                                    style: TextStyle(color: Colors.white),
                                    margin: EdgeInsets.only(left: 20, right: 10),
                                    onTap: () {},
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: MZButton(
                                    color: Color.fromRGBO(255, 165, 0, 0.9),
                                    title: "立即购买",
                                    style: TextStyle(color: Colors.white),
                                    margin: EdgeInsets.only(left: 10, right: 20),
                                    onTap: () {},
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: ScreenAdapter.getBottomBarHeight()+50),
      child: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              "${Config.domain}/${widget.productDetail.pic.replaceAll("\\", "/")}",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(
                bottom: 50 + ScreenAdapter.getBottomBarHeight()),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    widget.productDetail.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: ScreenAdapter.fontSize(36)),
                  ),
                ),
                widget.productDetail.subTitle==null?Text(""):Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    widget.productDetail.subTitle,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: ScreenAdapter.fontSize(28)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "特价",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: ScreenAdapter.fontSize(32)),
                              ),
                              Text(
                                "¥${widget.productDetail.price}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: ScreenAdapter.fontSize(48)),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "原价",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: ScreenAdapter.fontSize(32)),
                              ),
                              Text(
                                "¥${widget.productDetail.oldPrice}",
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: ScreenAdapter.fontSize(32),
                                    decoration: TextDecoration.lineThrough),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                widget.productDetail.attr.length==0?Text(""):InkWell(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 50,
                    child: Row(
                      children: [
                        Text(
                          "已选：",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(_selectedAttrString)
                      ],
                    ),
                  ),
                  onTap: () {
                    _attrBottomSheet();
                  },
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Text(
                        "运费：",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("免运费")
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../model/product_detail_model_entity.dart';
import '../../services/ScreenAdapter.dart';

class ProductDetailThird extends StatefulWidget {

  final ProductDetailModelResult productDetail;

  @override
  _ProductDetailThirdState createState() => _ProductDetailThirdState();

  ProductDetailThird(this.productDetail);
}

class _ProductDetailThirdState extends State<ProductDetailThird> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: ScreenAdapter.getBottomBarHeight()+50),
      child: Text("评价"),
    );
  }
}

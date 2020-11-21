import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../model/product_detail_model_entity.dart';
import '../../config/Config.dart';
import '../../services/ScreenAdapter.dart';

class ProductDetailSecond extends StatefulWidget {

  final ProductDetailModelResult productDetail;

  @override
  _ProductDetailSecondState createState() => _ProductDetailSecondState();

  ProductDetailSecond(this.productDetail);
}

class _ProductDetailSecondState extends State<ProductDetailSecond> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: ScreenAdapter.getBottomBarHeight()+50),
      child: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrl: "${Config.domain}/pcontent?id=${widget.productDetail.sId}"
            ),
          )
        ],
      ),
    );
  }
}

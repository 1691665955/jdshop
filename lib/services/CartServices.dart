import '../model/product_detail_model_entity.dart';

class CartServices {

  static void addCart(ProductDetailModelResult productDetail) {
    Map data = formatCartData(productDetail);
    print(data);
  }

  //过滤数据
  static Map formatCartData(ProductDetailModelResult productDetail) {
    final Map data = new Map<String, dynamic>();
    data['_id'] = productDetail.sId;
    data['title'] = productDetail.title;
    data['price'] = productDetail.price;
    data['selectedAttr'] = productDetail.selectedAttr;
    data['count'] = productDetail.count;
    data['pic'] = productDetail.pic;
    //是否选中
    data["checked"] = true;
    return data;
  }

}
import 'dart:convert';
import '../model/product_detail_model_entity.dart';
import 'Storage.dart';
import '../config/Config.dart';

class CartServices {

  ///添加购物车
  static Future<void> addCart(ProductDetailModelResult productDetail) async {
    Map data = formatCartData(productDetail);

    var cartListData = await Storage.getString("cartList");
    if (cartListData == null) {
      var cartList = new List();
      cartList.add(data);
      await Storage.setString("cartList", json.encode(cartList));
    } else {
      List list = json.decode(cartListData);
      List<Map> cartList = list.cast<Map>();
      bool exist = false;
      for(var i = 0; i < cartList.length; i++) {
        var cart = cartList[i];
        if (cart["_id"] == productDetail.sId && cart["selectedAttr"] == productDetail.selectedAttr) {
          cart["count"] = cart["count"] + productDetail.count;
          exist = true;
          break;
        }
      }
      if (!exist) {
        cartList.insert(0, data);
      }
      await Storage.setString("cartList", json.encode(cartList));
    }
  }

  ///获取购物车列表
  static Future<List<Map>> getCartList() async {
    var cartListData = await Storage.getString("cartList");
    if (cartListData == null) {
      return [];
    }
    List list = json.decode(cartListData);
    return list.cast<Map>();
  }

  ///保存购物车列表
  static Future<void> saveCartList(List<Map> cartList) async {
    await Storage.setString("cartList", json.encode(cartList));
  }

  //过滤数据
  static Map formatCartData(ProductDetailModelResult productDetail) {
    final Map data = new Map<String, dynamic>();
    data['_id'] = productDetail.sId;
    data['title'] = productDetail.title;
    data['price'] = productDetail.price is num ? productDetail.price : double.parse(productDetail.price); //数据类型处理
    data['selectedAttr'] = productDetail.selectedAttr;
    data['count'] = productDetail.count;
    data['pic'] = "${Config.domain}/${productDetail.pic.replaceAll("\\", "/")}";
    //是否选中
    data["checked"] = true;
    return data;
  }

  ///获取购物车结算列表
  static Future<List<Map>> getCheckOutList() async {
    var cartListData = await Storage.getString("cartList");
    List list = json.decode(cartListData);

    List<Map> tempCheckOutList = [];
    for (var i = 0; i < list.length; i++) {
      if (list[i]["checked"]) {
        tempCheckOutList.add(list[i]);
      }
    }
    return tempCheckOutList;
  }

}
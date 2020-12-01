import 'package:flutter/material.dart';
import '../tabs/Tabs.dart';
import 'RouteError.dart';
import '../pages/ProductList.dart';
import '../pages/Search.dart';
import '../pages/ProductDetail.dart';
import '../tabs/Cart.dart';
import '../pages/login/Login.dart';
import '../pages/login/RegisterFirst.dart';
import '../pages/login/RegisterSecond.dart';
import '../pages/login/RegisterThird.dart';
import '../pages/CheckOut.dart';
import '../pages/address/AddressAdd.dart';
import '../pages/address/AddressEdit.dart';
import '../pages/address/AddressList.dart';
import '../pages/Pay.dart';
import '../pages/order/Order.dart';
import '../pages/order/OrderInfo.dart';


final routes = {
  '/': (context) => Tabs(),
  '/productList': (context, {arguments}) => ProductListPage(arguments),
  '/search': (context) => SearchPage(),
  '/productDetail': (context, {arguments}) => ProductDetailPage(arguments),
  '/cart': (context) => CartPage(),
  '/login': (context) => LoginPage(),
  '/registerFirst': (context) => RegisterFirstPage(),
  '/registerSecond': (context, {arguments}) => RegisterSecondPage(arguments),
  '/registerThird': (context, {arguments}) => RegisterThirdPage(arguments),
  '/checkOut': (context) => CheckOutPage(),
  '/addressAdd': (context) => AddressAddPage(),
  '/addressEdit': (context, {arguments}) => AddressEditPage(arguments),
  '/addressList': (context) => AddressListPage(),
  '/pay': (context) => PayPage(),
  '/order': (context) => OrderPage(),
  '/orderInfo': (context, {arguments}) => OrderInfoPage(arguments),
};

// ignore: top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
  ///统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          settings: RouteSettings(name: name),
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(
          settings: RouteSettings(name: name),
          builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return MaterialPageRoute(builder: (context) => RouteErrorPage());
};

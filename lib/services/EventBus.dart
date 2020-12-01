import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

//商品详情广播
class ProductDetailEvent {
  String name;
  ProductDetailEvent(this.name);
}

//用户中心广播
class UserInfoEvent {
  String name;
  UserInfoEvent(this.name);
}

//收货地址广播
class AddressEvent {
  String name;
  AddressEvent(this.name);
}

//结算页面广播
class CheckOutEvent {
  String name;
  CheckOutEvent(this.name);
}
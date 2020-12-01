import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../services/UserServices.dart';
import '../../services/SignServices.dart';
import '../../config/Config.dart';
import 'package:dio/dio.dart';
import '../../services/EventBus.dart';
import '../../widget/MZAlertDialog.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List _addressList = [];
  var _actionEventBus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddressList();

    this._actionEventBus = eventBus.on<AddressEvent>().listen((event) {
      print(event.name);
      _getAddressList();
    });
  }

  dispose() {
    super.dispose();
    _actionEventBus.cancel();
  }

  ///获取收货地址列表
  _getAddressList() async {
    String uid = await UserServices.getUserID();
    String salt = await UserServices.getUserSalt();
    var params = {"uid": uid, "salt": salt};
    var sign = SignServices.getSign(params);
    var api = "${Config.domain}/api/addressList?uid=$uid&sign=$sign";
    var result = await Dio().get(api);
    setState(() {
      _addressList = result.data["result"];
    });
  }

  ///修改默认收货地址
  _changeDefaultAddress(address) async {
    String uid = await UserServices.getUserID();
    String salt = await UserServices.getUserSalt();
    var params = {"uid": uid, "id": address["_id"], "salt": salt};
    params["sign"] = SignServices.getSign(params);
    params.remove("salt");
    var api = "${Config.domain}/api/changeDefaultAddress";
    var result = await Dio().post(api, data: params);
    if (result.data["success"]) {
      eventBus.fire(CheckOutEvent("切换收货地址"));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收货地址"),
      ),
      body: Container(
        child: Stack(
          children: [
            ListView.builder(
              padding: EdgeInsets.only(
                  bottom: ScreenAdapter.height(100) +
                      ScreenAdapter.getBottomBarHeight()),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    index == 0
                        ? SizedBox(
                            height: 10,
                          )
                        : Text(""),
                    ListTile(
                      leading: _addressList[index]["default_address"] == 1
                          ? Icon(
                              Icons.check,
                              color: Colors.red,
                            )
                          : null,
                      title: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${_addressList[index]["name"]} ${_addressList[index]["phone"]}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${_addressList[index]["address"]}",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        onTap: () {
                          _changeDefaultAddress(_addressList[index]);
                        },
                        onLongPress: () {
                          showDialog(context: context, builder: (context) {
                            return MZAlertDialog("提示", "确您确认要删除吗？",confirm: () async {
                              String uid = await UserServices.getUserID();
                              String salt = await UserServices.getUserSalt();
                              var params = {"uid": uid, "id": _addressList[index]["_id"], "salt": salt};
                              params["sign"] = SignServices.getSign(params);
                              params.remove("salt");
                              var api = "${Config.domain}/api/deleteAddress";
                              var result = await Dio().post(api, data: params);
                              if (result.data["success"]) {
                                eventBus.fire(CheckOutEvent("删除收货地址"));
                                _getAddressList();
                              }
                            },);
                          });
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/addressEdit",
                              arguments: {'address': _addressList[index]});
                        },
                      ),
                    ),
                    Divider(
                      height: 20,
                    ),
                  ],
                );
              },
              itemCount: _addressList.length,
            ),
            Positioned(
              bottom: ScreenAdapter.getBottomBarHeight(),
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              child: Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(100),
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black12))),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        "增加收获地址",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/addressAdd");
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

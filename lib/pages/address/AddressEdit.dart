import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../widget/MZButton.dart';
import '../../services/UserServices.dart';
import '../../services/SignServices.dart';
import '../../config/Config.dart';
import 'package:dio/dio.dart';
import '../../services/EventBus.dart';

class AddressEditPage extends StatefulWidget {

  final Map arguments;

  @override
  _AddressEditPageState createState() => _AddressEditPageState();

  AddressEditPage(this.arguments);
}

class _AddressEditPageState extends State<AddressEditPage> {

  String _area;
  String _id;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _area = widget.arguments["address"]["address"].split(" ")[0];
    _id = widget.arguments["address"]["_id"];
    _addressController.text = widget.arguments["address"]["address"].split(" ")[1];
    _nameController.text = widget.arguments["address"]["name"];
    _phoneController.text = widget.arguments["address"]["phone"];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    eventBus.fire(AddressEvent("修改成功"));
    eventBus.fire(CheckOutEvent("修改收货地址"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("修改收货地址"),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: ScreenAdapter.width(100),
              padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "收货人姓名",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: ScreenAdapter.width(100),
              padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                maxLength: 11,
                decoration: InputDecoration(
                  hintText: "收货人电话",
                  border: InputBorder.none,
                  counterText: "",
                ),
              ),
            ),
            Container(
              height: ScreenAdapter.width(100),
              padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: InkWell(
                child: Row(
                  children: [
                    Icon(Icons.add_location),
                    Text(
                      _area.length == 0 ? "省/市/区" : _area,
                      style: TextStyle(color: Colors.black54),
                    )
                  ],
                ),
                onTap: () async {
                  Result result = await CityPickers.showCityPicker(
                      context: context,
                      height: ScreenAdapter.width(500),
                      confirmWidget: Text(
                        "确定",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ));
                  if (result != null) {
                    setState(() {
                      _area =
                      "${result.provinceName}/${result.cityName}/${result.areaName}";
                    });
                  }
                },
              ),
            ),
            Container(
              height: ScreenAdapter.width(300),
              padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: TextField(
                controller: _addressController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "详细地址",
                  border: InputBorder.none,
                ),
              ),
            ),
            MZButton(
              title: "修改",
              margin: EdgeInsets.only(top: 20),
              width: ScreenAdapter.width(600),
              height: 44,
              color: Colors.red,
              style: TextStyle(color: Colors.white, fontSize: 16),
              onTap: () async {
                String uid = await UserServices.getUserID();
                String salt = await UserServices.getUserSalt();
                var params = {
                  "uid": uid,
                  "id": _id,
                  "name": _nameController.text,
                  "phone": _phoneController.text,
                  "address": "$_area ${_addressController.text}",
                  "salt": salt
                };
                params["sign"] = SignServices.getSign(params);
                params.remove("salt");
                var api = "${Config.domain}/api/editAddress";
                var result = await Dio().post(api, data: params);
                print(params);
                if (result.data["success"]) {
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
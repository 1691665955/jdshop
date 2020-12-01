import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../config/Config.dart';
import '../../services/UserServices.dart';
import '../../tabs/Tabs.dart';

class RegisterThirdPage extends StatefulWidget {
  final Map arguments;

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();

  RegisterThirdPage(this.arguments);
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  String _tel;
  String _code;
  String _password = "";
  String _rePassword = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tel = widget.arguments["tel"];
    _code = widget.arguments["code"];
  }

  doRegister() async {
    if (_password.length == 0) {
      Fluttertoast.showToast(msg: "请输入密码", gravity: ToastGravity.CENTER);
      return;
    }

    if (_password.length < 6) {
      Fluttertoast.showToast(msg: "密码长度不能小于6位", gravity: ToastGravity.CENTER);
      return;
    }

    if (_rePassword != _password) {
      Fluttertoast.showToast(msg: "密码和确认密码不一致", gravity: ToastGravity.CENTER);
      return;
    }

    var api = "${Config.domain}/api/register";
    var response = await Dio()
        .post(api, data: {"tel": _tel, "code": _code, "password": _password});
    print(response.data.toString());
    if (response.data["success"]) {
      await UserServices.saveUserInfo(response.data["userinfo"][0]);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Tabs()),
          (route) => route == null);
    } else {
      Fluttertoast.showToast(
          msg: response.data["message"], gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册-第三步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: [
            SizedBox(
              height: ScreenAdapter.width(60),
            ),
            TextField(
              obscureText: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: "请输入密码",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black12)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black45)),
                  contentPadding:
                      EdgeInsets.only(left: ScreenAdapter.width(20))),
              onChanged: (string) {
                _password = string;
              },
            ),
            TextField(
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  hintText: "请输入确认密码",
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black12)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black45)),
                  contentPadding:
                      EdgeInsets.only(left: ScreenAdapter.width(20))),
              onChanged: (string) {
                _rePassword = string;
              },
            ),
            Container(
              width: double.infinity,
              height: 44,
              margin: EdgeInsets.only(top: ScreenAdapter.width(40)),
              padding: EdgeInsets.fromLTRB(
                  ScreenAdapter.width(20), 0, ScreenAdapter.width(20), 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "注册",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: doRegister,
              ),
            )
          ],
        ),
      ),
    );
  }
}

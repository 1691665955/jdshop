import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../config/Config.dart';
import '../../services/UserServices.dart';
import '../../services/EventBus.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = "";
  String _password = "";

  dispose() {
    super.dispose();
    eventBus.fire(UserInfoEvent("登录成功"));
  }

  login() async {
    RegExp regExp = RegExp(r"^1\d{10}$");
    if (regExp.hasMatch(_username)) {
      if (_password.length == 0) {
        Fluttertoast.showToast(msg: "请输入密码", gravity: ToastGravity.CENTER);
        return;
      }
      if (_password.length < 6) {
        Fluttertoast.showToast(msg: "密码不正确", gravity: ToastGravity.CENTER);
        return;
      }
      var api = "${Config.domain}/api/doLogin";
      var response = await Dio().post(api, data: {"username": _username, "password":_password});
      print(response.data.toString());
      if (response.data["success"]) {
        UserServices.saveUserInfo(response.data["userinfo"][0]);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: response.data["message"], gravity: ToastGravity.CENTER);
      }
    } else {
      Fluttertoast.showToast(msg: "手机号码格式错误", gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          InkWell(
            child: Container(
              width: 60,
              height: 48,
              alignment: Alignment.center,
              child: Text(
                "客服",
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
            onTap: () {
              print("客服");
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: [
            Container(
              width: ScreenAdapter.width(200),
              height: ScreenAdapter.width(200),
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(
                  0, ScreenAdapter.width(40), 0, ScreenAdapter.width(20)),
              child: Image.network(
                "https://www.itying.com/images/flutter/list5.jpg",
                fit: BoxFit.cover,
              ),
            ),
            TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              maxLength: 11,
              decoration: InputDecoration(
                  hintText: "请输入用户名",
                  counter: Text(""),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black12)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black45)),
                  contentPadding:
                      EdgeInsets.only(left: ScreenAdapter.width(20))),
              onChanged: (string) {
                _username = string;
              },
            ),
            TextField(
              obscureText: true,
              textInputAction: TextInputAction.done,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Container(
                    height: ScreenAdapter.width(80),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
                    child: Text(
                      "忘记密码",
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(24),
                          color: Colors.black87),
                    ),
                  ),
                  onTap: () {
                    print("忘记密码");
                  },
                ),
                InkWell(
                  child: Container(
                    height: ScreenAdapter.width(80),
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    child: Text(
                      "新用户注册",
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(24),
                          color: Colors.black87),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/registerFirst');
                  },
                ),
              ],
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
                  "登录",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: login,
              ),
            )
          ],
        ),
      ),
    );
  }
}

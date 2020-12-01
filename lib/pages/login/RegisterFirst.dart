import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../config/Config.dart';

class RegisterFirstPage extends StatefulWidget {
  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String _tel = "";
  
  sendCode() async {
    RegExp regExp = RegExp(r"^1\d{10}$");
    if (regExp.hasMatch(_tel)) {
      var api = "${Config.domain}/api/sendcode";
      var response = await Dio().post(api, data: {"tel": _tel});
      print(response.data.toString());
      if (response.data["success"]) {
        Navigator.pushNamed(context, "/registerSecond",arguments: {"tel":_tel});
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
        title: Text("用户注册-第一步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: [
            SizedBox(height: ScreenAdapter.width(40),),
            TextField(
              maxLength: 11,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  hintText: "请输入手机号",
                  counter: Text(""),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black12
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black12
                      )
                  ),
                  contentPadding: EdgeInsets.only(left: ScreenAdapter.width(20))
              ),
              onChanged: (string) {
                _tel = string;
              },
            ),
            Container(
              width: double.infinity,
              height: 44,
              margin: EdgeInsets.only(top: ScreenAdapter.width(40)),
              padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20), 0, ScreenAdapter.width(20), 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Text("下一步",style: TextStyle(
                    fontSize: 18
                ),),
                onPressed: sendCode,
              ),
            )
          ],
        ),
      ),
    );
  }
}

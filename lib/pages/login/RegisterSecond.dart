import 'dart:async';//Timer
import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../config/Config.dart';

class RegisterSecondPage extends StatefulWidget {
  final Map arguments;

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();

  RegisterSecondPage(this.arguments);
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {

  String _tel;
  String _code;
  bool _sendCodeBtn = false;
  int _countdown = 10;
  Timer _t;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_t != null) {
      _t.cancel();
      _t = null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tel = widget.arguments["tel"];
    _showTimer();
  }

  //倒计时
  _showTimer() {
    _t = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
      });
      if (_countdown == 0) {
        //清楚定时器
        timer.cancel();
        timer = null;
        setState(() {
          _sendCodeBtn = true;
        });
      }
    });
  }

  //发送验证码
  sendCode() async {
    var api = "${Config.domain}/api/sendcode";
    var response = await Dio().post(api, data: {"tel": _tel});
    print(response.data.toString());
    if (response.data["success"]) {
      setState(() {
        _countdown = 10;
        _sendCodeBtn = false;
        _showTimer();
      });
    } else {
      Fluttertoast.showToast(msg: response.data["message"], gravity: ToastGravity.CENTER);
    }
  }

  //验证验证码
  validateCode() async {
    var api = "${Config.domain}/api/validateCode";
    var response = await Dio().post(api, data: {"tel": _tel, "code":_code});
    print(response.data.toString());
    if (response.data["success"]) {
      if (_t != null) {
        _t.cancel();
        _t = null;
      }
      Navigator.pushNamed(context, "/registerThird",arguments: {
        "tel": _tel,
        "code": _code
      });
    } else {
      Fluttertoast.showToast(msg: response.data["message"], gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册-第二步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: [
            SizedBox(height: ScreenAdapter.width(40),),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20), 0, ScreenAdapter.width(20), 0),
              child: Text("验证码已经发送到您的$_tel手机，请输入$_tel手机号收到的验证码"),
            ),
            SizedBox(height: ScreenAdapter.width(40),),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black45
                  )
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: ScreenAdapter.width(480),
                    child: TextField(
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          hintText: "请输入验证码",
                          counter: Text(""),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: ScreenAdapter.width(20))
                      ),
                      onChanged: (string) {
                        _code = string;
                      },
                    ),
                  ),
                  Container(
                    width: ScreenAdapter.width(220),
                    child: _sendCodeBtn?RaisedButton(
                      child: Text("重新发送",style: TextStyle(fontSize: 14),),
                      color: Colors.grey,
                      textColor: Colors.black54,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                      ),
                      padding: EdgeInsets.all(5),
                      onPressed: sendCode,
                    ):RaisedButton(
                      child: Text("$_countdown秒后重发",style: TextStyle(fontSize: 14),),
                      color: Colors.grey,
                      textColor: Colors.black54,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                  )
                ],
              ),
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
                onPressed: validateCode,
              ),
            )
          ],
        ),
      ),
    );
  }
}

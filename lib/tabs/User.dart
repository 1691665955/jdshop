import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import 'package:flutter/services.dart';
import '../services/UserServices.dart';
import '../services/EventBus.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  
  String _username = "";
  bool _isLogin = false;
  var _actionEventBus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    _getUserInfo();

    _actionEventBus = eventBus.on<UserInfoEvent>().listen((event) {
      _getUserInfo();
    });
  }

  dispose() {
    super.dispose();
    _actionEventBus.cancel();
  }

  _getUserInfo() async {
    bool isLogin = await UserServices.getUserLoginState();
    String username = await UserServices.getUsername();
    setState(() {
      _isLogin = isLogin;
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,//解决状态栏占位问题
        controller: ScrollController(keepScrollOffset: false),
        children: [
          Container(
            height: ScreenAdapter.width(220)+ScreenAdapter.getStatusBarHeight(),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/user_bg.jpg"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                SizedBox(height: ScreenAdapter.getStatusBarHeight(),),
                Container(
                  height: ScreenAdapter.width(220),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ClipOval(
                          child: Image.asset(
                            "images/user.png",
                            fit: BoxFit.cover,
                            width: ScreenAdapter.width(100),
                            height: ScreenAdapter.width(100),
                          ),
                        ),
                      ),
                      _isLogin?Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("用户名：${_username.replaceRange(3, 7, "****")}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenAdapter.fontSize(32)
                              ),),
                            Text("普通会员",style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenAdapter.fontSize(24)
                            ),)
                          ],
                        ),
                      ):Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Container(
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "登录/注册",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenAdapter.fontSize(32)),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/login");
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.assignment,
              color: Colors.red,
            ),
            title: Text("全部订单"),
            onTap: () {
              Navigator.pushNamed(context, "/order");
            },
          ),
          Divider(height: 1,),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Colors.green,
            ),
            title: Text("待付款"),
          ),
          Divider(height: 1,),
          ListTile(
            leading: Icon(
              Icons.local_car_wash,
              color: Colors.orange,
            ),
            title: Text("待收货"),
          ),
          Container(
            height: 10,
            width: double.infinity,
            color: Color.fromRGBO(242, 242, 242, 0.9),
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.lightGreen,
            ),
            title: Text("我的收藏"),
          ),
          Divider(height: 1,),
          ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.black45,
            ),
            title: Text("在线客服"),
          ),
          Divider(height: 1,),
          _isLogin?Container(
            margin: EdgeInsets.fromLTRB(ScreenAdapter.width(40), ScreenAdapter.width(40), ScreenAdapter.width(40), 0),
            height: 44,
            child: RaisedButton(
              child: Text("退出登录"),
              textColor: Colors.white,
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              onPressed: () async {
                await UserServices.logout();
                _getUserInfo();
              },
            ),
          ):Text("")
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'Storage.dart';

class UserServices {

  ///存储登录信息
  static Future<void> saveUserInfo(Map userInfo) async {
    await Storage.setString("userInfo", json.encode(userInfo));
  }

  ///获取登录状态
  static Future<bool> getUserLoginState() async {
    var data = await Storage.getString("userInfo");
    return data != null;
  }

  ///获取用户ID
  static Future<String> getUserID() async {
    var data = await Storage.getString("userInfo");
    if (data == null) {
      return "";
    }
    var userInfo = json.decode(data);
    return userInfo["_id"];
  }

  ///获取用户名
  static Future<String> getUsername() async {
    var data = await Storage.getString("userInfo");
    if (data == null) {
      return "";
    }
    var userInfo = json.decode(data);
    return userInfo["username"];
  }

  ///获取用户手机号
  static Future<String> getUserTel() async {
    var data = await Storage.getString("userInfo");
    if (data == null) {
      return "";
    }
    var userInfo = json.decode(data);
    return userInfo["tel"];
  }

  ///获取登录salt
  static Future<String> getUserSalt() async {
    var data = await Storage.getString("userInfo");
    if (data == null) {
      return "";
    }
    var userInfo = json.decode(data);
    return userInfo["salt"];
  }

  ///退出登录
  static Future<void> logout() async {
    await Storage.remove("userInfo");
  }

}
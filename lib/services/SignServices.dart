import 'package:crypto/crypto.dart';
import 'dart:convert';

class SignServices {
  static String getSign(params) {
    var attrKeys = params.keys.toList();
    attrKeys.sort();
    String str = "";
    for (var i = 0; i < attrKeys.length; i++) {
      str += "${attrKeys[i]}${params[attrKeys[i]]}";
    }
    return md5.convert(utf8.encode(str)).toString();
  }
}
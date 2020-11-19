import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  ///初始化屏幕适配器
  ///context 当前页面上下文
  static init(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);
  }

  ///适配高度
  ///height 设计稿高度
  static height(double height) {
    return height.h;
  }

  ///适配宽度
  ///width 设计稿宽度
  static width(double width) {
    return width.w;
  }

  ///字体大小适配
  ///fontSize 设计稿字体大小
  static fontSize(double fontSize) {
    return fontSize.sp;
  }

  ///获取屏幕宽度 单位dp
  static getScreenWidth() {
    return 1.sw;
  }

  ///获取屏幕高度 单位dp
  static getScreenHeight() {
    return 1.sh;
  }

  ///获取状态栏高度 单位dp
  static getStatusBarHeight() {
    return ScreenUtil().statusBarHeight;
  }

  ///获取底部安全高度 单位dp
  static getBottomBarHeight() {
    return ScreenUtil().bottomBarHeight;
  }
}
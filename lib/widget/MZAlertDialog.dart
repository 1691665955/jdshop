import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

class MZAlertDialog extends Dialog {
  String _title;
  String _content;
  VoidCallback _confirm;
  VoidCallback _cancel;

  MZAlertDialog(title, content, {VoidCallback confirm, VoidCallback cancel}) {
    _title = title;
    _content = content;
    _confirm = confirm;
    _cancel = cancel;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: ScreenAdapter.width(600),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,//高度自适应
            children: [
              Container(
                width: double.infinity,
                height: ScreenAdapter.width(88),
                child: Center(
                  child: Text(
                      _title,
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(32),
                          color: Colors.black54
                      )
                  ),
                ),
              ),
              Divider(height: 1,),
              Padding(padding: EdgeInsets.all(ScreenAdapter.width(20)),child: Container(
                constraints: BoxConstraints(
                  minHeight: ScreenAdapter.width(180)
                ),
                child: Center(
                  child: Text(
                    _content,
                    style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(28),
                      color: Colors.black38
                    ),
                  ),
                ),
              ),),
              Divider(height: 1,),
              Container(
                width: double.infinity,
                height: ScreenAdapter.width(88),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        child: Text(
                          "确定",
                          style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(32),
                              color: Colors.black87
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          if (_confirm != null) {
                            _confirm();
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    VerticalDivider(width: 1,),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        child: Text(
                          "取消",
                          style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(32),
                              color: Colors.black26
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          if (_cancel != null) {
                            _cancel();
                          }
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
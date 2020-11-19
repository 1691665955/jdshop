import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keywords = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 36,
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(18)),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 20,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: "请输入商品名称",
                      hintStyle: TextStyle(fontSize: 14),
                      labelStyle: TextStyle(fontSize: 14),
                      contentPadding: EdgeInsets.zero, //文字垂直居中
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18))),
                  onChanged: (text){
                    _keywords = text;
                  },
                ),
              )
            ],
          ),
        ),
        actions: [
          InkWell(
            child: Container(
              height: 36,
              width: 40,
              child: Row(
                children: [Text("搜索")],
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/productList',arguments: {"keywords":_keywords});
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: [
            Container(
              child: Text(
                "热搜",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Divider(),
            Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(10)),
                  margin: EdgeInsets.all(ScreenAdapter.width(20)),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius:
                          BorderRadius.circular(ScreenAdapter.width(20))),
                  child: Text(
                    "商务笔记本",
                    style: TextStyle(fontSize: ScreenAdapter.fontSize(24)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(10)),
                  margin: EdgeInsets.all(ScreenAdapter.width(20)),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius:
                          BorderRadius.circular(ScreenAdapter.width(20))),
                  child: Text(
                    "游戏笔记本",
                    style: TextStyle(fontSize: ScreenAdapter.fontSize(24)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(10)),
                  margin: EdgeInsets.all(ScreenAdapter.width(20)),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius:
                          BorderRadius.circular(ScreenAdapter.width(20))),
                  child: Text(
                    "7700K",
                    style: TextStyle(fontSize: ScreenAdapter.fontSize(24)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(10)),
                  margin: EdgeInsets.all(ScreenAdapter.width(20)),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius:
                          BorderRadius.circular(ScreenAdapter.width(20))),
                  child: Text(
                    "MacBook Pro M1",
                    style: TextStyle(fontSize: ScreenAdapter.fontSize(24)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(10)),
                  margin: EdgeInsets.all(ScreenAdapter.width(20)),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 233, 233, 0.9),
                      borderRadius:
                          BorderRadius.circular(ScreenAdapter.width(20))),
                  child: Text(
                    "商务笔记本",
                    style: TextStyle(fontSize: ScreenAdapter.fontSize(24)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: ScreenAdapter.width(40),
            ),
            Container(
              child: Text(
                "历史记录",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Column(
              children: [
                ListTile(
                  title: Text("女装",
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(28))),
                ),
                Divider(),
                ListTile(
                  title: Text("男装",
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(28))),
                ),
                Divider(),
                ListTile(
                  title: Text("MacBook",
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(28))),
                ),
                Divider(),
                ListTile(
                  title: Text("M1",
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(28))),
                ),
                Divider(),
                ListTile(
                  title: Text("苹果电脑",
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(28))),
                ),
                Divider(
                  height: 1,
                ),
              ],
            ),
            SizedBox(
              height: ScreenAdapter.width(40),
            ),
            InkWell(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: ScreenAdapter.width(500),
                  height: 44,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(233, 233, 233, 1), width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.delete), Text("清空历史记录")],
                  ),
                ),
              ),
              onTap: () {

              },
            )
          ],
        ),
      ),
    );
  }
}

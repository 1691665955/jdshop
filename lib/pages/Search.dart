import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../services/SearchServices.dart';
import '../widget/MZAlertDialog.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keywords = "";
  List<String> _searchList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSearchHistoryData();
  }

  _getSearchHistoryData() async {
    var list = await SearchServices.getSearchList();
    setState(() {
      _searchList = list;
    });
  }

  Widget _historyListWidget() {
    if (_searchList.length == 0) {
      return Text("");
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            "历史记录",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Column(
          children: _searchList.map((value) {
            return Column(
              children: [
                ListTile(
                  title: Text(value,
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(28))),
                  onTap: () {
                    SearchServices.addSearcData(value);
                    Navigator.pushReplacementNamed(context, '/productList',
                        arguments: {"keywords": value});
                  },
                  onLongPress: () {
                    showDialog(context: context, builder: (context) {
                      return MZAlertDialog("提示", "确定删除该搜索记录？",confirm: () async {
                        await SearchServices.removeSearchData(value);
                        _getSearchHistoryData();
                      },);
                    });
                  },
                ),
                Divider(),
              ],
            );
          }).toList(),
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
            showDialog(context: context, builder: (context) {
              return MZAlertDialog("提示", "确定清空历史记录？",confirm: () async {
                await SearchServices.clearSearchList();
                _getSearchHistoryData();
              },);
            });
          },
        )
      ],
    );
  }

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
                  onChanged: (text) {
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
              if (_keywords.length > 0) {
                SearchServices.addSearcData(_keywords);
              }
              Navigator.pushReplacementNamed(context, '/productList',
                  arguments: {"keywords": _keywords});
            },
          )
        ],
      ),
      body: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(ScreenAdapter.width(20)),
          child: NotificationListener(
            onNotification: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
              return false;
            },
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
                _historyListWidget()
              ],
            ),
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      ),
    );
  }
}

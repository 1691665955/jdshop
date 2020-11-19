import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/Config.dart';
import '../generated/json/base/json_convert_content.dart';
import '../model/cate_model_entity.dart';
import '../services/ScreenAdapter.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  double _childAspectRatio = 1;
  List<CateModelResult> _leftList = [];
  List<CateModelResult> _rightList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //计算右侧GridView宽高比
    var leftWidth = ScreenAdapter.width(200);
    var rightItemWidth =
        (ScreenAdapter.getScreenWidth() - leftWidth - ScreenAdapter.width(80)) /
            3;
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(32);
    _childAspectRatio = rightItemWidth / rightItemHeight;

    _getLeftCateData();
  }

  Future<void> _getLeftCateData() async {
    var api = "${Config.domain}/api/pcate";
    var result = await Dio().get(api);
    var list = JsonConvert.fromJsonAsT<CateModelEntity>(result.data).result;
    setState(() {
      _leftList = list;
    });
    if (list.length > 0) {
      CateModelResult item = list[0];
      _getRightCateData(item.sId);
    }
  }

  Future<void> _getRightCateData(String pid) async {
    var api = "${Config.domain}/api/pcate?pid=$pid";
    var result = await Dio().get(api);
    var list = JsonConvert.fromJsonAsT<CateModelEntity>(result.data).result;
    setState(() {
      _rightList = list;
    });
  }

  Widget _leftCateWidget() {
    if (_leftList.length > 0) {
      return Container(
        width: ScreenAdapter.width(200),
        height: double.infinity,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  child: Container(
                    child: Center(
                      child: Text(
                        "${_leftList[index].title}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    width: double.infinity,
                    height: ScreenAdapter.height(84),
                    color: _selectIndex == index
                        ? Color.fromRGBO(245, 245, 245, 0.9)
                        : Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      _selectIndex = index;
                      CateModelResult item = _leftList[index];
                      _getRightCateData(item.sId);
                    });
                  },
                ),
                Divider(
                  height: ScreenAdapter.height(1),
                )
              ],
            );
          },
          itemCount: _leftList.length,
        ),
      );
    } else {
      return Container(
        width: ScreenAdapter.width(200),
        height: double.infinity,
      );
    }
  }

  Widget _rightCateWidget() {
    if (_rightList.length > 0) {
      return Expanded(
          flex: 1,
          child: Container(
            height: double.infinity,
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            color: Color.fromRGBO(245, 245, 245, 0.9),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: _childAspectRatio,
                    crossAxisSpacing: ScreenAdapter.width(20),
                    mainAxisSpacing: ScreenAdapter.width(20)),
                itemCount: _rightList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(
                              "${Config.domain}/${_rightList[index].pic.replaceAll("\\", "/")}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                "${_rightList[index].title}",
                                style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(24),
                                    color: Colors.black54),
                              ),
                            ),
                            height: ScreenAdapter.height(32),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/productList",
                          arguments: {'sid': _rightList[index].sId});
                    },
                  );
                }),
          ));
    } else {
      return Expanded(
        child: Container(
          height: double.infinity,
          color: Color.fromRGBO(245, 245, 245, 0.9),
        ),
        flex: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分类"),
      ),
      body: Row(
        children: [_leftCateWidget(), _rightCateWidget()],
      ),
    );
  }
}

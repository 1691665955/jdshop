import 'Storage.dart';

class SearchServices {
  static Future<void> addSearchData(String keyword) async {
    var searchListData = await Storage.getStringList("searchList");
    if (searchListData == null) {
      searchListData = List();
    }
    if (searchListData.contains(keyword)) {
      searchListData.remove(keyword);
    }
    searchListData.insert(0, keyword);
    await Storage.setStringList("searchList", searchListData);
  }

  static Future<List<String>> getSearchList() async {
    var searchListData = await Storage.getStringList("searchList");
    if (searchListData == null) {
      return [];
    }
    return searchListData;
  }

  static Future<void> removeSearchData(String keyword) async {
    var searchListData = await Storage.getStringList("searchList");
    if (searchListData == null) {
      searchListData = List();
    }
    searchListData.remove(keyword);
    await Storage.setStringList("searchList", searchListData);
  }

  static Future<void> clearSearchList() async {
    await Storage.remove("searchList");
  }
}
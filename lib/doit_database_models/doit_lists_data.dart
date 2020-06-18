class ListData {
  int listId;
  String listName;
  String listColor;

  ListData({this.listId, this.listName, this.listColor});

  // Hàm để convert list data vào 1 map object để lưu trữ
  Map<String, dynamic> toMap() {
    var listsMap = Map<String, dynamic>();

    if (listId != null) {
      listsMap['LIST_ID'] = listId;
    }
    listsMap['LIST_NAME'] = listName;
    listsMap['LIST_COLOR'] = listColor;

    return listsMap;
  }

  // Constructor để phân tách ListData object từ một Map object
  ListData.fromListMapObject(Map<String, dynamic> listMap) {
    this.listId = listMap['LIST_ID'];
    this.listName = listMap['LIST_NAME'];
    this.listColor = listMap['LIST_COLOR'];
  }
}

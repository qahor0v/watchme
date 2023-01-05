class HistoryModel {
  String id;
  String name;
  String path;
  String url;
  String imgUrl;
  bool isDownloaded;

  HistoryModel({
    required this.id,
    required this.name,
    required this.path,
    required this.url,
    required this.imgUrl,
    required this.isDownloaded,
  });

  HistoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        path = json['path'],
        url = json['url'],
        imgUrl = json['imgUrl'],
        isDownloaded = json['isDownloaded'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "path": path,
      "url": url,
      "imgUrl": imgUrl,
      "isDownloaded": isDownloaded
    };
  }
}

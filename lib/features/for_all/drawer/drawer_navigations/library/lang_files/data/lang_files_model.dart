class LangFilesModel {
  String? language;
  List<LangFiles>? data;

  LangFilesModel({this.data, this.language});

  LangFilesModel.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    if (json['files'] != null) {
      data = <LangFiles>[];
      json['files'].forEach((v) {
        data!.add(LangFiles.fromJson(v)); 
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['language'] = language;
    if (data != null) {
      dataMap['files'] = data!.map((v) => v.toJson()).toList();
    }
    return dataMap;
  }
}

class LangFiles {
  int? id;
  String? fileName;
  String? description;
  String? url;

  LangFiles({
    this.id,
    this.fileName,
    this.description,
    this.url,
  });

  LangFiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['file_name'];
    description = json['description'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'description': description,
      'url': url,
    };
  }
}

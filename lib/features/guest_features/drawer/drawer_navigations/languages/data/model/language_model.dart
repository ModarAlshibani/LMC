class LanguageModel {
  List<Language>? data;

  LanguageModel({this.data});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Language>[];
      json['data'].forEach((v) {
        data!.add(Language.fromJson(v)); 
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    return dataMap;
  }
}

class Language {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  Language({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    description = json['Description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
      'Description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

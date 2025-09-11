class LanguagesHaveLibraryModel {
  List<LanguagesHaveLibrary>? data;

  LanguagesHaveLibraryModel({this.data});

  LanguagesHaveLibraryModel.fromJson(List<dynamic> jsonList) {
      data = jsonList.map((e) => LanguagesHaveLibrary.fromJson(e)).toList();
    
  }

}

class LanguagesHaveLibrary {
  int? id;
  String? name;
  String? description;

  LanguagesHaveLibrary({
    this.id,
    this.name,
    this.description,
  });

  LanguagesHaveLibrary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    description = json['Description'];
  }

}

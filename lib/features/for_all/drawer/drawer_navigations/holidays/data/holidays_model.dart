class HolidaysModel {
  List<Holidays>? holidays;

  HolidaysModel({this.holidays});

  HolidaysModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      holidays = <Holidays>[];
      json['data'].forEach((v) {
        holidays!.add(new Holidays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.holidays != null) {
      data['data'] =
          this.holidays!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Holidays {
  int? id;
  String? name;
  String? description;
  String? startDate;
  String? endDate;

  Holidays({
    this.id,
    this.name,
    this.description,
    this.startDate,
    this.endDate

  });

  Holidays.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    description = json['Description'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    return data;
  }
}



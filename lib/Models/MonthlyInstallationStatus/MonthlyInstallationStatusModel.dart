import 'dart:convert';
/// Jan : "0"
/// Feb : "0"
/// Mar : "122"
/// Apr : "383"
/// May : "1440"
/// Jun : "1516"
/// Jul : "2072"
/// Aug : "907"
/// Sep : "141"
/// Oct : "0"
/// Nov : "0"
/// Dec : "0"

MonthlyInstallationStatusModel monthlyInstallationStatusModelFromJson(String str) => MonthlyInstallationStatusModel.fromJson(json.decode(str));
String monthlyInstallationStatusModelToJson(MonthlyInstallationStatusModel data) => json.encode(data.toJson());
class MonthlyInstallationStatusModel {
  MonthlyInstallationStatusModel({
      String? jan, 
      String? feb, 
      String? mar, 
      String? apr, 
      String? may, 
      String? jun, 
      String? jul, 
      String? aug, 
      String? sep, 
      String? oct, 
      String? nov, 
      String? dec,}){
    _jan = jan;
    _feb = feb;
    _mar = mar;
    _apr = apr;
    _may = may;
    _jun = jun;
    _jul = jul;
    _aug = aug;
    _sep = sep;
    _oct = oct;
    _nov = nov;
    _dec = dec;
}

  MonthlyInstallationStatusModel.fromJson(dynamic json) {
    _jan = json['Jan'];
    _feb = json['Feb'];
    _mar = json['Mar'];
    _apr = json['Apr'];
    _may = json['May'];
    _jun = json['Jun'];
    _jul = json['Jul'];
    _aug = json['Aug'];
    _sep = json['Sep'];
    _oct = json['Oct'];
    _nov = json['Nov'];
    _dec = json['Dec'];
  }
  String? _jan;
  String? _feb;
  String? _mar;
  String? _apr;
  String? _may;
  String? _jun;
  String? _jul;
  String? _aug;
  String? _sep;
  String? _oct;
  String? _nov;
  String? _dec;
MonthlyInstallationStatusModel copyWith({  String? jan,
  String? feb,
  String? mar,
  String? apr,
  String? may,
  String? jun,
  String? jul,
  String? aug,
  String? sep,
  String? oct,
  String? nov,
  String? dec,
}) => MonthlyInstallationStatusModel(  jan: jan ?? _jan,
  feb: feb ?? _feb,
  mar: mar ?? _mar,
  apr: apr ?? _apr,
  may: may ?? _may,
  jun: jun ?? _jun,
  jul: jul ?? _jul,
  aug: aug ?? _aug,
  sep: sep ?? _sep,
  oct: oct ?? _oct,
  nov: nov ?? _nov,
  dec: dec ?? _dec,
);
  String? get jan => _jan;
  String? get feb => _feb;
  String? get mar => _mar;
  String? get apr => _apr;
  String? get may => _may;
  String? get jun => _jun;
  String? get jul => _jul;
  String? get aug => _aug;
  String? get sep => _sep;
  String? get oct => _oct;
  String? get nov => _nov;
  String? get dec => _dec;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Jan'] = _jan;
    map['Feb'] = _feb;
    map['Mar'] = _mar;
    map['Apr'] = _apr;
    map['May'] = _may;
    map['Jun'] = _jun;
    map['Jul'] = _jul;
    map['Aug'] = _aug;
    map['Sep'] = _sep;
    map['Oct'] = _oct;
    map['Nov'] = _nov;
    map['Dec'] = _dec;
    return map;
  }

}
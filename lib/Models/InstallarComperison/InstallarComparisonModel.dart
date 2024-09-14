import 'dart:convert';
/// tintcod : "018"
/// Instalalr : "ALI AMJAD (GUJRANWALA)                  "
/// installations : "292"

InstallarComparisonModel installarComparisonModelFromJson(String str) => InstallarComparisonModel.fromJson(json.decode(str));
String installarComparisonModelToJson(InstallarComparisonModel data) => json.encode(data.toJson());
class InstallarComparisonModel {
  InstallarComparisonModel({
      String? tintcod, 
      String? instalalr, 
      String? installations,}){
    _tintcod = tintcod;
    _instalalr = instalalr;
    _installations = installations;
}

  InstallarComparisonModel.fromJson(dynamic json) {
    _tintcod = json['tintcod'];
    _instalalr = json['Instalalr'];
    _installations = json['installations'];
  }
  String? _tintcod;
  String? _instalalr;
  String? _installations;
InstallarComparisonModel copyWith({  String? tintcod,
  String? instalalr,
  String? installations,
}) => InstallarComparisonModel(  tintcod: tintcod ?? _tintcod,
  instalalr: instalalr ?? _instalalr,
  installations: installations ?? _installations,
);
  String? get tintcod => _tintcod;
  String? get instalalr => _instalalr;
  String? get installations => _installations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tintcod'] = _tintcod;
    map['Instalalr'] = _instalalr;
    map['installations'] = _installations;
    return map;
  }

}
import 'dart:convert';
/// id : "1"
/// tctycod : "001"
/// tctydsc : "OKARA"
/// tctysts : "A"
/// tinsdat : "2024-09-02"
/// tinsusr : "74"
/// tupddat : null
/// tupdusr : null

GetActiveCity getActiveCityFromJson(String str) => GetActiveCity.fromJson(json.decode(str));
String getActiveCityToJson(GetActiveCity data) => json.encode(data.toJson());
class GetActiveCity {
  GetActiveCity({
      String? id, 
      String? tctycod, 
      String? tctydsc, 
      String? tctysts, 
      String? tinsdat, 
      String? tinsusr, 
      dynamic tupddat, 
      dynamic tupdusr,}){
    _id = id;
    _tctycod = tctycod;
    _tctydsc = tctydsc;
    _tctysts = tctysts;
    _tinsdat = tinsdat;
    _tinsusr = tinsusr;
    _tupddat = tupddat;
    _tupdusr = tupdusr;
}

  GetActiveCity.fromJson(dynamic json) {
    _id = json['id'];
    _tctycod = json['tctycod'];
    _tctydsc = json['tctydsc'];
    _tctysts = json['tctysts'];
    _tinsdat = json['tinsdat'];
    _tinsusr = json['tinsusr'];
    _tupddat = json['tupddat'];
    _tupdusr = json['tupdusr'];
  }
  String? _id;
  String? _tctycod;
  String? _tctydsc;
  String? _tctysts;
  String? _tinsdat;
  String? _tinsusr;
  dynamic _tupddat;
  dynamic _tupdusr;
GetActiveCity copyWith({  String? id,
  String? tctycod,
  String? tctydsc,
  String? tctysts,
  String? tinsdat,
  String? tinsusr,
  dynamic tupddat,
  dynamic tupdusr,
}) => GetActiveCity(  id: id ?? _id,
  tctycod: tctycod ?? _tctycod,
  tctydsc: tctydsc ?? _tctydsc,
  tctysts: tctysts ?? _tctysts,
  tinsdat: tinsdat ?? _tinsdat,
  tinsusr: tinsusr ?? _tinsusr,
  tupddat: tupddat ?? _tupddat,
  tupdusr: tupdusr ?? _tupdusr,
);
  String? get id => _id;
  String? get tctycod => _tctycod;
  String? get tctydsc => _tctydsc;
  String? get tctysts => _tctysts;
  String? get tinsdat => _tinsdat;
  String? get tinsusr => _tinsusr;
  dynamic get tupddat => _tupddat;
  dynamic get tupdusr => _tupdusr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['tctycod'] = _tctycod;
    map['tctydsc'] = _tctydsc;
    map['tctysts'] = _tctysts;
    map['tinsdat'] = _tinsdat;
    map['tinsusr'] = _tinsusr;
    map['tupddat'] = _tupddat;
    map['tupdusr'] = _tupdusr;
    return map;
  }

}
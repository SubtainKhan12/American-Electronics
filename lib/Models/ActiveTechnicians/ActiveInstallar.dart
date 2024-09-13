import 'dart:convert';
/// tintcod : "001"
/// tintdsc : "AKBAR ALI (ARIFWALA)                    "

ActiveInstallar activeInstallarFromJson(String str) => ActiveInstallar.fromJson(json.decode(str));
String activeInstallarToJson(ActiveInstallar data) => json.encode(data.toJson());
class ActiveInstallar {
  ActiveInstallar({
      String? tintcod, 
      String? tintdsc,}){
    _tintcod = tintcod;
    _tintdsc = tintdsc;
}

  ActiveInstallar.fromJson(dynamic json) {
    _tintcod = json['tintcod'];
    _tintdsc = json['tintdsc'];
  }
  String? _tintcod;
  String? _tintdsc;
ActiveInstallar copyWith({  String? tintcod,
  String? tintdsc,
}) => ActiveInstallar(  tintcod: tintcod ?? _tintcod,
  tintdsc: tintdsc ?? _tintdsc,
);
  String? get tintcod => _tintcod;
  String? get tintdsc => _tintdsc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tintcod'] = _tintcod;
    map['tintdsc'] = _tintdsc;
    return map;
  }

}
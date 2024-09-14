import 'dart:convert';
/// tintcod : "001"
/// tintdsc : "AKBAR ALI (ARIFWALA)                    "
/// tmobnum : "03453041289"

ActiveInstallar activeInstallarFromJson(String str) => ActiveInstallar.fromJson(json.decode(str));
String activeInstallarToJson(ActiveInstallar data) => json.encode(data.toJson());
class ActiveInstallar {
  ActiveInstallar({
      String? tintcod, 
      String? tintdsc, 
      String? tmobnum,}){
    _tintcod = tintcod;
    _tintdsc = tintdsc;
    _tmobnum = tmobnum;
}

  ActiveInstallar.fromJson(dynamic json) {
    _tintcod = json['tintcod'];
    _tintdsc = json['tintdsc'];
    _tmobnum = json['tmobnum'];
  }
  String? _tintcod;
  String? _tintdsc;
  String? _tmobnum;
ActiveInstallar copyWith({  String? tintcod,
  String? tintdsc,
  String? tmobnum,
}) => ActiveInstallar(  tintcod: tintcod ?? _tintcod,
  tintdsc: tintdsc ?? _tintdsc,
  tmobnum: tmobnum ?? _tmobnum,
);
  String? get tintcod => _tintcod;
  String? get tintdsc => _tintdsc;
  String? get tmobnum => _tmobnum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tintcod'] = _tintcod;
    map['tintdsc'] = _tintdsc;
    map['tmobnum'] = _tmobnum;
    return map;
  }

}
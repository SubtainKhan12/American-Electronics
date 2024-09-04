import 'dart:convert';
/// ttrnnum : "000259"
/// ttrndat : "2024-04-19"
/// tcstnam : "SAIMA SAJJAD                            "
/// tmobnum : "03004633288"
/// tcmpsts : "C"

CancledInstallationModel cancledInstallationModelFromJson(String str) => CancledInstallationModel.fromJson(json.decode(str));
String cancledInstallationModelToJson(CancledInstallationModel data) => json.encode(data.toJson());
class CancledInstallationModel {
  CancledInstallationModel({
      String? ttrnnum, 
      String? ttrndat, 
      String? tcstnam, 
      String? tmobnum, 
      String? tcmpsts,}){
    _ttrnnum = ttrnnum;
    _ttrndat = ttrndat;
    _tcstnam = tcstnam;
    _tmobnum = tmobnum;
    _tcmpsts = tcmpsts;
}

  CancledInstallationModel.fromJson(dynamic json) {
    _ttrnnum = json['ttrnnum'];
    _ttrndat = json['ttrndat'];
    _tcstnam = json['tcstnam'];
    _tmobnum = json['tmobnum'];
    _tcmpsts = json['tcmpsts'];
  }
  String? _ttrnnum;
  String? _ttrndat;
  String? _tcstnam;
  String? _tmobnum;
  String? _tcmpsts;
CancledInstallationModel copyWith({  String? ttrnnum,
  String? ttrndat,
  String? tcstnam,
  String? tmobnum,
  String? tcmpsts,
}) => CancledInstallationModel(  ttrnnum: ttrnnum ?? _ttrnnum,
  ttrndat: ttrndat ?? _ttrndat,
  tcstnam: tcstnam ?? _tcstnam,
  tmobnum: tmobnum ?? _tmobnum,
  tcmpsts: tcmpsts ?? _tcmpsts,
);
  String? get ttrnnum => _ttrnnum;
  String? get ttrndat => _ttrndat;
  String? get tcstnam => _tcstnam;
  String? get tmobnum => _tmobnum;
  String? get tcmpsts => _tcmpsts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ttrnnum'] = _ttrnnum;
    map['ttrndat'] = _ttrndat;
    map['tcstnam'] = _tcstnam;
    map['tmobnum'] = _tmobnum;
    map['tcmpsts'] = _tcmpsts;
    return map;
  }

}
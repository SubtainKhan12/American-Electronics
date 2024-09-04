import 'dart:convert';
/// ttrnnum : "006437"
/// ttrndat : "2024-08-31"
/// tcstnam : "SAMI AMJAD                              "
/// tmobnum : "03334440974"
/// tcmpsts : " "

UnassignedInstallationModel unassignedInstallationModelFromJson(String str) => UnassignedInstallationModel.fromJson(json.decode(str));
String unassignedInstallationModelToJson(UnassignedInstallationModel data) => json.encode(data.toJson());
class UnassignedInstallationModel {
  UnassignedInstallationModel({
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

  UnassignedInstallationModel.fromJson(dynamic json) {
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
UnassignedInstallationModel copyWith({  String? ttrnnum,
  String? ttrndat,
  String? tcstnam,
  String? tmobnum,
  String? tcmpsts,
}) => UnassignedInstallationModel(  ttrnnum: ttrnnum ?? _ttrnnum,
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
import 'dart:convert';
/// id : "333366"
/// ttrnnum : "006560"
/// ttrndat : "2024-09-11"
/// ttrntyp : "BIL"
/// tintcod : "239"
/// ttrndsc : "@GENERAL PEARL Q ES INVRTR AC 12ID      "
/// titmcod : "PEARL Q ES 12ID"
/// titmqnt : "1"
/// tcstnam : "AHSAAN                                  "
/// tadd001 : "HARBANSPURA                             "
/// tadd002 : "LAHORE                                  "
/// tmobnum : "03347552575"
/// tfwddat : "2024-09-11"
/// tfwdtim : "18:34:32  "
/// tclsdat : null
/// tdat001 : null
/// tdat002 : null
/// tdat003 : null
/// tdat004 : null
/// trem001 : null
/// trem002 : null
/// trem003 : null
/// trem004 : null
/// tcstrem : null
/// tcmpsts : " "
/// tcmpamt : "0.00"
/// tctycod : "001"
/// tcstcod : "13-11-499"
/// titmser : "                         "
/// tvistimg1 : null
/// tvistimg2 : null
/// tvistimg3 : null
/// tvistimg4 : null
/// ttrnrem : null
/// tcmprem : null
/// tcmpcmp : null
/// tfwdrem : null
/// City : "LAHORE                        "
/// Dealer : "MADINA ELECTRONICS ABID MARKET          "

UnassignedInstallationModel unassignedInstallationModelFromJson(String str) => UnassignedInstallationModel.fromJson(json.decode(str));
String unassignedInstallationModelToJson(UnassignedInstallationModel data) => json.encode(data.toJson());
class UnassignedInstallationModel {
  UnassignedInstallationModel({
      String? id, 
      String? ttrnnum, 
      String? ttrndat, 
      String? ttrntyp, 
      String? tintcod, 
      String? ttrndsc, 
      String? titmcod, 
      String? titmqnt, 
      String? tcstnam, 
      String? tadd001, 
      String? tadd002, 
      String? tmobnum, 
      String? tfwddat, 
      String? tfwdtim, 
      dynamic tclsdat, 
      dynamic tdat001, 
      dynamic tdat002, 
      dynamic tdat003, 
      dynamic tdat004, 
      dynamic trem001, 
      dynamic trem002, 
      dynamic trem003, 
      dynamic trem004, 
      dynamic tcstrem, 
      String? tcmpsts, 
      String? tcmpamt, 
      String? tctycod, 
      String? tcstcod, 
      String? titmser, 
      dynamic tvistimg1, 
      dynamic tvistimg2, 
      dynamic tvistimg3, 
      dynamic tvistimg4, 
      dynamic ttrnrem, 
      dynamic tcmprem, 
      dynamic tcmpcmp, 
      dynamic tfwdrem, 
      String? city, 
      String? dealer,}){
    _id = id;
    _ttrnnum = ttrnnum;
    _ttrndat = ttrndat;
    _ttrntyp = ttrntyp;
    _tintcod = tintcod;
    _ttrndsc = ttrndsc;
    _titmcod = titmcod;
    _titmqnt = titmqnt;
    _tcstnam = tcstnam;
    _tadd001 = tadd001;
    _tadd002 = tadd002;
    _tmobnum = tmobnum;
    _tfwddat = tfwddat;
    _tfwdtim = tfwdtim;
    _tclsdat = tclsdat;
    _tdat001 = tdat001;
    _tdat002 = tdat002;
    _tdat003 = tdat003;
    _tdat004 = tdat004;
    _trem001 = trem001;
    _trem002 = trem002;
    _trem003 = trem003;
    _trem004 = trem004;
    _tcstrem = tcstrem;
    _tcmpsts = tcmpsts;
    _tcmpamt = tcmpamt;
    _tctycod = tctycod;
    _tcstcod = tcstcod;
    _titmser = titmser;
    _tvistimg1 = tvistimg1;
    _tvistimg2 = tvistimg2;
    _tvistimg3 = tvistimg3;
    _tvistimg4 = tvistimg4;
    _ttrnrem = ttrnrem;
    _tcmprem = tcmprem;
    _tcmpcmp = tcmpcmp;
    _tfwdrem = tfwdrem;
    _city = city;
    _dealer = dealer;
}

  UnassignedInstallationModel.fromJson(dynamic json) {
    _id = json['id'];
    _ttrnnum = json['ttrnnum'];
    _ttrndat = json['ttrndat'];
    _ttrntyp = json['ttrntyp'];
    _tintcod = json['tintcod'];
    _ttrndsc = json['ttrndsc'];
    _titmcod = json['titmcod'];
    _titmqnt = json['titmqnt'];
    _tcstnam = json['tcstnam'];
    _tadd001 = json['tadd001'];
    _tadd002 = json['tadd002'];
    _tmobnum = json['tmobnum'];
    _tfwddat = json['tfwddat'];
    _tfwdtim = json['tfwdtim'];
    _tclsdat = json['tclsdat'];
    _tdat001 = json['tdat001'];
    _tdat002 = json['tdat002'];
    _tdat003 = json['tdat003'];
    _tdat004 = json['tdat004'];
    _trem001 = json['trem001'];
    _trem002 = json['trem002'];
    _trem003 = json['trem003'];
    _trem004 = json['trem004'];
    _tcstrem = json['tcstrem'];
    _tcmpsts = json['tcmpsts'];
    _tcmpamt = json['tcmpamt'];
    _tctycod = json['tctycod'];
    _tcstcod = json['tcstcod'];
    _titmser = json['titmser'];
    _tvistimg1 = json['tvistimg1'];
    _tvistimg2 = json['tvistimg2'];
    _tvistimg3 = json['tvistimg3'];
    _tvistimg4 = json['tvistimg4'];
    _ttrnrem = json['ttrnrem'];
    _tcmprem = json['tcmprem'];
    _tcmpcmp = json['tcmpcmp'];
    _tfwdrem = json['tfwdrem'];
    _city = json['City'];
    _dealer = json['Dealer'];
  }
  String? _id;
  String? _ttrnnum;
  String? _ttrndat;
  String? _ttrntyp;
  String? _tintcod;
  String? _ttrndsc;
  String? _titmcod;
  String? _titmqnt;
  String? _tcstnam;
  String? _tadd001;
  String? _tadd002;
  String? _tmobnum;
  String? _tfwddat;
  String? _tfwdtim;
  dynamic _tclsdat;
  dynamic _tdat001;
  dynamic _tdat002;
  dynamic _tdat003;
  dynamic _tdat004;
  dynamic _trem001;
  dynamic _trem002;
  dynamic _trem003;
  dynamic _trem004;
  dynamic _tcstrem;
  String? _tcmpsts;
  String? _tcmpamt;
  String? _tctycod;
  String? _tcstcod;
  String? _titmser;
  dynamic _tvistimg1;
  dynamic _tvistimg2;
  dynamic _tvistimg3;
  dynamic _tvistimg4;
  dynamic _ttrnrem;
  dynamic _tcmprem;
  dynamic _tcmpcmp;
  dynamic _tfwdrem;
  String? _city;
  String? _dealer;
UnassignedInstallationModel copyWith({  String? id,
  String? ttrnnum,
  String? ttrndat,
  String? ttrntyp,
  String? tintcod,
  String? ttrndsc,
  String? titmcod,
  String? titmqnt,
  String? tcstnam,
  String? tadd001,
  String? tadd002,
  String? tmobnum,
  String? tfwddat,
  String? tfwdtim,
  dynamic tclsdat,
  dynamic tdat001,
  dynamic tdat002,
  dynamic tdat003,
  dynamic tdat004,
  dynamic trem001,
  dynamic trem002,
  dynamic trem003,
  dynamic trem004,
  dynamic tcstrem,
  String? tcmpsts,
  String? tcmpamt,
  String? tctycod,
  String? tcstcod,
  String? titmser,
  dynamic tvistimg1,
  dynamic tvistimg2,
  dynamic tvistimg3,
  dynamic tvistimg4,
  dynamic ttrnrem,
  dynamic tcmprem,
  dynamic tcmpcmp,
  dynamic tfwdrem,
  String? city,
  String? dealer,
}) => UnassignedInstallationModel(  id: id ?? _id,
  ttrnnum: ttrnnum ?? _ttrnnum,
  ttrndat: ttrndat ?? _ttrndat,
  ttrntyp: ttrntyp ?? _ttrntyp,
  tintcod: tintcod ?? _tintcod,
  ttrndsc: ttrndsc ?? _ttrndsc,
  titmcod: titmcod ?? _titmcod,
  titmqnt: titmqnt ?? _titmqnt,
  tcstnam: tcstnam ?? _tcstnam,
  tadd001: tadd001 ?? _tadd001,
  tadd002: tadd002 ?? _tadd002,
  tmobnum: tmobnum ?? _tmobnum,
  tfwddat: tfwddat ?? _tfwddat,
  tfwdtim: tfwdtim ?? _tfwdtim,
  tclsdat: tclsdat ?? _tclsdat,
  tdat001: tdat001 ?? _tdat001,
  tdat002: tdat002 ?? _tdat002,
  tdat003: tdat003 ?? _tdat003,
  tdat004: tdat004 ?? _tdat004,
  trem001: trem001 ?? _trem001,
  trem002: trem002 ?? _trem002,
  trem003: trem003 ?? _trem003,
  trem004: trem004 ?? _trem004,
  tcstrem: tcstrem ?? _tcstrem,
  tcmpsts: tcmpsts ?? _tcmpsts,
  tcmpamt: tcmpamt ?? _tcmpamt,
  tctycod: tctycod ?? _tctycod,
  tcstcod: tcstcod ?? _tcstcod,
  titmser: titmser ?? _titmser,
  tvistimg1: tvistimg1 ?? _tvistimg1,
  tvistimg2: tvistimg2 ?? _tvistimg2,
  tvistimg3: tvistimg3 ?? _tvistimg3,
  tvistimg4: tvistimg4 ?? _tvistimg4,
  ttrnrem: ttrnrem ?? _ttrnrem,
  tcmprem: tcmprem ?? _tcmprem,
  tcmpcmp: tcmpcmp ?? _tcmpcmp,
  tfwdrem: tfwdrem ?? _tfwdrem,
  city: city ?? _city,
  dealer: dealer ?? _dealer,
);
  String? get id => _id;
  String? get ttrnnum => _ttrnnum;
  String? get ttrndat => _ttrndat;
  String? get ttrntyp => _ttrntyp;
  String? get tintcod => _tintcod;
  String? get ttrndsc => _ttrndsc;
  String? get titmcod => _titmcod;
  String? get titmqnt => _titmqnt;
  String? get tcstnam => _tcstnam;
  String? get tadd001 => _tadd001;
  String? get tadd002 => _tadd002;
  String? get tmobnum => _tmobnum;
  String? get tfwddat => _tfwddat;
  String? get tfwdtim => _tfwdtim;
  dynamic get tclsdat => _tclsdat;
  dynamic get tdat001 => _tdat001;
  dynamic get tdat002 => _tdat002;
  dynamic get tdat003 => _tdat003;
  dynamic get tdat004 => _tdat004;
  dynamic get trem001 => _trem001;
  dynamic get trem002 => _trem002;
  dynamic get trem003 => _trem003;
  dynamic get trem004 => _trem004;
  dynamic get tcstrem => _tcstrem;
  String? get tcmpsts => _tcmpsts;
  String? get tcmpamt => _tcmpamt;
  String? get tctycod => _tctycod;
  String? get tcstcod => _tcstcod;
  String? get titmser => _titmser;
  dynamic get tvistimg1 => _tvistimg1;
  dynamic get tvistimg2 => _tvistimg2;
  dynamic get tvistimg3 => _tvistimg3;
  dynamic get tvistimg4 => _tvistimg4;
  dynamic get ttrnrem => _ttrnrem;
  dynamic get tcmprem => _tcmprem;
  dynamic get tcmpcmp => _tcmpcmp;
  dynamic get tfwdrem => _tfwdrem;
  String? get city => _city;
  String? get dealer => _dealer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ttrnnum'] = _ttrnnum;
    map['ttrndat'] = _ttrndat;
    map['ttrntyp'] = _ttrntyp;
    map['tintcod'] = _tintcod;
    map['ttrndsc'] = _ttrndsc;
    map['titmcod'] = _titmcod;
    map['titmqnt'] = _titmqnt;
    map['tcstnam'] = _tcstnam;
    map['tadd001'] = _tadd001;
    map['tadd002'] = _tadd002;
    map['tmobnum'] = _tmobnum;
    map['tfwddat'] = _tfwddat;
    map['tfwdtim'] = _tfwdtim;
    map['tclsdat'] = _tclsdat;
    map['tdat001'] = _tdat001;
    map['tdat002'] = _tdat002;
    map['tdat003'] = _tdat003;
    map['tdat004'] = _tdat004;
    map['trem001'] = _trem001;
    map['trem002'] = _trem002;
    map['trem003'] = _trem003;
    map['trem004'] = _trem004;
    map['tcstrem'] = _tcstrem;
    map['tcmpsts'] = _tcmpsts;
    map['tcmpamt'] = _tcmpamt;
    map['tctycod'] = _tctycod;
    map['tcstcod'] = _tcstcod;
    map['titmser'] = _titmser;
    map['tvistimg1'] = _tvistimg1;
    map['tvistimg2'] = _tvistimg2;
    map['tvistimg3'] = _tvistimg3;
    map['tvistimg4'] = _tvistimg4;
    map['ttrnrem'] = _ttrnrem;
    map['tcmprem'] = _tcmprem;
    map['tcmpcmp'] = _tcmpcmp;
    map['tfwdrem'] = _tfwdrem;
    map['City'] = _city;
    map['Dealer'] = _dealer;
    return map;
  }

}
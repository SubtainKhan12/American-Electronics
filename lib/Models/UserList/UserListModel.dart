import 'dart:convert';
/// id : "1"
/// tusrid : "imrangil"
/// tcashcod : null
/// tstrcod : null
/// tempcod : null
/// tttimefrm : null
/// ttimeto : null
/// tusrnam : "Imran"
/// tusrpwd : "gil1122"
/// tpassexpir : null
/// tusrsts : "Yes"
/// tusrtyp : "Admin"
/// tmobnum : "003258459"
/// temladd : "saif@gmain.com"
/// tadmineml : null
/// tappusr : null
/// tappdat : null
/// tedtusr : null
/// tedtdat : null
/// tcolcod : null
/// tloccod : null
/// tcrtdat : "2022-10-16"
/// tcrttim : null
/// tupdtim : null

UserListModel userListModelFromJson(String str) => UserListModel.fromJson(json.decode(str));
String userListModelToJson(UserListModel data) => json.encode(data.toJson());
class UserListModel {
  UserListModel({
      String? id, 
      String? tusrid, 
      dynamic tcashcod, 
      dynamic tstrcod, 
      dynamic tempcod, 
      dynamic tttimefrm, 
      dynamic ttimeto, 
      String? tusrnam, 
      String? tusrpwd, 
      dynamic tpassexpir, 
      String? tusrsts, 
      String? tusrtyp, 
      String? tmobnum, 
      String? temladd, 
      dynamic tadmineml, 
      dynamic tappusr, 
      dynamic tappdat, 
      dynamic tedtusr, 
      dynamic tedtdat, 
      dynamic tcolcod, 
      dynamic tloccod, 
      String? tcrtdat, 
      dynamic tcrttim, 
      dynamic tupdtim,}){
    _id = id;
    _tusrid = tusrid;
    _tcashcod = tcashcod;
    _tstrcod = tstrcod;
    _tempcod = tempcod;
    _tttimefrm = tttimefrm;
    _ttimeto = ttimeto;
    _tusrnam = tusrnam;
    _tusrpwd = tusrpwd;
    _tpassexpir = tpassexpir;
    _tusrsts = tusrsts;
    _tusrtyp = tusrtyp;
    _tmobnum = tmobnum;
    _temladd = temladd;
    _tadmineml = tadmineml;
    _tappusr = tappusr;
    _tappdat = tappdat;
    _tedtusr = tedtusr;
    _tedtdat = tedtdat;
    _tcolcod = tcolcod;
    _tloccod = tloccod;
    _tcrtdat = tcrtdat;
    _tcrttim = tcrttim;
    _tupdtim = tupdtim;
}

  UserListModel.fromJson(dynamic json) {
    _id = json['id'];
    _tusrid = json['tusrid'];
    _tcashcod = json['tcashcod'];
    _tstrcod = json['tstrcod'];
    _tempcod = json['tempcod'];
    _tttimefrm = json['tttimefrm'];
    _ttimeto = json['ttimeto'];
    _tusrnam = json['tusrnam'];
    _tusrpwd = json['tusrpwd'];
    _tpassexpir = json['tpassexpir'];
    _tusrsts = json['tusrsts'];
    _tusrtyp = json['tusrtyp'];
    _tmobnum = json['tmobnum'];
    _temladd = json['temladd'];
    _tadmineml = json['tadmineml'];
    _tappusr = json['tappusr'];
    _tappdat = json['tappdat'];
    _tedtusr = json['tedtusr'];
    _tedtdat = json['tedtdat'];
    _tcolcod = json['tcolcod'];
    _tloccod = json['tloccod'];
    _tcrtdat = json['tcrtdat'];
    _tcrttim = json['tcrttim'];
    _tupdtim = json['tupdtim'];
  }
  String? _id;
  String? _tusrid;
  dynamic _tcashcod;
  dynamic _tstrcod;
  dynamic _tempcod;
  dynamic _tttimefrm;
  dynamic _ttimeto;
  String? _tusrnam;
  String? _tusrpwd;
  dynamic _tpassexpir;
  String? _tusrsts;
  String? _tusrtyp;
  String? _tmobnum;
  String? _temladd;
  dynamic _tadmineml;
  dynamic _tappusr;
  dynamic _tappdat;
  dynamic _tedtusr;
  dynamic _tedtdat;
  dynamic _tcolcod;
  dynamic _tloccod;
  String? _tcrtdat;
  dynamic _tcrttim;
  dynamic _tupdtim;
UserListModel copyWith({  String? id,
  String? tusrid,
  dynamic tcashcod,
  dynamic tstrcod,
  dynamic tempcod,
  dynamic tttimefrm,
  dynamic ttimeto,
  String? tusrnam,
  String? tusrpwd,
  dynamic tpassexpir,
  String? tusrsts,
  String? tusrtyp,
  String? tmobnum,
  String? temladd,
  dynamic tadmineml,
  dynamic tappusr,
  dynamic tappdat,
  dynamic tedtusr,
  dynamic tedtdat,
  dynamic tcolcod,
  dynamic tloccod,
  String? tcrtdat,
  dynamic tcrttim,
  dynamic tupdtim,
}) => UserListModel(  id: id ?? _id,
  tusrid: tusrid ?? _tusrid,
  tcashcod: tcashcod ?? _tcashcod,
  tstrcod: tstrcod ?? _tstrcod,
  tempcod: tempcod ?? _tempcod,
  tttimefrm: tttimefrm ?? _tttimefrm,
  ttimeto: ttimeto ?? _ttimeto,
  tusrnam: tusrnam ?? _tusrnam,
  tusrpwd: tusrpwd ?? _tusrpwd,
  tpassexpir: tpassexpir ?? _tpassexpir,
  tusrsts: tusrsts ?? _tusrsts,
  tusrtyp: tusrtyp ?? _tusrtyp,
  tmobnum: tmobnum ?? _tmobnum,
  temladd: temladd ?? _temladd,
  tadmineml: tadmineml ?? _tadmineml,
  tappusr: tappusr ?? _tappusr,
  tappdat: tappdat ?? _tappdat,
  tedtusr: tedtusr ?? _tedtusr,
  tedtdat: tedtdat ?? _tedtdat,
  tcolcod: tcolcod ?? _tcolcod,
  tloccod: tloccod ?? _tloccod,
  tcrtdat: tcrtdat ?? _tcrtdat,
  tcrttim: tcrttim ?? _tcrttim,
  tupdtim: tupdtim ?? _tupdtim,
);
  String? get id => _id;
  String? get tusrid => _tusrid;
  dynamic get tcashcod => _tcashcod;
  dynamic get tstrcod => _tstrcod;
  dynamic get tempcod => _tempcod;
  dynamic get tttimefrm => _tttimefrm;
  dynamic get ttimeto => _ttimeto;
  String? get tusrnam => _tusrnam;
  String? get tusrpwd => _tusrpwd;
  dynamic get tpassexpir => _tpassexpir;
  String? get tusrsts => _tusrsts;
  String? get tusrtyp => _tusrtyp;
  String? get tmobnum => _tmobnum;
  String? get temladd => _temladd;
  dynamic get tadmineml => _tadmineml;
  dynamic get tappusr => _tappusr;
  dynamic get tappdat => _tappdat;
  dynamic get tedtusr => _tedtusr;
  dynamic get tedtdat => _tedtdat;
  dynamic get tcolcod => _tcolcod;
  dynamic get tloccod => _tloccod;
  String? get tcrtdat => _tcrtdat;
  dynamic get tcrttim => _tcrttim;
  dynamic get tupdtim => _tupdtim;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['tusrid'] = _tusrid;
    map['tcashcod'] = _tcashcod;
    map['tstrcod'] = _tstrcod;
    map['tempcod'] = _tempcod;
    map['tttimefrm'] = _tttimefrm;
    map['ttimeto'] = _ttimeto;
    map['tusrnam'] = _tusrnam;
    map['tusrpwd'] = _tusrpwd;
    map['tpassexpir'] = _tpassexpir;
    map['tusrsts'] = _tusrsts;
    map['tusrtyp'] = _tusrtyp;
    map['tmobnum'] = _tmobnum;
    map['temladd'] = _temladd;
    map['tadmineml'] = _tadmineml;
    map['tappusr'] = _tappusr;
    map['tappdat'] = _tappdat;
    map['tedtusr'] = _tedtusr;
    map['tedtdat'] = _tedtdat;
    map['tcolcod'] = _tcolcod;
    map['tloccod'] = _tloccod;
    map['tcrtdat'] = _tcrtdat;
    map['tcrttim'] = _tcrttim;
    map['tupdtim'] = _tupdtim;
    return map;
  }

}
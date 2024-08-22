/// user : {"id":"168","tusrid":"subtain","tcashcod":"11","tstrcod":"05","tempcod":"11","tttimefrm":"08:00:00","ttimeto":"20:00:00","tusrnam":"Subtain Khan Yousafi","tusrpwd":"12345678","tpassexpir":"2024-08-30","tusrsts":"Y","tusrtyp":"Installar","tmobnum":"03098855070","temladd":"subtain@gmail.com","tadmineml":"hamza@gmail.com","tappusr":"167","tappdat":"2024-08-10","tedtusr":"","tedtdat":"2024-08-10","tcolcod":"331","tloccod":null,"tcrtdat":null,"tcrttim":null,"tupdtim":null}
/// error : 200
/// message : "login success"

class LoginModel {
  LoginModel({
      User? user, 
      num? error, 
      String? message,}){
    _user = user;
    _error = error;
    _message = message;
}

  LoginModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _error = json['error'];
    _message = json['message'];
  }
  User? _user;
  num? _error;
  String? _message;
LoginModel copyWith({  User? user,
  num? error,
  String? message,
}) => LoginModel(  user: user ?? _user,
  error: error ?? _error,
  message: message ?? _message,
);
  User? get user => _user;
  num? get error => _error;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['error'] = _error;
    map['message'] = _message;
    return map;
  }

}

/// id : "168"
/// tusrid : "subtain"
/// tcashcod : "11"
/// tstrcod : "05"
/// tempcod : "11"
/// tttimefrm : "08:00:00"
/// ttimeto : "20:00:00"
/// tusrnam : "Subtain Khan Yousafi"
/// tusrpwd : "12345678"
/// tpassexpir : "2024-08-30"
/// tusrsts : "Y"
/// tusrtyp : "Installar"
/// tmobnum : "03098855070"
/// temladd : "subtain@gmail.com"
/// tadmineml : "hamza@gmail.com"
/// tappusr : "167"
/// tappdat : "2024-08-10"
/// tedtusr : ""
/// tedtdat : "2024-08-10"
/// tcolcod : "331"
/// tloccod : null
/// tcrtdat : null
/// tcrttim : null
/// tupdtim : null

class User {
  User({
      String? id, 
      String? tusrid, 
      String? tcashcod, 
      String? tstrcod, 
      String? tempcod, 
      String? tttimefrm, 
      String? ttimeto, 
      String? tusrnam, 
      String? tusrpwd, 
      String? tpassexpir, 
      String? tusrsts, 
      String? tusrtyp, 
      String? tmobnum, 
      String? temladd, 
      String? tadmineml, 
      String? tappusr, 
      String? tappdat, 
      String? tedtusr, 
      String? tedtdat, 
      String? tcolcod, 
      dynamic tloccod, 
      dynamic tcrtdat, 
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

  User.fromJson(dynamic json) {
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
  String? _tcashcod;
  String? _tstrcod;
  String? _tempcod;
  String? _tttimefrm;
  String? _ttimeto;
  String? _tusrnam;
  String? _tusrpwd;
  String? _tpassexpir;
  String? _tusrsts;
  String? _tusrtyp;
  String? _tmobnum;
  String? _temladd;
  String? _tadmineml;
  String? _tappusr;
  String? _tappdat;
  String? _tedtusr;
  String? _tedtdat;
  String? _tcolcod;
  dynamic _tloccod;
  dynamic _tcrtdat;
  dynamic _tcrttim;
  dynamic _tupdtim;
User copyWith({  String? id,
  String? tusrid,
  String? tcashcod,
  String? tstrcod,
  String? tempcod,
  String? tttimefrm,
  String? ttimeto,
  String? tusrnam,
  String? tusrpwd,
  String? tpassexpir,
  String? tusrsts,
  String? tusrtyp,
  String? tmobnum,
  String? temladd,
  String? tadmineml,
  String? tappusr,
  String? tappdat,
  String? tedtusr,
  String? tedtdat,
  String? tcolcod,
  dynamic tloccod,
  dynamic tcrtdat,
  dynamic tcrttim,
  dynamic tupdtim,
}) => User(  id: id ?? _id,
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
  String? get tcashcod => _tcashcod;
  String? get tstrcod => _tstrcod;
  String? get tempcod => _tempcod;
  String? get tttimefrm => _tttimefrm;
  String? get ttimeto => _ttimeto;
  String? get tusrnam => _tusrnam;
  String? get tusrpwd => _tusrpwd;
  String? get tpassexpir => _tpassexpir;
  String? get tusrsts => _tusrsts;
  String? get tusrtyp => _tusrtyp;
  String? get tmobnum => _tmobnum;
  String? get temladd => _temladd;
  String? get tadmineml => _tadmineml;
  String? get tappusr => _tappusr;
  String? get tappdat => _tappdat;
  String? get tedtusr => _tedtusr;
  String? get tedtdat => _tedtdat;
  String? get tcolcod => _tcolcod;
  dynamic get tloccod => _tloccod;
  dynamic get tcrtdat => _tcrtdat;
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
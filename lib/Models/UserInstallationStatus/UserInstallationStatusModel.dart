import 'dart:convert';
/// Unassigned : "2"
/// Pending : "1"
/// Installed : "0"
/// Cancelled : "336"
/// Closed : "6243"
/// Instalaltion-One : "9"
/// Instalaltion-Two : "22"
/// Instalaltion-Three : "0"
/// Instalaltion-Four : "2"
/// Name-One : "Fri"
/// Name-Two : "Thu"
/// Name-Three : "Wed"
/// Name-Four : "Tue"
/// Day-One : "13"
/// Day-Two : "12"
/// DAy-Three : "11"
/// Day-Four : "10"

UserInstallationStatusModel userInstallationStatusModelFromJson(String str) => UserInstallationStatusModel.fromJson(json.decode(str));
String userInstallationStatusModelToJson(UserInstallationStatusModel data) => json.encode(data.toJson());
class UserInstallationStatusModel {
  UserInstallationStatusModel({
      String? unassigned, 
      String? pending, 
      String? installed, 
      String? cancelled, 
      String? closed, 
      String? instalaltionOne, 
      String? instalaltionTwo, 
      String? instalaltionThree, 
      String? instalaltionFour, 
      String? nameOne, 
      String? nameTwo, 
      String? nameThree, 
      String? nameFour, 
      String? dayOne, 
      String? dayTwo, 
      String? dAyThree, 
      String? dayFour,}){
    _unassigned = unassigned;
    _pending = pending;
    _installed = installed;
    _cancelled = cancelled;
    _closed = closed;
    _instalaltionOne = instalaltionOne;
    _instalaltionTwo = instalaltionTwo;
    _instalaltionThree = instalaltionThree;
    _instalaltionFour = instalaltionFour;
    _nameOne = nameOne;
    _nameTwo = nameTwo;
    _nameThree = nameThree;
    _nameFour = nameFour;
    _dayOne = dayOne;
    _dayTwo = dayTwo;
    _dAyThree = dAyThree;
    _dayFour = dayFour;
}

  UserInstallationStatusModel.fromJson(dynamic json) {
    _unassigned = json['Unassigned'];
    _pending = json['Pending'];
    _installed = json['Installed'];
    _cancelled = json['Cancelled'];
    _closed = json['Closed'];
    _instalaltionOne = json['Instalaltion-One'];
    _instalaltionTwo = json['Instalaltion-Two'];
    _instalaltionThree = json['Instalaltion-Three'];
    _instalaltionFour = json['Instalaltion-Four'];
    _nameOne = json['Name-One'];
    _nameTwo = json['Name-Two'];
    _nameThree = json['Name-Three'];
    _nameFour = json['Name-Four'];
    _dayOne = json['Day-One'];
    _dayTwo = json['Day-Two'];
    _dAyThree = json['DAy-Three'];
    _dayFour = json['Day-Four'];
  }
  String? _unassigned;
  String? _pending;
  String? _installed;
  String? _cancelled;
  String? _closed;
  String? _instalaltionOne;
  String? _instalaltionTwo;
  String? _instalaltionThree;
  String? _instalaltionFour;
  String? _nameOne;
  String? _nameTwo;
  String? _nameThree;
  String? _nameFour;
  String? _dayOne;
  String? _dayTwo;
  String? _dAyThree;
  String? _dayFour;
UserInstallationStatusModel copyWith({  String? unassigned,
  String? pending,
  String? installed,
  String? cancelled,
  String? closed,
  String? instalaltionOne,
  String? instalaltionTwo,
  String? instalaltionThree,
  String? instalaltionFour,
  String? nameOne,
  String? nameTwo,
  String? nameThree,
  String? nameFour,
  String? dayOne,
  String? dayTwo,
  String? dAyThree,
  String? dayFour,
}) => UserInstallationStatusModel(  unassigned: unassigned ?? _unassigned,
  pending: pending ?? _pending,
  installed: installed ?? _installed,
  cancelled: cancelled ?? _cancelled,
  closed: closed ?? _closed,
  instalaltionOne: instalaltionOne ?? _instalaltionOne,
  instalaltionTwo: instalaltionTwo ?? _instalaltionTwo,
  instalaltionThree: instalaltionThree ?? _instalaltionThree,
  instalaltionFour: instalaltionFour ?? _instalaltionFour,
  nameOne: nameOne ?? _nameOne,
  nameTwo: nameTwo ?? _nameTwo,
  nameThree: nameThree ?? _nameThree,
  nameFour: nameFour ?? _nameFour,
  dayOne: dayOne ?? _dayOne,
  dayTwo: dayTwo ?? _dayTwo,
  dAyThree: dAyThree ?? _dAyThree,
  dayFour: dayFour ?? _dayFour,
);
  String? get unassigned => _unassigned;
  String? get pending => _pending;
  String? get installed => _installed;
  String? get cancelled => _cancelled;
  String? get closed => _closed;
  String? get instalaltionOne => _instalaltionOne;
  String? get instalaltionTwo => _instalaltionTwo;
  String? get instalaltionThree => _instalaltionThree;
  String? get instalaltionFour => _instalaltionFour;
  String? get nameOne => _nameOne;
  String? get nameTwo => _nameTwo;
  String? get nameThree => _nameThree;
  String? get nameFour => _nameFour;
  String? get dayOne => _dayOne;
  String? get dayTwo => _dayTwo;
  String? get dAyThree => _dAyThree;
  String? get dayFour => _dayFour;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Unassigned'] = _unassigned;
    map['Pending'] = _pending;
    map['Installed'] = _installed;
    map['Cancelled'] = _cancelled;
    map['Closed'] = _closed;
    map['Instalaltion-One'] = _instalaltionOne;
    map['Instalaltion-Two'] = _instalaltionTwo;
    map['Instalaltion-Three'] = _instalaltionThree;
    map['Instalaltion-Four'] = _instalaltionFour;
    map['Name-One'] = _nameOne;
    map['Name-Two'] = _nameTwo;
    map['Name-Three'] = _nameThree;
    map['Name-Four'] = _nameFour;
    map['Day-One'] = _dayOne;
    map['Day-Two'] = _dayTwo;
    map['DAy-Three'] = _dAyThree;
    map['Day-Four'] = _dayFour;
    return map;
  }

}
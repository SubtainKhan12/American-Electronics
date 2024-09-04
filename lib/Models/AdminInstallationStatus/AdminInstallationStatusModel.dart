import 'dart:convert';
/// Unassigned : "5"
/// Pending : "4"
/// Installed : "0"
/// Cancelled : "334"
/// Closed : "6129"
/// TwoDays : "2"
/// FiveDays : "1"
/// SevenDays : "0"
/// SevenDaysPlus : "1"

AdminInstallationStatusModel adminInstallationStatusModelFromJson(String str) => AdminInstallationStatusModel.fromJson(json.decode(str));
String adminInstallationStatusModelToJson(AdminInstallationStatusModel data) => json.encode(data.toJson());
class AdminInstallationStatusModel {
  AdminInstallationStatusModel({
      String? unassigned, 
      String? pending, 
      String? installed, 
      String? cancelled, 
      String? closed, 
      String? twoDays, 
      String? fiveDays, 
      String? sevenDays, 
      String? sevenDaysPlus,}){
    _unassigned = unassigned;
    _pending = pending;
    _installed = installed;
    _cancelled = cancelled;
    _closed = closed;
    _twoDays = twoDays;
    _fiveDays = fiveDays;
    _sevenDays = sevenDays;
    _sevenDaysPlus = sevenDaysPlus;
}

  AdminInstallationStatusModel.fromJson(dynamic json) {
    _unassigned = json['Unassigned'];
    _pending = json['Pending'];
    _installed = json['Installed'];
    _cancelled = json['Cancelled'];
    _closed = json['Closed'];
    _twoDays = json['TwoDays'];
    _fiveDays = json['FiveDays'];
    _sevenDays = json['SevenDays'];
    _sevenDaysPlus = json['SevenDaysPlus'];
  }
  String? _unassigned;
  String? _pending;
  String? _installed;
  String? _cancelled;
  String? _closed;
  String? _twoDays;
  String? _fiveDays;
  String? _sevenDays;
  String? _sevenDaysPlus;
AdminInstallationStatusModel copyWith({  String? unassigned,
  String? pending,
  String? installed,
  String? cancelled,
  String? closed,
  String? twoDays,
  String? fiveDays,
  String? sevenDays,
  String? sevenDaysPlus,
}) => AdminInstallationStatusModel(  unassigned: unassigned ?? _unassigned,
  pending: pending ?? _pending,
  installed: installed ?? _installed,
  cancelled: cancelled ?? _cancelled,
  closed: closed ?? _closed,
  twoDays: twoDays ?? _twoDays,
  fiveDays: fiveDays ?? _fiveDays,
  sevenDays: sevenDays ?? _sevenDays,
  sevenDaysPlus: sevenDaysPlus ?? _sevenDaysPlus,
);
  String? get unassigned => _unassigned;
  String? get pending => _pending;
  String? get installed => _installed;
  String? get cancelled => _cancelled;
  String? get closed => _closed;
  String? get twoDays => _twoDays;
  String? get fiveDays => _fiveDays;
  String? get sevenDays => _sevenDays;
  String? get sevenDaysPlus => _sevenDaysPlus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Unassigned'] = _unassigned;
    map['Pending'] = _pending;
    map['Installed'] = _installed;
    map['Cancelled'] = _cancelled;
    map['Closed'] = _closed;
    map['TwoDays'] = _twoDays;
    map['FiveDays'] = _fiveDays;
    map['SevenDays'] = _sevenDays;
    map['SevenDaysPlus'] = _sevenDaysPlus;
    return map;
  }

}
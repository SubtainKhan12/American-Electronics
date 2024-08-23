/// Assigned : "55"
/// Installed : "53"
/// Pending : "2"

class InstallarStatusModel {
  InstallarStatusModel({
      String? assigned, 
      String? installed, 
      String? pending,}){
    _assigned = assigned;
    _installed = installed;
    _pending = pending;
}

  InstallarStatusModel.fromJson(dynamic json) {
    _assigned = json['Assigned'];
    _installed = json['Installed'];
    _pending = json['Pending'];
  }
  String? _assigned;
  String? _installed;
  String? _pending;
InstallarStatusModel copyWith({  String? assigned,
  String? installed,
  String? pending,
}) => InstallarStatusModel(  assigned: assigned ?? _assigned,
  installed: installed ?? _installed,
  pending: pending ?? _pending,
);
  String? get assigned => _assigned;
  String? get installed => _installed;
  String? get pending => _pending;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Assigned'] = _assigned;
    map['Installed'] = _installed;
    map['Pending'] = _pending;
    return map;
  }

}
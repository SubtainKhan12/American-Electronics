/// Comp# : "003626"
/// Date : "2024-07-02"
/// Mobile : "03127885152"
/// Customer : "ADAM                                    "
/// Address 1. : "PLOTE A572 BLOCK D NORTH NAZAMABAD      "
/// Address 2. : "KARACHI                                 "
/// city : "KARACHI                       "
/// Item : "@GENERAL SMILY Q ES INVRTR AC 18ID      "
/// Serial No : "000001568D               "
/// Dealer : "RAFI & SONS KARACHI                     "
/// Assigned On : "2024-07-03"
/// Installar : "AJMAL HUSSAIN (KARACHI)                 "
/// Installar Mobile : "03093856021"
/// Date-1 : "2024-07-03"
/// Remarks-1 : "                                                            "
/// Date-2 : null
/// Remarks-2 : null
/// Date-3 : null
/// Remarks-3 : null
/// Date-4 : null
/// Remarks-4 : null
/// Close Date : "2024-07-03"
/// Status : "Installed"
/// Remarks : "GOD                                     "
/// Amount : "2000.00"

class GetComplainModel {
  GetComplainModel({
      String? comp, 
      String? date, 
      String? mobile, 
      String? customer, 
      String? address1, 
      String? address2, 
      String? city, 
      String? item, 
      String? serialNo, 
      String? dealer, 
      String? assignedOn, 
      String? installar, 
      String? installarMobile, 
      String? date1, 
      String? remarks1, 
      dynamic date2, 
      dynamic remarks2, 
      dynamic date3, 
      dynamic remarks3, 
      dynamic date4, 
      dynamic remarks4, 
      String? closeDate, 
      String? status, 
      String? remarks, 
      String? amount,}){
    _comp = comp;
    _date = date;
    _mobile = mobile;
    _customer = customer;
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _item = item;
    _serialNo = serialNo;
    _dealer = dealer;
    _assignedOn = assignedOn;
    _installar = installar;
    _installarMobile = installarMobile;
    _date1 = date1;
    _remarks1 = remarks1;
    _date2 = date2;
    _remarks2 = remarks2;
    _date3 = date3;
    _remarks3 = remarks3;
    _date4 = date4;
    _remarks4 = remarks4;
    _closeDate = closeDate;
    _status = status;
    _remarks = remarks;
    _amount = amount;
}

  GetComplainModel.fromJson(dynamic json) {
    _comp = json['Comp#'];
    _date = json['Date'];
    _mobile = json['Mobile'];
    _customer = json['Customer'];
    _address1 = json['Address 1.'];
    _address2 = json['Address 2.'];
    _city = json['city'];
    _item = json['Item'];
    _serialNo = json['Serial No'];
    _dealer = json['Dealer'];
    _assignedOn = json['Assigned On'];
    _installar = json['Installar'];
    _installarMobile = json['Installar Mobile'];
    _date1 = json['Date-1'];
    _remarks1 = json['Remarks-1'];
    _date2 = json['Date-2'];
    _remarks2 = json['Remarks-2'];
    _date3 = json['Date-3'];
    _remarks3 = json['Remarks-3'];
    _date4 = json['Date-4'];
    _remarks4 = json['Remarks-4'];
    _closeDate = json['Close Date'];
    _status = json['Status'];
    _remarks = json['Remarks'];
    _amount = json['Amount'];
  }
  String? _comp;
  String? _date;
  String? _mobile;
  String? _customer;
  String? _address1;
  String? _address2;
  String? _city;
  String? _item;
  String? _serialNo;
  String? _dealer;
  String? _assignedOn;
  String? _installar;
  String? _installarMobile;
  String? _date1;
  String? _remarks1;
  dynamic _date2;
  dynamic _remarks2;
  dynamic _date3;
  dynamic _remarks3;
  dynamic _date4;
  dynamic _remarks4;
  String? _closeDate;
  String? _status;
  String? _remarks;
  String? _amount;
GetComplainModel copyWith({  String? comp,
  String? date,
  String? mobile,
  String? customer,
  String? address1,
  String? address2,
  String? city,
  String? item,
  String? serialNo,
  String? dealer,
  String? assignedOn,
  String? installar,
  String? installarMobile,
  String? date1,
  String? remarks1,
  dynamic date2,
  dynamic remarks2,
  dynamic date3,
  dynamic remarks3,
  dynamic date4,
  dynamic remarks4,
  String? closeDate,
  String? status,
  String? remarks,
  String? amount,
}) => GetComplainModel(  comp: comp ?? _comp,
  date: date ?? _date,
  mobile: mobile ?? _mobile,
  customer: customer ?? _customer,
  address1: address1 ?? _address1,
  address2: address2 ?? _address2,
  city: city ?? _city,
  item: item ?? _item,
  serialNo: serialNo ?? _serialNo,
  dealer: dealer ?? _dealer,
  assignedOn: assignedOn ?? _assignedOn,
  installar: installar ?? _installar,
  installarMobile: installarMobile ?? _installarMobile,
  date1: date1 ?? _date1,
  remarks1: remarks1 ?? _remarks1,
  date2: date2 ?? _date2,
  remarks2: remarks2 ?? _remarks2,
  date3: date3 ?? _date3,
  remarks3: remarks3 ?? _remarks3,
  date4: date4 ?? _date4,
  remarks4: remarks4 ?? _remarks4,
  closeDate: closeDate ?? _closeDate,
  status: status ?? _status,
  remarks: remarks ?? _remarks,
  amount: amount ?? _amount,
);
  String? get comp => _comp;
  String? get date => _date;
  String? get mobile => _mobile;
  String? get customer => _customer;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get city => _city;
  String? get item => _item;
  String? get serialNo => _serialNo;
  String? get dealer => _dealer;
  String? get assignedOn => _assignedOn;
  String? get installar => _installar;
  String? get installarMobile => _installarMobile;
  String? get date1 => _date1;
  String? get remarks1 => _remarks1;
  dynamic get date2 => _date2;
  dynamic get remarks2 => _remarks2;
  dynamic get date3 => _date3;
  dynamic get remarks3 => _remarks3;
  dynamic get date4 => _date4;
  dynamic get remarks4 => _remarks4;
  String? get closeDate => _closeDate;
  String? get status => _status;
  String? get remarks => _remarks;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Comp#'] = _comp;
    map['Date'] = _date;
    map['Mobile'] = _mobile;
    map['Customer'] = _customer;
    map['Address 1.'] = _address1;
    map['Address 2.'] = _address2;
    map['city'] = _city;
    map['Item'] = _item;
    map['Serial No'] = _serialNo;
    map['Dealer'] = _dealer;
    map['Assigned On'] = _assignedOn;
    map['Installar'] = _installar;
    map['Installar Mobile'] = _installarMobile;
    map['Date-1'] = _date1;
    map['Remarks-1'] = _remarks1;
    map['Date-2'] = _date2;
    map['Remarks-2'] = _remarks2;
    map['Date-3'] = _date3;
    map['Remarks-3'] = _remarks3;
    map['Date-4'] = _date4;
    map['Remarks-4'] = _remarks4;
    map['Close Date'] = _closeDate;
    map['Status'] = _status;
    map['Remarks'] = _remarks;
    map['Amount'] = _amount;
    return map;
  }

}
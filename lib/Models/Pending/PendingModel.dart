/// Cmp # : "006285"
/// Date : "2024-08-21"
/// Customer : "ZAID                                    "
/// Address 1. : "HOUSE NO 12D BLOCK 6 PECHS SOCIETY      "
/// Address 2. : "ROYAL IN HOTEL KARACHI                  "
/// Mobile : "03333992611"
/// City : "KARACHI                       "
/// Item : "@GENERAL FANTASY ES INVERTER AC 18K I/D "
/// Serial # : "                         "
/// Qnty : "1"
/// Amount : "0.00"
/// Status : "Pending"

class PendingModel {
  PendingModel({
      String? cmp, 
      String? date, 
      String? customer, 
      String? address1, 
      String? address2, 
      String? mobile, 
      String? city, 
      String? item, 
      String? serial, 
      String? qnty, 
      String? amount, 
      String? status,}){
    _cmp = cmp;
    _date = date;
    _customer = customer;
    _address1 = address1;
    _address2 = address2;
    _mobile = mobile;
    _city = city;
    _item = item;
    _serial = serial;
    _qnty = qnty;
    _amount = amount;
    _status = status;
}

  PendingModel.fromJson(dynamic json) {
    _cmp = json['Cmp #'];
    _date = json['Date'];
    _customer = json['Customer'];
    _address1 = json['Address 1.'];
    _address2 = json['Address 2.'];
    _mobile = json['Mobile'];
    _city = json['City'];
    _item = json['Item'];
    _serial = json['Serial #'];
    _qnty = json['Qnty'];
    _amount = json['Amount'];
    _status = json['Status'];
  }
  String? _cmp;
  String? _date;
  String? _customer;
  String? _address1;
  String? _address2;
  String? _mobile;
  String? _city;
  String? _item;
  String? _serial;
  String? _qnty;
  String? _amount;
  String? _status;
PendingModel copyWith({  String? cmp,
  String? date,
  String? customer,
  String? address1,
  String? address2,
  String? mobile,
  String? city,
  String? item,
  String? serial,
  String? qnty,
  String? amount,
  String? status,
}) => PendingModel(  cmp: cmp ?? _cmp,
  date: date ?? _date,
  customer: customer ?? _customer,
  address1: address1 ?? _address1,
  address2: address2 ?? _address2,
  mobile: mobile ?? _mobile,
  city: city ?? _city,
  item: item ?? _item,
  serial: serial ?? _serial,
  qnty: qnty ?? _qnty,
  amount: amount ?? _amount,
  status: status ?? _status,
);
  String? get cmp => _cmp;
  String? get date => _date;
  String? get customer => _customer;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get mobile => _mobile;
  String? get city => _city;
  String? get item => _item;
  String? get serial => _serial;
  String? get qnty => _qnty;
  String? get amount => _amount;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Cmp #'] = _cmp;
    map['Date'] = _date;
    map['Customer'] = _customer;
    map['Address 1.'] = _address1;
    map['Address 2.'] = _address2;
    map['Mobile'] = _mobile;
    map['City'] = _city;
    map['Item'] = _item;
    map['Serial #'] = _serial;
    map['Qnty'] = _qnty;
    map['Amount'] = _amount;
    map['Status'] = _status;
    return map;
  }

}
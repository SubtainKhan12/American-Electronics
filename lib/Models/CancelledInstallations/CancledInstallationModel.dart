import 'dart:convert';
/// Cmp # : "000259"
/// Date : "2024-04-19"
/// Customer : "SAIMA SAJJAD                            "
/// Address 1. : "HOUSE NO 379 - 1 - A1 JOHAR TOWN LAHORE "
/// Address 2. : "LAHORE                                  "
/// Mobile : "03004633288"
/// City : "LAHORE                        "
/// Item : "@GENERAL GOLDSTAR ES INVERTER AC 18K I/D"
/// Serial # : "CANCEL259                "
/// Qnty : "1"
/// Amount : "0.00"
/// Status : "Cancelled"
/// Installar : "SARFRAZ MALIK (LAHORE)                  "
/// Installar Mobile : "03214467630"

CancledInstallationModel cancledInstallationModelFromJson(String str) => CancledInstallationModel.fromJson(json.decode(str));
String cancledInstallationModelToJson(CancledInstallationModel data) => json.encode(data.toJson());
class CancledInstallationModel {
  CancledInstallationModel({
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
      String? status, 
      String? installar, 
      String? installarMobile,}){
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
    _installar = installar;
    _installarMobile = installarMobile;
}

  CancledInstallationModel.fromJson(dynamic json) {
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
    _installar = json['Installar'];
    _installarMobile = json['Installar Mobile'];
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
  String? _installar;
  String? _installarMobile;
CancledInstallationModel copyWith({  String? cmp,
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
  String? installar,
  String? installarMobile,
}) => CancledInstallationModel(  cmp: cmp ?? _cmp,
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
  installar: installar ?? _installar,
  installarMobile: installarMobile ?? _installarMobile,
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
  String? get installar => _installar;
  String? get installarMobile => _installarMobile;

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
    map['Installar'] = _installar;
    map['Installar Mobile'] = _installarMobile;
    return map;
  }

}
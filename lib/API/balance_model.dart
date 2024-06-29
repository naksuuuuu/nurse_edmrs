// ignore_for_file: unnecessary_new

class UserBalance {
  bool? success;
  int? count;
  List<Balance>? balance;

  UserBalance({this.success, this.count, this.balance});

  UserBalance.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    count = json['count'];
    if (json['data'] != null) {
      balance = <Balance>[];
      json['data'].forEach((v) {
        balance!.add(new Balance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['count'] = count;
    if (balance != null) {
      data['data'] = balance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Balance {
  String? balCode;
  String? balName;
  String? balAmt;

  Balance({this.balCode, this.balName, this.balAmt});

  Balance.fromJson(Map<String, dynamic> json) {
    balCode = json['bal_code'].toString();
    balName = json['bal_name'].toString();
    balAmt = json['bal_amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bal_code'] = balCode;
    data['bal_name'] = balName;
    data['bal_amt'] = balAmt;
    return data;
  }
}

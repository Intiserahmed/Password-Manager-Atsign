class CardSacred {
  String? holder;
  String? number;
  String? securitycode;
  String? expirationdate;

  CardSacred(
      {this.holder, this.number, this.securitycode, this.expirationdate});

  CardSacred.fromJson(Map<String, dynamic> json) {
    holder = json['holder'];
    number = json['number'];
    securitycode = json['securitycode'];
    expirationdate = json['expirationdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holder'] = this.holder;
    data['number'] = this.number;
    data['securitycode'] = this.securitycode;
    data['expirationdate'] = this.expirationdate;
    return data;
  }
}

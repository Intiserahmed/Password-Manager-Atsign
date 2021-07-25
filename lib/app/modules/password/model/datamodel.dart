class PasswordSacred {
  String? login;
  String? pass;
  String? domain;

  PasswordSacred({this.login, this.pass, this.domain});

  PasswordSacred.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    pass = json['pass'];
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['pass'] = this.pass;
    data['domain'] = this.domain;
    return data;
  }
}

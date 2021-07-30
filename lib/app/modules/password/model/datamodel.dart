class PasswordSacred {
  String? login;
  String? pass;
  String? domain;
  String? sacredkey;

  PasswordSacred({this.login, this.pass, this.domain,this.sacredkey});

  PasswordSacred.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    pass = json['pass'];
    domain = json['domain'];
    sacredkey = json['sacredkey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['login'] = this.login;
    data['pass'] = this.pass;
    data['domain'] = this.domain;
    data['sacredkey'] =this.sacredkey;
    return data;
  }
}

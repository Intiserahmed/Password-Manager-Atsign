
import 'dart:convert';

List<PasswordSacred> postmodelFromJson(String str) => List<PasswordSacred>.from(json.decode(str).map((x) => PasswordSacred.fromJson(x)));

String postmodelToJson(List<PasswordSacred> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PasswordSacred {
  String? login;
  String? pass;
  String? sacredkey;

  PasswordSacred({this.login, this.pass, this.sacredkey});

  PasswordSacred.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    pass = json['pass'];
    sacredkey = json['sacredkey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['login'] = this.login;
    data['pass'] = this.pass;
    data['sacredkey'] =this.sacredkey;
    return data;
  }
}

class RequestModel {
  String? to, subject, body, name, phoneNumber, email;

  RequestModel({
    this.body,
    this.subject,
    this.to,
    this.email,
    this.name,
    this.phoneNumber,
  });

  Map<String, dynamic> toEmailJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['to'] = to;
    json['subject'] = subject;
    json['body'] = body;
    return json;
  }

  Map<String, dynamic> toMessageJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['to'] = to;
    json['body'] = body;
    return json;
  }

  Map<String, dynamic> toDailJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['phone'] = phoneNumber;

    return json;
  }

  Map<String, dynamic> toContactJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['email'] = email;
    json['name'] = name;
    json['phone'] = phoneNumber;
    return json;
  }
}

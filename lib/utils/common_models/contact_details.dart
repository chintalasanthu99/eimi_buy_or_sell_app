class ContactDetails {
  String? countryCode;
  String? mobile;
  String? email;
  String? name;

  ContactDetails({
    this.countryCode,
    this.mobile,
    this.email,
    this.name,
  });

  factory ContactDetails.fromJson(Map<String, dynamic> json) => ContactDetails(
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    email: json["email"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "mobile": mobile,
    "email": email,
    "name": name,
  };
}
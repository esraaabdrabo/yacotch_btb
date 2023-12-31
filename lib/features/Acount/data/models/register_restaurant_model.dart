class RegisterRestaurantModel {
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? commercialRegisterNumber;
  String? commercialRegisterDocument;
  int? cityId;
  String? managerName;
  String? managerPhoneNumber;
  String? managerCountryCode;

  RegisterRestaurantModel({
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.commercialRegisterNumber,
    this.commercialRegisterDocument,
    this.cityId,
    this.managerName,
    this.managerPhoneNumber,
    this.managerCountryCode,
  });

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['emailAddress'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['commercialRegisterNumber'] = commercialRegisterNumber;
    data['commercialRegisterDocument'] = commercialRegisterDocument;
    data['cityId'] = cityId;
    data['managerName'] = managerName;
    data['managerPhoneNumber'] = managerPhoneNumber;
    data['managerCountryCode'] = managerCountryCode;
    return data;
  }
}

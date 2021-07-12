class ContactModel {
  final String name;
  final String phoneNo;

  ContactModel({this.name, this.phoneNo});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNo': phoneNo,
      };

  factory ContactModel.fromJson(Map<String, dynamic> data) => new ContactModel(
        name: data['name'],
        phoneNo: data['phoneNo'],
      );
}

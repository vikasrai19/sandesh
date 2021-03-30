class UserModel {
  final String userUid;
  final String name;
  final String phoneNo;
  final String profileImg;
  final String dob;

  UserModel({this.userUid, this.name, this.phoneNo, this.profileImg, this.dob});

  Map<String, dynamic> toJson() {
    return {
      'userUid': userUid,
      'name': name,
      'phoneNo': phoneNo,
      'profileImg': profileImg,
      'dob': dob,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> data) => new UserModel(
        userUid: data['userUid'],
        name: data['name'],
        phoneNo: data['phoneNo'],
        dob: data['dob'],
        profileImg: data['profileImg'],
      );
}

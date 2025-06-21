class UserModel {
  String? name;
  String? email;
  String? photoUrl;
  String? phoneNumber;

  UserModel({this.name, this.email, this.photoUrl});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    photoUrl = json['photo_url'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['photo_url'] = photoUrl;
    data['phone_number'] = phoneNumber;
    return data;
  }
}

import 'package:spotify/domain/entities/auth/user.dart';

class UserModel {
  String? fullName;
  String? email;
  String? imageURL;

  UserModel({this.fullName, this.email, this.imageURL});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['name'];
    email = json['email'];
    imageURL = json['imageURL'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName!,
      email: email!,
      imageURL: imageURL!,
    );
  }
}

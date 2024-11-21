import 'dart:convert';
import 'package:loginappgoogle/presentation/entities/user_authorized.dart';

List<UserAuthorized> userAuthorizedModelFromJson(String str) =>
    List<UserAuthorized>.from(json
        .decode(str)
        .map((x) => UserAuthorizedModel.fromJson(x).toEntity())).toList();

class UserAuthorizedModel {
  final String name;
  final String mail;

  UserAuthorizedModel({
    required this.name,
    required this.mail,
  });

  factory UserAuthorizedModel.fromJson(Map<String, dynamic> json) =>
      UserAuthorizedModel(
        name: json["name"],
        mail: json["mail"],
      );

  UserAuthorized toEntity() => UserAuthorized(mail: mail, name: name);
}

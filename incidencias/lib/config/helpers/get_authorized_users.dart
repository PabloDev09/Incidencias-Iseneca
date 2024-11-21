import 'package:dio/dio.dart';
import 'package:loginappgoogle/presentation/entities/user_authorized.dart';
import 'package:loginappgoogle/presentation/models/user_authorized_model.dart';

class GetAuthorizedUsers 
{
final dio = Dio();

Future<List<UserAuthorized>> getHttp() async {
  final response = await dio.get('https://script.google.com/macros/s/AKfycbyAPeItieosT_Z8TGKOniLR5aXkIsEPcFpSZ2ukEuN3NjQNAQbldScS4f0T62ApcuU/exec?spreadsheetId=1QtIMqX6O-Af4qZPAz3gsNYdPwCbpUjDCskVgyzOSiJc&sheet=users');

  List<UserAuthorized> users = userAuthorizedModelFromJson(response.data);

  return users;
}
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:loginappgoogle/presentation/entities/issue.dart';
import 'package:loginappgoogle/presentation/models/issue_model.dart';

class IssuesHelpers 
{
  final Dio dio = Dio();
Future<List<Issue>> postIncidencias() async {
  try {
    Response response = await dio.post(
      'http://localhost:8888/incidencias',
      data: <String, dynamic>{},
      options: Options(
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) => status! < 500,
      ),
    );

    print("Raw Response data: ${response.data}");

    if (response.statusCode == 200) {
      // Directly parse response.data as either a String or List
      return issueModelFromJson(response.data);
    } else if (response.statusCode == 404) {
      print("No se encontraron incidencias con los criterios especificados.");
      return [];
    } else {
      print("Error inesperado: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("Error: $e");
    return [];
  }
}


  Future<bool> putIssue(String numClass, String description, String date, String mailProfessor) async {
  const String status = "En proceso";

  try {
    Response response = await dio.put(
      'http://localhost:8888/incidencias',
      
      data: IssueModel(
        numeroAula: numClass,
        correoDocente: mailProfessor, 
        fechaIncidencia: DateTime.now().millisecondsSinceEpoch, 
        descripcionIncidencia: description,
        estadoIncidencia: status,
        comentario: '',
      ).toJson(),

      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'correo-docente': mailProfessor, // Mantén este encabezado si el servidor lo espera
        },
      ),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  } catch (e) {
    print('Error al crear la incidencia: $e');
    return false;
  }
}

}


 








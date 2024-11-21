import 'dart:convert';

import 'package:loginappgoogle/presentation/entities/issue.dart';

// Parses JSON string if `str` is a string, otherwise expects a `List<dynamic>`
List<Issue> issueModelFromJson(dynamic data) {
  if (data is String) {
    // Decode JSON string into List<IssueModel>
    return List<Issue>.from(json.decode(data).map((x) => IssueModel.fromJson(x).toEntity()));
  } else if (data is List<dynamic>) {
    // Process already decoded List<dynamic> into List<IssueModel>
    return List<Issue>.from(data.map((x) => IssueModel.fromJson(x).toEntity()));
  } else {
    throw Exception("Unexpected data type for issueModelFromJson");
  }
}

String issueModelToJson(List<IssueModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IssueModel {
  final String numeroAula;
  final String correoDocente;
  final int fechaIncidencia;
  final String descripcionIncidencia;
  final String estadoIncidencia;
  final String comentario;

  IssueModel({
    required this.numeroAula,
    required this.correoDocente,
    required this.fechaIncidencia,
    required this.descripcionIncidencia,
    required this.estadoIncidencia,
    required this.comentario,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) => IssueModel(
        numeroAula: json["numeroAula"],
        correoDocente: json["correoDocente"],
        fechaIncidencia: json["fechaIncidencia"],
        descripcionIncidencia: json["descripcionIncidencia"],
        estadoIncidencia: json["estadoIncidencia"],
        comentario: json["comentario"],
      );

  Map<String, dynamic> toJson() => {
        "numeroAula": numeroAula,
        "correoDocente": correoDocente,
        "fechaIncidencia": fechaIncidencia,
        "descripcionIncidencia": descripcionIncidencia,
        "estadoIncidencia": estadoIncidencia,
        "comentario": comentario,
      };

  Issue toEntity() => Issue(
        numeroAula: numeroAula,
        correoDocente: correoDocente,
        fechaIncidencia: DateTime.fromMillisecondsSinceEpoch(fechaIncidencia),
        descripcionIncidencia: descripcionIncidencia,
        estadoIncidencia: estadoIncidencia,
        comentario: comentario,
      );
}

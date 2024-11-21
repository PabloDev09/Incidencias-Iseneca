import 'package:flutter/material.dart';
import 'package:loginappgoogle/config/helpers/issues_helpers.dart';
import 'package:loginappgoogle/presentation/entities/issue.dart';

class IssuesProvider extends ChangeNotifier {
List<Issue> issuesList = [
    Issue(
      numeroAula: "Aula 101",
      correoDocente: "pmargue0511@g.educaand.es",
      fechaIncidencia: DateTime.fromMillisecondsSinceEpoch(1731260593570) ,
      descripcionIncidencia: "La pizarra electrónica no funciona y los proyectores tienen fallas.",
      estadoIncidencia: "PENDIENTE",
      comentario: "",
    ),
    Issue(
      numeroAula: "Aula 200",
      correoDocente: "pmargue0511@g.educaand.es",
      fechaIncidencia: DateTime.fromMillisecondsSinceEpoch(1731260593570),
      descripcionIncidencia: "El raton del profesor falla.",
      estadoIncidencia: "EN PROGRESO",
      comentario: "",
    ),
    Issue(
      numeroAula: "Aula 140",
      correoDocente: "pabloguerbos@gmail.com",
      fechaIncidencia: DateTime.fromMillisecondsSinceEpoch(1731260593570),
      descripcionIncidencia: "El alumno Pablo Monterillo tiene problemas con su monitor.",
      estadoIncidencia: "PENDIENTE",
      comentario: "",
    ),
    Issue(
      numeroAula: "Aula 301",
      correoDocente: "pmargue0511@g.educaand.es",
      fechaIncidencia: DateTime.fromMillisecondsSinceEpoch(1731260593570),
      descripcionIncidencia: "El proyector no enciende.",
      estadoIncidencia: "EN PROGRESO",
      comentario: "Aula 301 sin proyector operativo.",
    ),
    Issue(
      numeroAula: "Aula 402",
      correoDocente: "pabloguerbos@gmail.com",
      fechaIncidencia: DateTime.fromMillisecondsSinceEpoch(1731260593570),
      descripcionIncidencia: "Problema con la conexión a internet.",
      estadoIncidencia: "EN PROGRESO",
      comentario: "El internet no está funcionando.",
    ),
    Issue(
      numeroAula: "Aula 503",
      correoDocente: "pmargue0511@g.educaand.es",
      fechaIncidencia: DateTime.fromMillisecondsSinceEpoch(1731260593570),
      descripcionIncidencia: "La pizarra blanca está dañada.",
      estadoIncidencia: "COMPLETADA",
      comentario: "Aula 503 necesita nueva pizarra.",
    ),
    Issue(
      numeroAula: "Aula 104",
      correoDocente: "pabloguerbos@gmail.com",
      fechaIncidencia: DateTime.fromMillisecondsSinceEpoch(1731260593570),
      descripcionIncidencia: "El ventilador está roto.",
      estadoIncidencia: "CANCELADA",
      comentario: "Aula 104 requiere reparación de ventilador.",
    ),
    Issue(
      numeroAula: "Aula 205",
      correoDocente: "pabloguerbos@gmail.com",
      fechaIncidencia: DateTime.fromMillisecondsSinceEpoch(1731260593570),
      descripcionIncidencia: "La luz del aula parpadea.",
      estadoIncidencia: "PENDIENTE",
      comentario: "Aula 205 necesita revisión de luces.",
    ),
  ];

  Future<void> chargeIssues() async 
  {
    issuesList = await IssuesHelpers().postIncidencias();
    notifyListeners();
  }

  Future<bool> createIssue(String numClass, String description, String date, String mailProfessor) async 
  {
    return await IssuesHelpers().putIssue(numClass, description, date, mailProfessor);
  }

}

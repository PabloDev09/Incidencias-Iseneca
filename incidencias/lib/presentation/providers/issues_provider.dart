import 'package:flutter/material.dart';
import 'package:loginappgoogle/config/helpers/issues_helpers.dart';
import 'package:loginappgoogle/presentation/entities/issue.dart';

class IssuesProvider extends ChangeNotifier {
List<Issue> issuesList = 
[
  Issue(numeroAula: "Aula 2", correoDocente: "rocio@g.educaand.es", fechaIncidencia: DateTime.now(), descripcionIncidencia: "Dos alumnos se han peleado", comentario: ""), 
  Issue(numeroAula: "Aula 100", correoDocente: "pacobenitez@g.educaand.es", fechaIncidencia: DateTime.now(), descripcionIncidencia: "Se ha roto un cable", comentario: "")
];
List<String> numClassesList = ["2DAM", "1DAM", "1ESO ", "2 ESO", "3 ESO", "4 ESO", "1 BACH", "2 BACH"];

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

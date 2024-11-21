class Issue {
  final String numeroAula;
  final String correoDocente;
  final DateTime fechaIncidencia;
  final String descripcionIncidencia;
  final String estadoIncidencia;
  final String comentario;

  Issue({
    required this.numeroAula,
    this.correoDocente = "",
    required this.fechaIncidencia,
    required this.descripcionIncidencia,
    this.estadoIncidencia = "",
    this.comentario  = ""
  });

  Map<String, dynamic> toJson() {
    return {
      'numeroAula': numeroAula,
      'correoDocente': correoDocente,
      'fechaIndicencia': fechaIncidencia,
      'descripcionIncidencia': descripcionIncidencia,
      'estadoIncidencia': estadoIncidencia,
      'comentario': comentario
    };
  }
}

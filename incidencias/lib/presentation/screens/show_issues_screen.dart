import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loginappgoogle/config/theme/app_theme.dart';
import 'package:loginappgoogle/presentation/auth/auth_gate.dart';
import 'package:loginappgoogle/presentation/entities/issue.dart';
import 'package:loginappgoogle/presentation/providers/issues_provider.dart';
import 'package:loginappgoogle/presentation/providers/users_provider.dart';
import 'package:loginappgoogle/presentation/screens/create_issue_screen.dart';
import 'package:provider/provider.dart';

class ShowIssuesScreen extends StatelessWidget {
  final String name = "showIssues";
  final User? user;

  const ShowIssuesScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Providers
    UsersProvider usersProvider =
        Provider.of<UsersProvider>(context, listen: true);
    IssuesProvider issuesProvider =
        Provider.of<IssuesProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
        centerTitle: true,
        title: const Text('Incidencias'),
        actions: [
          // Crear incidencia button
          FilledButton(
            onPressed: () {
              context.pushNamed(const CreateIssueScreen().name);
            },
            child: const Text('Crear incidencia'),
          ),
          const SizedBox(width: 15),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Cerrar sesión'),
                    content: const Text('¿Estás seguro de cerrar sesión?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                          usersProvider.logOut();
                          context.pushNamed(const AuthGate().name);
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Sombra suave negra
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4), // Desplazamiento de la sombra
                ),
              ],
              borderRadius: BorderRadius.circular(5),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Incidencias disponibles',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 16), 
                issuesProvider.issuesList.isEmpty
                    ? const Center(child: Text('No hay incidencias disponibles.'))
                    : Expanded(
                        child: Column(
                          children: [
                            // Encabezados de la tabla
                            Container(
                              color: AppTheme(selectedColor: 2).theme().primaryColor,
                              padding: const EdgeInsets.only(top: 25, bottom: 25),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text('Número de clase', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18))),
                                  Expanded(child: Text('Correo del Docente', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18))),
                                  Expanded(child: Text('Fecha de creación', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18))),
                                  Expanded(child: Text('Descripción', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18))),
                                  Expanded(child: Text('Comentario', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18))),
                                  Expanded(child: Text('Estado', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18))),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: issuesProvider.issuesList.length,
                                itemBuilder: (context, index) {
                                  Issue issue = issuesProvider.issuesList[index];
                                  Color colorEstado;
                                  Color? colorFondo = index % 2 == 0 ? const Color.fromARGB(255, 193, 225, 251) : const Color.fromARGB(255, 235, 246, 255);
                                  

                                  if(issue.estadoIncidencia.toUpperCase() == "PENDIENTE")
                                  {
                                    colorEstado = const Color.fromARGB(255, 245, 163, 68);
                                  }
                                  else if(issue.estadoIncidencia.toUpperCase() == "CANCELADA"){
                                    colorEstado = const Color.fromARGB(255, 255, 64, 64);
                                  }
                                  else if(issue.estadoIncidencia.toUpperCase() == "COMPLETADA")
                                  {
                                    colorEstado = const Color.fromARGB(152, 31, 253, 15);
                                  }
                                  else{
                                    colorEstado = const Color.fromARGB(255, 71, 71, 72);
                                  }

                                  Color? colorCorreo = issue.correoDocente == FirebaseAuth.instance.currentUser?.email ?  const Color.fromARGB(145, 0, 66, 165): const Color.fromARGB(255, 10, 10, 10);
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: colorFondo
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 50, bottom: 50),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(issue.numeroAula,
                                                textAlign: TextAlign.center),
                                          ),
                                          Expanded(
                                            child: Text(issue.correoDocente,
                                            style: TextStyle(color: colorCorreo),
                                                textAlign: TextAlign.center),
                                          ),
                                          Expanded(
                                            child: Text(issue.fechaIncidencia.toString(),
                                                textAlign: TextAlign.center),
                                          ),
                                          Expanded(
                                            child: Text(issue.descripcionIncidencia,
                                                textAlign: TextAlign.center),
                                          ),
                                          Expanded(
                                            child: Text(issue.comentario.isEmpty ? 'Sin comentario' : issue.comentario,
                                                textAlign: TextAlign.center),
                                          ),
                                          Expanded(
                                            child: Text(issue.estadoIncidencia,
                                                style: TextStyle(color: colorEstado , fontStyle: FontStyle.italic),
                                                textAlign: TextAlign.center),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

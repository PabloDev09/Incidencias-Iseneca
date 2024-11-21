
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loginappgoogle/presentation/auth/auth_gate.dart';
import 'package:loginappgoogle/presentation/providers/issues_provider.dart';
import 'package:loginappgoogle/presentation/providers/users_provider.dart';
import 'package:loginappgoogle/presentation/screens/show_issues_screen.dart';
import 'package:provider/provider.dart';

class CreateIssueScreen extends StatelessWidget {
  final String name = "createIssueScreen";
  const CreateIssueScreen({super.key});

  String assignDateNow(TextEditingController dateController)
  {
    // Formato de la fecha
    String formattedDate = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    // Fijar valor del dia de hoy
    dateController.text = DateTime.now().toString();
    // Formatearlo
    return dateController.text = formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    // Controladores de texto
    TextEditingController descriptionController = TextEditingController();
    TextEditingController numClassController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    assignDateNow(dateController);

    // Providers
    UsersProvider usersProvider = Provider.of<UsersProvider>(context, listen: true);
    IssuesProvider issuesProvider = Provider.of<IssuesProvider>(context, listen: true);

    // Función para seleccionar la fecha
    Future<void> selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null) {
        String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        dateController.text = formattedDate; // Actualizar el TextFormField con la fecha seleccionada
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.person),
        ),
        centerTitle: true,
        title: const Text('Incidencias'),
        actions: [
          FilledButton(
            onPressed: () {
              // Navega hacia la pantalla ShowIssuesScreen
              context.pushNamed(
                ShowIssuesScreen(user: FirebaseAuth.instance.currentUser).name
              );
            },
            child: const Text('Ver incidencia'),
          ),
          const SizedBox(
            width: 15,
          ),
          IconButton(
            onPressed: () {
              // Diálogo de confirmación para cerrar sesión
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Cerrar sesión'),
                    content: const Text('¿Estás seguro de cerrar sesión?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop(); // Cierra el diálogo sin salir
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop(); // Cierra el diálogo
                          usersProvider.logOut(); // Cierra sesión
                          context.pushNamed(const AuthGate().name); // Redirige a AuthGate
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  );
                }
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Crear incidencia',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: numClassController,
                  decoration: const InputDecoration(
                    hintText: 'Número de clase',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  maxLength: 255,
                  decoration: const InputDecoration(
                    hintText: 'Descripción de la incidencia',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    hintText: 'Fecha',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true, 
                  onTap: () {
                    selectDate(context);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Contador de pop up saltados
                    int countAlertDialog = 0;
                    // Si algun campo esta vacio
                    if(descriptionController.value.text.isEmpty || numClassController.value.text.isEmpty || dateController.value.text.isEmpty)
                    {
                      showDialog(context: context, builder: (context) {
                          return AlertDialog(
                          title: const Text('Campos vacios'),
                          content: const Text('No pueden haber campos sin valor'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                        );
                      },);
                      countAlertDialog ++;
                    }
                    // Si se ha creado correctamente la incidencia
                    if(await issuesProvider.createIssue(numClassController.value.text, descriptionController.value.text, dateController.value.text.toString(), FirebaseAuth.instance.currentUser!.email!))
                    {
                      // ignore: use_build_context_synchronously
                      showDialog(context: context, builder: (context){
                          return AlertDialog(
                          title: const Text('Indicencia creada '),
                          content: const Text('La indicencia ha sido creada'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.pop(); 
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                        );
                      },);
                      countAlertDialog++;
                    }
                    // Si no ha saltado ninguno de los pop up anteriores
                    if(countAlertDialog == 0)
                    {
                      // ignore: use_build_context_synchronously
                    showDialog(context: context, builder: (context) {
                          return AlertDialog(
                          title: const Text('Incidencia no creada'),
                          content: const Text('La incidencia no se ha podido crear'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.pop(); 
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                        );
                      },);

                    }
                      // Limpiar los formularios de numero de clase y descripcion
                      numClassController.clear();
                      descriptionController.clear();
                      // Asignar el valor de hoy al Formulario de fecha
                      assignDateNow(dateController);
                      // Fijar variable de contador de pop up a 0
                      countAlertDialog = 0;
                  },
                  child: const Text('Crear incidencia'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

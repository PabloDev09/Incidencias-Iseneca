import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loginappgoogle/presentation/providers/users_provider.dart';
import 'package:loginappgoogle/presentation/screens/show_issues_screen.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  final String name = "authGate";
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    UsersProvider usersProvider =
        Provider.of<UsersProvider>(context, listen: true);
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return FutureBuilder(
            future: Future.delayed(const Duration(seconds: 5)),
            builder: (context, delaySnapshot) {
              // Mientras el delay está en proceso, mostrar el CircularProgressIndicator
              if (delaySnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }
      
              // Si el usuario no está autenticado, mostrar SignInScreen
              if (!snapshot.hasData) {
                return SignInScreen(
                  providers: [
                    GoogleProvider(
                        clientId:
                            "671699855598-grrnc2anvdhj2gufqqskpimcgsbssb26.apps.googleusercontent.com"),
                  ],
                  subtitleBuilder: (context, action) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: action == AuthAction.signIn
                          ? const Text(
                              'Bienvenido a PMG Login App, por favor inicia sesión')
                          : const Text(
                              'Bienvenido a PMG Login App, por favor regístrate'),
                    );
                  },
                );
              }
      
              // Si el usuario está autenticado, verificar si está autorizado
              if (usersProvider.isAuthorized(snapshot.data?.email)) {
                // Usuario autorizado, mostrar ShowIssuesScreen
                return ShowIssuesScreen(user: snapshot.data);
              } else {
                // Usuario no autorizado, mostrar AlertDialog y luego SignInScreen
                return AlertDialog(
                  title: const Text('No estás autorizado'),
                  content: const Text(
                      'No tienes permisos para acceder a la página. Contacta con el administrador.'),
                  actions: [
                    FilledButton(
                      onPressed: () async {
                        usersProvider.logOut();
                        context.pushNamed(const AuthGate().name); 
                      },
                      child: const Text('Aceptar'),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginappgoogle/firebase_options.dart';
import 'package:loginappgoogle/config/routes/router.dart';
import 'package:loginappgoogle/config/theme/app_theme.dart';
import 'package:loginappgoogle/presentation/providers/issues_provider.dart';
import 'package:loginappgoogle/presentation/providers/users_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: 
      [
        ChangeNotifierProvider
        (
        lazy: false,
        create: (_) => UsersProvider()..chargeAuthorizedUsers(),
        ),
        ChangeNotifierProvider
        (
        lazy: false,
        create: (_) => IssuesProvider()..chargeIssues(),
        ),
      ],
      child: MaterialApp.router(
        theme: AppTheme(selectedColor: 2).theme(),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}

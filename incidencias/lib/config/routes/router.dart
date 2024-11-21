import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loginappgoogle/presentation/auth/auth_gate.dart';
import 'package:loginappgoogle/presentation/screens/create_issue_screen.dart';
import 'package:loginappgoogle/presentation/screens/show_issues_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: const AuthGate().name,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthGate();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          name: ShowIssuesScreen(user: FirebaseAuth.instance.currentUser).name,
          builder: (BuildContext context, GoRouterState state) {
            return ShowIssuesScreen(user: FirebaseAuth.instance.currentUser);
          },      
        ),
        GoRoute(
          path: 'signin',
          builder: (BuildContext context, GoRouterState state) {
            return const SignInScreen();
          },
        ),
        GoRoute(
          path: 'createissue',
          name: const CreateIssueScreen().name,
          builder: (BuildContext context, GoRouterState state) {
            return const CreateIssueScreen();
          },
        )
      ],
    ),
  ],
);

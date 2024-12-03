import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:meetme/providers/user_provider.dart';

import 'package:meetme/screens/home_screen.dart';
import 'package:meetme/screens/auth/login_screen.dart';
import 'package:meetme/screens/auth/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider.instance,
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) => MaterialApp(
          title: 'MeetMe',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          initialRoute: "/",
          routes: {
            "/": (context) => const HomeScreen(),
            "/register": (context) => const RegisterScreen(),
            "/login": (context) => const LoginScreen(),
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meetme/components/width_btn.dart';
import 'package:meetme/providers/user_provider.dart';
import 'package:meetme/screens/dash_screen.dart';
import 'package:meetme/screens/loading_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    Widget content = const LoadingScreen();

    if (userProvider.loginState == LoginState.success) {
      content = const DashScreen();
    } else if (userProvider.loginState == LoginState.failed) {
      content = Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32.0),
                Text("Welcome to MeetMe!",
                    style: Theme.of(context).textTheme.headlineLarge),
                const Spacer(),
                WidthBtn(
                  action: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  title: "Register",
                ),
                WidthBtn(
                  action: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  title: "Login",
                ),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      );
    }

    return content;
  }
}

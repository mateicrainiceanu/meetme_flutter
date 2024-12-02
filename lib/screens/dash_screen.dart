import 'package:flutter/material.dart';
import 'package:meetme/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(leading: null, automaticallyImplyLeading: false, actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            userProvider.logout();
          },
        ),
      ]),
      body: Center(
        child: Text(userProvider.user!.email),
      ),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_rounded), label: "Chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.pin_rounded), label: "Location"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded), label: "Profile"),
          ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meetme/screens/dash/profile_screen.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  int _currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget content = const Center(child: Text("Dash"));

    switch (_currentScreenIndex) {
      case 0:
        content = const Center(child: Text("Home"));
        break;
      case 1:
        content = const Center(child: Text("Chat"));
        break;
      case 2:
        content = const Center(child: Text("Location"));
        break;
      case 3:
        content = const ProfileScreen();
        break;
    }

    return Scaffold(
      // appBar: AppBar(leading: null, automaticallyImplyLeading: false, actions: [
      //   IconButton(
      //     icon: const Icon(Icons.logout),
      //     onPressed: () {
      //       userProvider.logout();
      //     },
      //   ),
      // ]),
      body: SafeArea(child: content),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentScreenIndex,
          onTap: (newIdx) => {
                setState(() {
                  _currentScreenIndex = newIdx;
                })
              },
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

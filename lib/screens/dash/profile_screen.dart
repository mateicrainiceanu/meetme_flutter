import 'package:flutter/material.dart';
import 'package:meetme/components/width_btn.dart';
import 'package:meetme/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 20),
              Text(
                userProvider.user!.email,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "${userProvider.user!.fname} ${userProvider.user!.lname}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              const Divider(),
              Row(
                children: [
                  Text(
                    "Email",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    userProvider.user!.email,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    "Last Name",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    userProvider.user!.lname,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    "First Name",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    userProvider.user!.fname,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    "Username",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    userProvider.user!.username,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    "Date of Birth",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    userProvider.user!.dateOfBirth
                        .toString()
                        .substring(0, 10)
                        .split("-")
                        .reversed
                        .join("."),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        WidthBtn(
          title: "Logout",
          action: () {
            userProvider.logout();
          },
          color: Colors.redAccent,
        )
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meetme/components/width_btn.dart';
import 'package:meetme/providers/user_provider.dart';
import 'package:meetme/screens/dash/components/date_updater.dart';
import 'package:meetme/screens/dash/components/profile_data_row.dart';
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
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                  ProfileDataRow(
                      title: "Email",
                      value: userProvider.user!.email,
                      paramName: "email"),
                  const Divider(),
                  ProfileDataRow(
                      title: "Last name",
                      value: userProvider.user!.lname,
                      paramName: "lname"),
                  const Divider(),
                  ProfileDataRow(
                      title: "First name",
                      value: userProvider.user!.fname,
                      paramName: "fname"),
                  const Divider(),
                  ProfileDataRow(
                      title: "Email",
                      value: userProvider.user!.email,
                      paramName: "email"),
                  const Divider(),
                  DateUpdater(
                      title: "Date of Birth",
                      value: userProvider.user!.dateOfBirth,
                      paramName: "dateOfBirth"),
                ],
              ),
            ),
          ),
          // const Spacer(),
          WidthBtn(
            title: "Logout",
            action: () {
              userProvider.logout();
            },
            color: Colors.redAccent,
          )
        ],
      ),
    );
  }
}

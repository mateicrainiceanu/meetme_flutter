import 'package:flutter/material.dart';
import 'package:meetme/models/auth_user.dart';
import 'package:meetme/providers/user_provider.dart';

class DateUpdater extends StatefulWidget {
  final String title;
  final DateTime value;
  final String paramName;

  const DateUpdater(
      {super.key,
      required this.title,
      required this.value,
      required this.paramName});

  @override
  State<DateUpdater> createState() => _DateUpdaterState();
}

class _DateUpdaterState extends State<DateUpdater> {
  DateTime? _dateOfBirth;

  @override
  void initState() {
    _dateOfBirth = widget.value;
    super.initState();
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateOfBirth = picked;
      });
    } else {
      return;
    }

    final response =
        await AuthUser.updateProfile("dateOfBirth", _dateOfBirth.toString());

    if (response.statusCode == 200) {
      //handle success
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Success"),
          backgroundColor: Colors.green,
        ),
      );
      UserProvider.instance.fetchUserData();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occured"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: Row(
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          Text(
            _dateOfBirth
                .toString()
                .substring(0, 10)
                .split("-")
                .reversed
                .join("."),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

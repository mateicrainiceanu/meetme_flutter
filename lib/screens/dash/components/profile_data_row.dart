import 'package:flutter/material.dart';
import 'package:meetme/models/auth_user.dart';
import 'package:meetme/providers/user_provider.dart';

//TODO
class ProfileDataRow extends StatefulWidget {
  String title;
  String value;
  String paramName;

  ProfileDataRow(
      {super.key,
      required this.title,
      required this.value,
      required this.paramName});

  @override
  State<ProfileDataRow> createState() => _ProfileDataRowState();
}

class _ProfileDataRowState extends State<ProfileDataRow> {
  bool _editMode = false;
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.value;
    super.initState();
  }

  void _onTap() {
    setState(() {
      _editMode = true;
    });
  }

  void _onSave() async {
    final response =
        await AuthUser.updateProfile(widget.paramName, _controller.text);

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

    setState(() {
      widget.value = _controller.text;
      _editMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _editMode
        ? Row(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: widget.title,
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 2 / 3),
                ),
                controller: _controller,
              ),
              const Spacer(),
              IconButton.filled(
                onPressed: _onSave,
                iconSize: 25,
                icon: const Icon(
                  Icons.check,
                ),
              ),
            ],
          )
        : GestureDetector(
            onTap: _onTap,
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                Text(
                  widget.value,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
  }
}

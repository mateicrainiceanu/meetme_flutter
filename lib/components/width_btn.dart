import "package:flutter/material.dart";

class WidthBtn extends StatelessWidget {
  const WidthBtn({super.key, required this.title, required this.action});

  final String title;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton(
          onPressed: action,
          child: Text(title),
        ),
      ),
    );
  }
}

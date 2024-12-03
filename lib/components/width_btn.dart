import "package:flutter/material.dart";

class WidthBtn extends StatelessWidget {
  const WidthBtn(
      {super.key, required this.title, required this.action, this.color});

  final Color? color;
  final String title;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
        color == null ? Theme.of(context).colorScheme.tertiary : color!;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        child: ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16.0),
          ),
          child: Text(title),
        ),
      ),
    );
  }
}

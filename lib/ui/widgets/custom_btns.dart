import 'package:flutter/material.dart';

class CustomOutlinedBtn extends StatelessWidget {
  const CustomOutlinedBtn({
    Key? key,
    required this.onClick,
    required this.label,
  }) : super(key: key);

  final VoidCallback onClick;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onClick,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        side: const BorderSide(color: Colors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(label),
    );
  }
}

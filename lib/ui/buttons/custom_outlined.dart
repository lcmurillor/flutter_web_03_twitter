import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.color = Colors.blueAccent,
      this.isFilled = false})
      : super(key: key);
  final Function onPressed;
  final String text;
  final Color? color;
  final bool? isFilled;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
            side: MaterialStateProperty.all(
                const BorderSide(color: Colors.blueAccent)),
                backgroundColor: ),
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ));
  }
}

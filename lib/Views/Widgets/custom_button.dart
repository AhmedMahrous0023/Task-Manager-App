import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed ;
  const CustomButton({super.key, required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * .06,
        width: MediaQuery.of(context).size.width * .77,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ));
  }
}

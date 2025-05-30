import 'package:flutter/material.dart';

class DefaultBackButton extends StatelessWidget {
  const DefaultBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: CircleAvatar(
          radius: 10,
          child: Center(
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),
    );
  }
}

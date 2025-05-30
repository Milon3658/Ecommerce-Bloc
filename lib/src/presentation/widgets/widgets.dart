import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../routes/route_pages.dart';

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

class FullWidthButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const FullWidthButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed;
      },
      child: Container(
        height: 60.h,
        width: double.infinity,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        child: Center(
            child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
        )),
      ),
    );
  }
}

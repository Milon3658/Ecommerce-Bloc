import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullWidthButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const FullWidthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60.h,
        width: double.infinity,
        color:
            backgroundColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: textColor ?? Theme.of(context).colorScheme.onSecondary),
        )),
      ),
    );
  }
}

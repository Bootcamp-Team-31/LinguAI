import 'package:flutter/material.dart';
import '../constants/constants.dart';

class TitleAndActionButton extends StatelessWidget {
  const TitleAndActionButton({
    Key? key,
    required this.title,
    this.actionLabel,
    required this.onTap,
    this.isHeadline = true,
  }) : super(key: key);

  final String title;
  final String? actionLabel;
  final void Function() onTap;
  final bool isHeadline;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: isHeadline
              ? Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.white)
              : Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(actionLabel ?? 'View All', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}

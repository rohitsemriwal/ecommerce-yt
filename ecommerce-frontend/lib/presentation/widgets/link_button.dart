import 'package:flutter/cupertino.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const LinkButton({
    super.key,
    required this.text,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Text(text),
    );
  }
}
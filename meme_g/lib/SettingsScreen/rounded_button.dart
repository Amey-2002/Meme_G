import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.icon,
    required this.tap,
  }) : super(key: key);

  final Icon icon;
  final GestureTapCallback tap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: IconButton(
        onPressed: tap,
        icon: icon,
      ),
    );
  }
}

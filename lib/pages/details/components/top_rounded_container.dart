import 'package:flutter/material.dart';

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key key,
    @required this.color,
    @required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 375;
    return Container(
      margin: EdgeInsets.only(top: w * 20),
      padding: EdgeInsets.only(top: w * 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}

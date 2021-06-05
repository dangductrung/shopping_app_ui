import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  double getProportionateScreenHeight(double inputHeight, double h) {
    return inputHeight * h;
  }

  // Get the proportionate height as per screen size
  double getProportionateScreenWidth(double inputWidth, double w) {
    return inputWidth * w;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.height / 375;
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(getProportionateScreenWidth(5, w)),
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20, w),
          vertical: getProportionateScreenWidth(15, w),
        ),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '06.06 Deal sốc',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'Mua gì cũng rẻ',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ));
  }
}

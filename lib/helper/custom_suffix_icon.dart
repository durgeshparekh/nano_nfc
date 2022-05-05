import 'package:flutter/material.dart';

import 'constants.dart';
import 'size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  final IconData iconData;
  const CustomSuffixIcon({Key? key, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: Icon(
        iconData,
        size: getProportionateScreenWidth(18),
        color: kPrimaryColor,
        // color: kPrimaryColor,
      ),
    );
  }
}

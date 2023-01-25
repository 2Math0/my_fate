import 'package:flutter/widgets.dart';

class Utilities {
  const Utilities();

  double getWidth(BuildContext context) => MediaQuery.of(context).size.width;

  double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

  double height50(BuildContext context) => getHeight(context) * 0.5;
  double width50(BuildContext context) => getWidth(context) * 0.5;
}

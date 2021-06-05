import 'package:flutter/material.dart';
import 'package:shopping_app/theme/ui_color.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({String error}) {
    return Row(
      children: [
        Icon(Icons.error_outline_rounded, size: 20, color: UIColor.red),
        SizedBox(
          width: 10,
        ),
        Text(error),
      ],
    );
  }
}

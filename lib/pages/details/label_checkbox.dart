import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key key,
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LabelCheckboxWidget extends StatefulWidget {
  String label;
  LabelCheckboxWidget(this.label);

  @override
  State<LabelCheckboxWidget> createState() => LabelCheckboxWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class LabelCheckboxWidgetState extends State<LabelCheckboxWidget> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return LabeledCheckbox(
      label: widget.label,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
        });
      },
    );
  }
}

import 'package:flutter/material.dart';

class BaseIndicator extends StatelessWidget {
  /// Whether this indicator is selected or not.
  final bool isSelected;

  /// The child to be placed within the indicator.
  final Widget? child;

  /// Action to be taken when this indictor is pressed.
  final Function? onPressed;

  /// Color of this indicator when it is not selected.
  final Color? color;

  /// Color of this indicator when it is selected.
  final Color? activeColor;

  /// Border color of this indicator when it is selected.
  final Color? activeBorderColor;

  /// The border width of this indicator when it is selected.
  final activeBorderWidth;

  /// Radius of this indicator.
  final double radius;

  /// The amount of padding around each side of the child.
  final double padding;

  /// The amount of margin around each side of the indicator.
  final double margin;

  final bool past;

  final bool first;

  BaseIndicator({
    this.isSelected = false,
    this.past = false,
    this.child,
    this.onPressed,
    this.color,
    this.activeColor,
    this.activeBorderColor,
    this.radius = 24.0,
    this.padding = 5.0,
    this.margin = 1.0,
    this.activeBorderWidth = 0.5,
    this.first = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        border: Border.all(
          color: past ? Colors.green : Colors.grey,
          width: activeBorderWidth,
        ),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onPressed as void Function()?,
        child: Container(
          height: radius * 2,
          width: radius * 2,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: (past || isSelected)
                ? activeColor ?? Colors.green
                : color ?? Colors.grey,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(""),
          ),
        ),
      ),
    );
  }
}

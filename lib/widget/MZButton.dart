import 'package:flutter/material.dart';

class MZButton extends StatelessWidget {
  final Color color;
  final String title;
  final TextStyle style;
  final double width;
  final double height;
  final EdgeInsets margin;
  final double borderRadius;
  final Border border;
  final EdgeInsets padding;
  final MainAxisAlignment horizontalAlignment;
  final VoidCallback onTap;

  MZButton(
      {this.color = Colors.white,
      this.title = "MZButton",
      this.style,
      this.width = double.infinity,
      this.height = 36,
      this.margin = EdgeInsets.zero,
      this.padding = EdgeInsets.zero,
      this.borderRadius = 10,
      this.border,
      this.horizontalAlignment = MainAxisAlignment.center,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: horizontalAlignment,
        children: [
          Container(
            height: height,
            width: width,
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius),
                border: border),
            child: Center(
              child: Text(
                title,
                style: style,
              ),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

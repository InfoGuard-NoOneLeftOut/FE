import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double height;
  final double? width;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CustomCard({
    Key? key,
    required this.height,
    required this.child,
    this.width,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double cardWidth = width ?? MediaQuery.of(context).size.width * 0.8;

    return Card(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.white,
      elevation: 2,
      child: SizedBox(
        height: height,
        width: cardWidth,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
          child: child,
        ),
      ),
    );
  }
}

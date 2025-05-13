import 'package:bali_baci_order/utils/color_utils.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final CardHeader? cardHeader;

  const CardWidget({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.elevation = 4.0,
    this.borderRadius,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    this.cardHeader
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10), 
            blurRadius: 7.0, 
            spreadRadius: 0.0, 
            offset: Offset(0, 0), 
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (cardHeader != null) cardHeader!,
            child,
          ],
        ),
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;

  const CardHeader({
    super.key,
    required this.title,
    required this.subtitle, 
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Icon(
                iconData,
                size: 20,
                color: Colors.blue[600],
              ),
            ),
          ),
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: AppColors.darkGrey, fontSize: 17, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 1),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

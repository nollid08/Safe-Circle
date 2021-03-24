import 'package:flutter/material.dart';

class RoundedBottomSheet extends StatelessWidget {
  final Widget child;

  const RoundedBottomSheet({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 10,
              blurRadius: 14,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

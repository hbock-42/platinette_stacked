import 'package:flutter/material.dart';

// temporary
// will have a version for desktop and mobile
class OnTapListener extends StatelessWidget {
  final void Function() onTap;
  final Widget child;

  const OnTapListener({Key key, this.onTap, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) => onTap(),
      child: child,
    );
  }
}

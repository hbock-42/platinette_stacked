import 'package:flutter/material.dart';
import 'package:platinette_app/ui/widgets/macaron/macaron.dart';

class Vinyl extends StatelessWidget {
  static const double labelVinylRatio = 0.328;

  final double rotation;

  const Vinyl({Key key, this.rotation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var macaronSize = constraints.maxHeight * 0.341;
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: FittedBox(
                child: Image.asset("assets/images/vinyl.png"),
              ),
            ),
            SizedBox(
              width: macaronSize,
              height: macaronSize,
              child: Macaron(rotation: rotation),
            ),
          ],
        );
      },
    );
  }
}

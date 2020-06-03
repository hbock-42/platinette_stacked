import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'macaron_viewmodel.dart';

class Macaron extends StatelessWidget {
  final double rotation;
  const Macaron({Key key, this.rotation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MacaronViewModel>.reactive(
      builder: (context, model, child) {
        return buildMacaron(model);
      },
      viewModelBuilder: () => MacaronViewModel(),
    );
  }

  Widget buildMacaron(MacaronViewModel model) {
    if (model.macaronData == null) {
      return Container();
    } else {
      return Transform.rotate(
        angle: rotation ?? 0,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              // image: FileImage(model.macaronFile),
              image: MemoryImage(model.macaronData),
              fit: BoxFit.fill,
            ),
          ),
        ),
      );
    }
  }
}

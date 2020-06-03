import 'dart:math';

import 'package:flutter/material.dart';
import 'package:platinette_app/ui/widgets/get_file_button/get_file_button_viewmodel.dart';
import 'package:platinette_app/ui/widgets/on_tap_listener/on_tap_listener.dart';
import 'package:stacked/stacked.dart';

class GetFileButton extends StatefulWidget {
  @override
  _GetFileButtonState createState() => _GetFileButtonState();
}

class _GetFileButtonState extends State<GetFileButton> {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<GetFileButtonViewModel>.nonReactive(
        builder: (context, model, child) => LayoutBuilder(
          builder: (context, constraints) => OnTapListener(
            onTap: () => model.loadMacaron(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    max(constraints.maxHeight, constraints.maxWidth)),
                border: Border.all(color: Colors.white),
              ),
            ),
          ),
        ),
        viewModelBuilder: () => GetFileButtonViewModel(),
      );
}

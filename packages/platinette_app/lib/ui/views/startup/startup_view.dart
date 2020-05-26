import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      builder: (context, viewModel, child) => Container(
        child: Center(
          child: Column(
            children: [
              Text('startup view'),
              FloatingActionButton(
                onPressed: () => viewModel.navigateToHome(),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, viewModel, child) => Container(
        child: Center(
          child: Column(
            children: [
              Text(viewModel.title),
              Text(viewModel.counter.toString()),
              FloatingActionButton(
                onPressed: () => viewModel.updateCounter(),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}

import 'dart:io' if (dart.library.html) 'dart:html';
import 'package:stacked/stacked.dart';

class MacaronViewModel extends ReactiveViewModel {
  // add fileProvider service;
  File get macaronFile => null;
  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}

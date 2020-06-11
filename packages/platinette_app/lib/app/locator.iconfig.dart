// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:platinette_app/services/animation_recorder_service/animation_recorder_service.dart';
import 'package:platinette_app/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:platinette_app/services/file_io/file_io_service.dart';
import 'package:platinette_app/services/file_picker_service.dart/file_picker_service.dart';
import 'package:platinette_app/services/main_color_service.dart';
import 'package:platinette_app/services/player_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<AnimationRecorderService>(
      () => AnimationRecorderService());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<FileIOService>(() => FileIOService());
  g.registerLazySingleton<FilePickerService>(() => FilePickerService());
  g.registerLazySingleton<MainColorService>(() => MainColorService());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<PlayerService>(() => PlayerService());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}

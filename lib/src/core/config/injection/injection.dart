import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:mobile_test/src/core/config/injection/injection.config.dart';

late GetIt getItData;

@InjectableInit(initializerName: r'$initModuleGetIt')
Future dataConfigureInjection(GetIt _getIt, {String? environment}) async {
  getItData = _getIt;
  await _getIt.$initModuleGetIt(environment: environment);
}

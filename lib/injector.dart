import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

GetIt injector = GetIt.instance;

@InjectableInit()
Future setupInjector() async {
  $initGetIt(injector);
}

import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EventBusHelper {
  EventBus eventBus = EventBus();
}

import 'package:all_events_sample/controller/home_controller.dart';
import 'package:get/get.dart';

// while navigating to a route, binding ensures that all required dependencies are injected and dispose those which are not in usage.
class EventDetailsBinding extends Bindings {
  @override
  void dependencies() {
    //dependencies are only created when needed, leading to reduce the initial loading time and memory usage
    Get.lazyPut(() => HomeController());
  }
}

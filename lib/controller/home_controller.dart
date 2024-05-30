// ignore: unused_import
import 'dart:convert';

import 'package:all_events_sample/api/event_api.dart';
import 'package:all_events_sample/models/event_details_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var category = "All".obs;
  var isGridView = false.obs;
  EventApi eventApi = EventApi();
  EventDetailsModel? eventDetailsModel;

  // this method is called when we initialize the home controller
  @override
  void onInit() {
    super.onInit();
    fetchEventDetails(category.value.toLowerCase());
  }

// this method is called to fetch the event details
  void fetchEventDetails(category) async {
    eventDetailsModel = null;
    update();
    var response = await eventApi.getEventData(category);
    if (response != null) {
      eventDetailsModel = EventDetailsModel.fromJson(response);
      update();
    }
  }

// this method is called when we change the event category.
  changeCategory(category) {
    this.category.value = category;
    fetchEventDetails(category.toLowerCase());
    update();
  }

  changeGridView() {
    isGridView.value = !isGridView.value;
    update();
  }
}

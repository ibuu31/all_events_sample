import 'package:all_events_sample/controller/home_controller.dart';
import 'package:all_events_sample/screens/event_screen.dart';
import 'package:all_events_sample/utils/binding.dart';
import 'package:all_events_sample/utils/constant.dart';
import 'package:all_events_sample/utils/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());
  final categoryItemList = [
    'All',
    'Music',
    'Business',
    'Sports',
    'Workshops',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.blue),
          title: Row(
            children: [
              CachedNetworkImage(
                imageUrl: Constants.logoImage, // Replace with your logo asset
                height: 40,
              ),
              const SizedBox(width: 10),
              Text('${controller.category} Events'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _showCategoryBottomSheet(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.category),
              onPressed: () {
                controller.changeGridView();
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  hintText: Constants.searchName,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
        body: controller.eventDetailsModel == null
            ? const Center(child: CircularProgressIndicator())
            : (controller.isGridView.value
                ? buildGridView(controller)
                : buildListView(controller)),
      ),
    );
  }

  void _showCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 7,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const Divider(thickness: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                    spacing: 10, // Horizontal spacing between containers
                    runSpacing: -20,
                    // Vertical spacing between containers
                    children: List.generate(
                      5,
                      (index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: _buildCategoryItem(categoryItemList[index]),
                        );
                      },
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem(String category) {
    return GestureDetector(
      onTap: () {
        controller.changeCategory(category);
        Get.back();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: controller.category.value == category
              ? Colors.blue
              : Colors.white,
          border: Border.all(
            color: controller.category.value == category
                ? Colors.blue
                : Colors.black54,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: controller.category.value == category
                ? Colors.white
                : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildListView(HomeController controller) {
    return ListView.builder(
      itemCount: controller.eventDetailsModel?.count,
      itemBuilder: (context, index) {
        return ListViewCard(
          controller: controller,
          index: index,
        );
      },
    );
  }

  Widget buildGridView(HomeController controller) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),

      itemCount: controller.eventDetailsModel?.count, // Example item count
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(
                EventPage(
                  index: index,
                ),
                binding: EventDetailsBinding());
          },
          child: GridViewCard(
            controller: controller,
            index: index,
          ),
        );
      },
    );
  }
}

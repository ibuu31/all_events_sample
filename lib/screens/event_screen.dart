import 'package:all_events_sample/controller/home_controller.dart';
import 'package:all_events_sample/utils/constant.dart';
import 'package:all_events_sample/utils/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EventPage extends StatelessWidget {
  EventPage({
    super.key,
    required this.index,
  });
  final controller = Get.put(HomeController());
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.white),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          controller.eventDetailsModel?.item?[index].eventname ?? '',
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: ListView(
          children: [
            Image.network(
              controller.eventDetailsModel?.item?[index].thumbUrlLarge ?? '',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      controller.eventDetailsModel?.item?[index].eventname ??
                          '',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.clip),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.star),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 5,
            ),
            EventScreenDetailRow(
              icon: Icons.date_range,
              text: Constants.dateTime,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(controller.eventDetailsModel?.item?[index].startTimeDisplay ??
                ''),
            const SizedBox(
              height: 10,
            ),
            EventScreenDetailRow(
              icon: Icons.location_on_outlined,
              text: Constants.venue,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(controller.eventDetailsModel?.item?[index].location ?? ''),
            Row(
              children: [
                Text(
                  Constants.viewMap,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_drop_down),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: Constants.mapImage,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 5,
              ),
              child: const Text('Book Now'),
            ),
            const SizedBox(
              height: 10,
            ),
            EventScreenDetailRow(
              icon: Icons.photo,
              text: Constants.eventPhotos,
            ),
            const SizedBox(
              height: 10,
            ),
            Image.network(
              controller.eventDetailsModel?.item?[index].thumbUrl ?? '',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            EventScreenDetailRow(
              icon: Icons.rate_review,
              text: Constants.hostReview,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: CachedNetworkImageProvider(Constants
                    .personImage), // Replace with your person image asset
              ),
              title: Text(
                Constants.randomUserName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const SizedBox(width: 5),
                  Text(Constants.reviewText),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                ),
                child: Text(Constants.follow),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Constants.suggestedEvent,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10, // Example item count
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 200,
                    child: GridViewCard(
                      controller: controller,
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

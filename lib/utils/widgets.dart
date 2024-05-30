import 'package:all_events_sample/controller/home_controller.dart';
import 'package:all_events_sample/screens/event_screen.dart';
import 'package:all_events_sample/utils/binding.dart';
import 'package:all_events_sample/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeopleGoing extends StatelessWidget {
  const PeopleGoing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 7,
            backgroundImage: CachedNetworkImageProvider(Constants.personImage),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 7,
            backgroundImage: CachedNetworkImageProvider(Constants.personImage),
          ),
          CircleAvatar(
            radius: 7,
            backgroundColor: Colors.white,
            backgroundImage: CachedNetworkImageProvider(Constants.personImage),
          ),
          const SizedBox(width: 5),
          Text(
            Constants.goingString,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class EventScreenDetailRow extends StatelessWidget {
  const EventScreenDetailRow({
    super.key,
    required this.text,
    required this.icon,
  });
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class GridViewCard extends StatelessWidget {
  const GridViewCard({
    super.key,
    required this.controller,
    required this.index,
  });

  final HomeController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                controller.eventDetailsModel?.item?[index].thumbUrl ??
                    '', // Replace with your image asset
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  color: Colors.grey[300],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                      controller.eventDetailsModel?.item?[index].label
                              ?.split(' 2018')
                              .first ??
                          '',
                      style: const TextStyle(color: Colors.black)),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.star),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              controller.eventDetailsModel?.item?[index].eventname ?? '',
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          const PeopleGoing(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              controller.eventDetailsModel?.item?[index].location ?? '',
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewCard extends StatelessWidget {
  const ListViewCard({
    super.key,
    required this.controller,
    required this.index,
  });
  final HomeController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        onTap: () {
          Get.to(
              EventPage(
                index: index,
              ),
              binding: EventDetailsBinding());
        },
        leading: Image.network(
          controller.eventDetailsModel?.item?[index].thumbUrl ?? '',
          // width: 50,
          height: 200,
          fit: BoxFit.cover,
        ),
        title: Text(controller.eventDetailsModel?.item?[index].eventname ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller.eventDetailsModel?.item?[index].startTimeDisplay ??
                ''),
            Text(
              controller.eventDetailsModel?.item?[index].venue?.fullAddress ??
                  '',
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const PeopleGoing(),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.star),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

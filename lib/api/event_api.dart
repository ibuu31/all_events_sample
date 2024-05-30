import 'package:dio/dio.dart';

class EventApi {
  final dio =
      Dio(BaseOptions(baseUrl: 'https://allevents.s3.amazonaws.com/tests/'));

// api call for fetching events details
  Future<dynamic> getEventData(String category) async {
    final response = await dio.get('$category.json');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }
}

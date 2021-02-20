import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:ghclimatecon/models/dataModel.dart';
import 'package:http/http.dart' as http;

class GreenHouseDataControlller extends GetxController {
  var feed = [].obs;
  Future<List<Feed>> getDataFromThingspeak() async {
    final urlLink =
        'https://api.thingspeak.com/channels/1309016/feeds.json?api_key=Q1GZK4YWY9DJPQBW&results=50';

    try {
      final response = await http.get(urlLink);

      if (response.statusCode == 200) {
        final data = DataModel.fromJson(json.decode(response.body));
        // data.feeds.forEach((feeds) {
        //   print(feeds.createdAt);
        // });
        feed.assignAll(data.feeds);

        return data.feeds;

        // print(json.decode(response.body));
      }
    } catch (err) {}
  }

  Stream<List<Feed>> getDataFromThingspeak2() async* {
    final urlLink =
        'https://api.thingspeak.com/channels/1309016/feeds.json?api_key=Q1GZK4YWY9DJPQBW&results=50';

    while (true) {
      try {
        final response = await http.get(urlLink);

        while (true)
          if (response.statusCode == 200) {
            // Timer.periodic(Duration(seconds: 1), (timer) async* {
            //   final data = DataModel.fromJson(json.decode(response.body));
            //   // data.feeds.forEach((feeds) {
            //   //   print(feeds.createdAt);
            //   // });
            //   feed.assignAll(data.feeds);
            //   print("valldf");
            //   yield data.feeds;
            // });
            final data = DataModel.fromJson(json.decode(response.body));
            // data.feeds.forEach((feeds) {
            //   print(feeds.createdAt);
            // });
            print("red");
            feed.assignAll(data.feeds);

            yield data.feeds;
            await Future.delayed(Duration(seconds: 5));

            // print(json.decode(response.body));
          }
      } catch (err) {}
    }
  }
}

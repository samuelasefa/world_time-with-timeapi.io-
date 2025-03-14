import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/io_client.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class WorldTime {
  String location = ""; //location name for  the UI
  String time = ""; // the time in that location
  String flag = "";
  String url = "";
  bool isDayTime = false;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    // Set up the custom HttpClient that bypasses SSL validation
    final HttpClient httpClient =
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) =>
                  true; // Bypass SSL

    final ioClient = IOClient(httpClient);

    try {
      // Make the request
      http.Response response = await ioClient.get(
        Uri.parse('https://timeapi.io/api/timezone/zone?timeZone=$url'),
      );

      if (response.statusCode == 200) {
        // Parse response body as a Map
        Map<String, dynamic> data = jsonDecode(response.body);

        // Access values
        String currentLocalTime = data['currentLocalTime'];
        String timeZone = data['timeZone'];

        // Access currentUtcOffset which is a map
        Map<String, dynamic> utcOffset = data['currentUtcOffset'];
        int offsetInSeconds =
            utcOffset['seconds']; // You can use seconds or calculate the full offset here
        int offsetInMilliseconds = utcOffset['milliseconds'];
        // Combine seconds and milliseconds if needed:
        Duration utcOffsetDuration = Duration(
          seconds: offsetInSeconds,
          milliseconds: offsetInMilliseconds,
        );

        // Print values
        print('Time Zone: $timeZone');
        print(
          'UTC Offset: ${utcOffsetDuration.inHours}:${utcOffsetDuration.inMinutes % 60}:${utcOffsetDuration.inSeconds % 60}',
        ); // Example of printing UTC offset in hours, minutes, seconds

        // Convert currentLocalTime to DateTime
        DateTime now = DateTime.parse(currentLocalTime);

        //set the time property to string
        isDayTime = now.hour > 6 && now.hour < 5 ? true : false;
        time = DateFormat.jm().format(now);
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      ioClient.close();
    }
  }
}

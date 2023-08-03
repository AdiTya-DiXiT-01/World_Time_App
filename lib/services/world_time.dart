import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  final String location;
  final String flag;
  final String url;
  late bool isDaytime;
  late String time;
  late http.Client _client = http.Client();

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  factory WorldTime.withClient(http.Client client, {required String location, required String flag, required String url}) {
    return WorldTime(
      location: location,
      flag: flag,
      url: url,
    ).._client = client;
  }
  set client(http.Client newClient) {
    _client = newClient;
  }
  Future<void> getTime() async {
    try {
      http.Response response = await _client.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      int offsetHours = int.parse(offset.substring(1, offset.indexOf(':')));
      int offsetMinutes = int.parse(offset.substring(offset.indexOf(':') + 1));

      if (offset.startsWith('-')) {
        offsetHours = -offsetHours;
      }

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: offsetHours, minutes: offsetMinutes));
      isDaytime = now.hour > 6 && now.hour < 20;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print(e);
      time = 'could not get time';
    }
  }
}

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isdaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> gettime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      String offset1 = offset.substring(1, 3);
      String offset2 = offset.substring(4, 6);

      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offset1), minutes: int.parse(offset2)));

      isdaytime = now.hour > 5 && now.hour < 19 ? true : false;

      time = DateFormat.jm().format(now);
    } catch (e) {
      print("Error caught $e");
      time = 'Could not load date';
    }
  }
}

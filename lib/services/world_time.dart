import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location='';
  String time='';
  String flag='';
  String url='Asia/Kolkata';
  bool isDaytime=false;

  WorldTime({required this.location,required this.flag,required this.url});

  Future <void> getTime() async{
    try {
      var jurl = Uri.https("worldtimeapi.org", '/api/timezone/$url');
      var response = await http.get(jurl);
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime=now.hour>6 && now.hour < 20 ? true:false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print("Error: $e");
      time="$e";
    }
  }

}


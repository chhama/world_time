import 'package:flutter/material.dart';
import 'package:world_time/pages/choose_location.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};
  @override
  Widget build(BuildContext context) {

    data=data.isNotEmpty?data:ModalRoute.of(context)!.settings.arguments as Map;

    String bgImage=data['isDaytime']?'day.png':'night.png';
    Color bgColor=data['isDaytime']?Colors.blue:Colors.indigo;
    
    print(data);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: <Widget>[
                  TextButton.icon(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data['time']=result['time'];
                          data['location']=result['location'];
                          data['isDaytime']=result['isDaytime'];
                          data['flag']=result['flag'];
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                      label: const Text(
                          "Choose Location",
                        style: TextStyle(
                          color: Colors.yellow,
                        ),
                      ),
                      ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28,
                          letterSpacing: 2,
                          color: Colors.white,
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          )
      )
    );
  }
}

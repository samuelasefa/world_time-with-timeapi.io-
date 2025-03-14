import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data =
        data.isNotEmpty
            ? data
            : ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};

    //set background
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];

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
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                //ADD EDIT LOCATION BUTTON HERE
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(
                      context,
                      '/location',
                    );
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime'],
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location, color: Colors.grey[300]),
                  label: Text(
                    "Edit Location",
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
                Text(
                  data['time'],
                  style: TextStyle(color: Colors.grey[300], fontSize: 66.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

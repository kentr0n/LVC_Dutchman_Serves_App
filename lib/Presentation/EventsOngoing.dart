//Currently unused

import 'package:dutchmenserve/models/event.dart';
import 'package:dutchmenserve/models/user.dart';
import 'package:flutter/material.dart';

import 'EventInfo.dart';
import 'EventsCalendar.dart';
import 'homePage.dart';

final List<Event> events = [
  Event('AFCA Warehouse', DateTime.parse('2020-12-08T12:00:00Z'), 'Lebanon',
      'pack medical supplies', <int>[5], true,
      id: 1, imagepath: 'images/afca.JPG'),
  Event('Mapathon', DateTime.parse('2021-04-05T12:00:00Z'), 'LVC',
      'Log online to help fill in gaps in maps', <int>[5], true,
      id: 2, imagepath: 'images/mapathon.jpg'),
  Event('Compeer Virtual Buddy', DateTime.parse('2021-03-08T12:00:00Z'), 'LVC',
      'Spend time with Compeer buddy', <int>[5], true,
      id: 3, imagepath: 'images/compeer.png'),
];

class EventsOngoing extends StatelessWidget {
  final User user;
  const EventsOngoing(this.user);

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ongoing Events"),
        backgroundColor: Colors.indigo[800],
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              ctxt,
              MaterialPageRoute(builder: (context) => HomePage(user)),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () {
              Navigator.push(
                ctxt,
                MaterialPageRoute(builder: (context) => EventsCalendar(user)),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: events.map((e) => createEventCard(ctxt, e)).toList(),
        ),
      ),
    );
  }
}

// function to create card for each event
GestureDetector createEventCard(BuildContext context, Event e) {
  Color _iconColor = Colors.white;
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EventInfo(e)),
      );
    },
    child: Container(
      padding: EdgeInsets.all(25),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.pan_tool),
                color: _iconColor,
                onPressed: () {
                  //TODO: implement register for event
                },
              ),
              title: Text(e.eventName),
              subtitle: Text(
                e.dateString() + ' | ' + e.location,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Image(
              image: AssetImage(e.imagepath),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                e.description,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        //TODO: implement favoriting event
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        //TODO: implement sharing
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

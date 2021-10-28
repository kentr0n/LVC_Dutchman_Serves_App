import 'package:dutchmenserve/models/event.dart';
import 'package:flutter/material.dart';

/*
This class builds the Event Info page for a specific event.
User clicks on a specific event card from the EventsList pagetab to get here.
*/

class EventInfo extends StatelessWidget {
  final Event e;
  const EventInfo(this.e);

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Info"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Text(
                e.eventName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(Icons.access_time),
                  SizedBox(width: 10),
                  Text(
                    e.dateString(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 10),
                  Text(
                    e.location,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                e.description,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              e.imagepath == null
                  ? Container()
                  : Image(image: AssetImage(e.imagepath)),
              SizedBox(height: 20),
              e.dateCompare(DateTime.now()) >= 0
                  ? ListTile(
                      leading: Icon(Icons.pan_tool_outlined,
                          color: Color(0xff95C1DC)),
                      trailing: Icon(Icons.pan_tool, color: Color(0xff002A4E)),
                      title: Text(
                        "TO REGISTER",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        "Tap the Volunteer Hand on the previous page!",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : ListTile(
                      leading: Icon(Icons.pan_tool_rounded),
                      title: Text(
                        "EVENT HAS PASSED",
                        style: TextStyle(
                          color: Color(0xffA02A2C),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "Check back later to see if we'll have this event again!",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

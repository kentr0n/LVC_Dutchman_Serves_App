import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:dutchmenserve/Infrastructure/cubit/event_cubit.dart';
import 'package:dutchmenserve/Infrastructure/cubit/event_state.dart';
import 'package:dutchmenserve/Presentation/EventsOngoing.dart';
import 'package:dutchmenserve/models/user.dart';

/*
This class builds the Calendar View of all events by date
and a link to list ongoing (undated) events.

Currently unused.
*/

class EventsCalendar extends StatelessWidget {
  final User user;
  const EventsCalendar(this.user);

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events Calendar'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(ctxt);
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.list),
        //     onPressed: () {
        //       Navigator.push(
        //         ctxt,
        //         MaterialPageRoute(builder: (context) => EventsList(user)),
        //       );
        //     },
        //   )
        // ],
      ),
      body: BlocProvider<EventCubit>(
        create: (context) => EventCubit(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              OppsCalendarStateful(),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    ctxt,
                    MaterialPageRoute(
                        builder: (context) => EventsOngoing(user)),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 12),
                  child: Text('See Ongoing Events',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xffaacde3),
                        fontWeight: FontWeight.w900,
                      )),
                ),
              )
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              //   child: NormalButton(
              //     'See Ongoing Events',
              //     () {
              //       Navigator.push(
              //         ctxt,
              //         MaterialPageRoute(
              //             builder: (context) => EventsOngoing(user)),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class OppsCalendarStateful extends StatefulWidget {
  OppsCalendarStateful({Key key}) : super(key: key);

  @override
  _OCalState createState() => _OCalState();
}

class _OCalState extends State<OppsCalendarStateful> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        return SfCalendar(
           view: CalendarView.schedule,
         controller: _calendarController,
        );
      },
    );
  }
}

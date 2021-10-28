import 'dart:ui';
import 'package:dutchmenserve/Infrastructure/cubit/event_cubit.dart';
import 'package:dutchmenserve/Infrastructure/cubit/organization_cubit.dart';
import 'package:dutchmenserve/Infrastructure/cubit/report_cubit.dart';
import 'package:dutchmenserve/Infrastructure/cubit/users_cubit.dart';
import 'package:dutchmenserve/Presentation/EventsList.dart';
import 'package:dutchmenserve/Presentation/NotificationsPage.dart';
import 'package:dutchmenserve/Presentation/ReportHoursPage.dart';
import 'package:dutchmenserve/Presentation/connectWUsPage.dart';
import 'package:dutchmenserve/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
This class builds the homepage once user has logged in.
Shows three tabs that are srollable (up-down) and swipable (left-right).
Notifications at top right.
*/

class HomePage extends StatelessWidget {
  final User user;
  const HomePage(this.user);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff002A4E),
      systemNavigationBarColor: Color(0xfff9f9f9),
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider<EventCubit>(
          create: (BuildContext context) => EventCubit(),
        ),
        BlocProvider<ReportCubit>(
          create: (BuildContext context) => ReportCubit(),
        ),
        BlocProvider<UsersCubit>(
          create: (BuildContext context) => UsersCubit(),
        ),
        BlocProvider<OrganizationCubit>(
          create: (BuildContext context) => OrganizationCubit(),
        )
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: buildScrollable(context),
        ),
      ),
    );
  }

  // scroll so only tabs show
  Widget buildScrollable(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            title: Text(
              'Dutchmen Serve',
              style: TextStyle(
                  fontFamily: 'BebasNeue',
                  color: Color(0xff95C1DC),
                  fontSize: 45),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.notifications, size: 28),
                  padding: EdgeInsets.only(right: 15),
                  onPressed: () {
                    // Navigator.of(context).pushNamed('/notifications-page');
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => NotificationsPage()),
                    );
                  }),
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Volunteer',
                  icon: Icon(
                    Icons.pan_tool,
                    // size: 20,
                  ),
                  iconMargin: EdgeInsets.only(bottom: 3, right: 6),
                ),
                Tab(
                  text: 'Report',
                  icon: Icon(Icons.event_note),
                  iconMargin: EdgeInsets.only(bottom: 2),
                ),
                Tab(
                  text: 'Connect',
                  icon: Icon(Icons.people),
                  iconMargin: EdgeInsets.only(bottom: 0),
                ),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        children: [
          EventsList(user: user),
          ReportHoursPage(user),
          ConnectWUsPage(user),
        ],
      ),
    );
  }

  Widget buildNonScrollable(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Dutchmen Serve',
            style: TextStyle(
                fontFamily: 'BebasNeue',
                color: Color(0xff95C1DC),
                fontSize: 45),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.notifications, size: 28),
                padding: EdgeInsets.only(right: 15),
                onPressed: () {
                  // Navigator.of(context).pushNamed('/notifications-page');
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => NotificationsPage()),
                  );
                }),
          ],
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 60),
            child: TabBar(
              tabs: [
                Container(
                  height: 65,
                  child: Tab(
                    text: 'Volunteer',
                    icon: Icon(
                      Icons.pan_tool,
                    ),
                    iconMargin: EdgeInsets.only(bottom: 3, right: 6),
                  ),
                ),
                Container(
                  height: 65,
                  child: Tab(
                    text: 'Report',
                    icon: Icon(Icons.event_note),
                    iconMargin: EdgeInsets.only(bottom: 2),
                  ),
                ),
                Container(
                  height: 65,
                  child: Tab(
                    text: 'Connect',
                    icon: Icon(Icons.people),
                    iconMargin: EdgeInsets.only(bottom: 0),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            EventsList(user: user),
            ReportHoursPage(user),
            ConnectWUsPage(user),
          ],
        ),
      ),
    );
  }
}

// // GENERATED CODE - DO NOT MODIFY BY HAND

// // **************************************************************************
// // AutoRouteGenerator
// // **************************************************************************

// // ignore_for_file: public_member_api_docs

// import 'package:auto_route/auto_route.dart';
// import 'package:dutchmenserve/Presentation/EventsList.dart';
// import 'package:dutchmenserve/Presentation/EventsOngoing.dart';
// import 'package:dutchmenserve/Presentation/FavoritedPage.dart';
// import 'package:dutchmenserve/Presentation/NotificationsPage.dart';
// import 'package:dutchmenserve/Presentation/OrganizationsPage.dart';
// import 'package:dutchmenserve/Presentation/ProfilePage.dart';
// import 'package:dutchmenserve/Presentation/VolunteerPage.dart';
// import 'package:dutchmenserve/Presentation/ReportGroupAddStudents.dart';
// import 'package:dutchmenserve/Presentation/ReportHoursPage.dart';
// import 'package:dutchmenserve/Presentation/homePage.dart';
// import 'package:dutchmenserve/Presentation/organizationInfo.dart';
// import 'package:dutchmenserve/Presentation/reportNewHours.dart';
// import 'package:flutter/material.dart';

// class Routes {
//   static const String homePage = '/';
//   static const String eventsList = '/events-list';
//   static const String eventsOngoing = '/events-ongoing';
//   static const String favoritedPage = '/favorited-page';
//   static const String notificationsPage = '/notifications-page';
//   static const String organizationInfo = '/organization-info';
//   static const String organizationsPage = '/organizations-page';
//   static const String profilePage = '/profile-page';
//   static const String VolunteerPage = '/registered-page';
//   static const String reportGroupAddStudents = '/report-group-add-students';
//   static const String reportHoursPage = '/report-hours-page';
//   static const String reportIndividual = '/report-individual';
//   static const String loginHome = '/login-home';
//   static const all = <String>{
//     homePage,
//     eventsList,
//     eventsOngoing,
//     favoritedPage,
//     notificationsPage,
//     organizationInfo,
//     organizationsPage,
//     profilePage,
//     VolunteerPage,
//     reportGroupAddStudents,
//     reportHoursPage,
//     reportIndividual,
//     loginHome,
//   };
// }

// class Router extends RouterBase {
//   @override
//   List<RouteDef> get routes => _routes;
//   final _routes = <RouteDef>[
//     RouteDef(Routes.homePage, page: HomePage),
//     RouteDef(Routes.eventsList, page: EventsList),
//     RouteDef(Routes.eventsOngoing, page: EventsOngoing),
//     RouteDef(Routes.favoritedPage, page: FavoritedPage),
//     RouteDef(Routes.notificationsPage, page: NotificationsPage),
//     RouteDef(Routes.organizationInfo, page: OrganizationInfo),
//     RouteDef(Routes.organizationsPage, page: OrganizationsPage),
//     RouteDef(Routes.profilePage, page: ProfilePage),
//     RouteDef(Routes.VolunteerPage, page: VolunteerPage),
//     RouteDef(Routes.reportGroupAddStudents, page: ReportGroupAddStudents),
//     RouteDef(Routes.reportHoursPage, page: ReportHoursPage),
//     RouteDef(Routes.reportIndividual, page: ReportNewHours),
//   ];
//   @override
//   Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
//   final _pagesMap = <Type, AutoRouteFactory>{
//     HomePage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => HomePage(),
//         settings: data,
//       );
//     },
//     EventsList: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => EventsList(),
//         settings: data,
//       );
//     },
//     EventsOngoing: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => EventsOngoing(),
//         settings: data,
//       );
//     },
//     FavoritedPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => FavoritedPage(),
//         settings: data,
//       );
//     },
//     NotificationsPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => NotificationsPage(),
//         settings: data,
//       );
//     },
//     OrganizationInfo: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => OrganizationInfo(),
//         settings: data,
//       );
//     },
//     OrganizationsPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => OrganizationsPage(),
//         settings: data,
//       );
//     },
//     ProfilePage: (data) {
//       final args = data.getArgs<ProfilePageArguments>(
//         orElse: () => ProfilePageArguments(),
//       );
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => ProfilePage(key: args.key),
//         settings: data,
//       );
//     },
//     VolunteerPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => VolunteerPage(),
//         settings: data,
//       );
//     },
//     ReportGroupAddStudents: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => ReportGroupAddStudents(),
//         settings: data,
//       );
//     },
//     ReportHoursPage: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => ReportHoursPage(),
//         settings: data,
//       );
//     },
//     ReportNewHours: (data) {
//       return MaterialPageRoute<dynamic>(
//         builder: (context) => ReportNewHours(),
//         settings: data,
//       );
//     },
//   };
// }

// /// ************************************************************************
// /// Arguments holder classes
// /// *************************************************************************

// /// ProfilePage arguments holder class
// class ProfilePageArguments {
//   final Key key;
//   ProfilePageArguments({this.key});
// }

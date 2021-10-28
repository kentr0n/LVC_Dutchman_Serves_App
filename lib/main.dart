import 'package:dutchmenserve/Infrastructure/repository.dart';
import 'package:dutchmenserve/Presentation/ProfilePage.dart';
import 'package:dutchmenserve/Presentation/initialHomePage.dart';
import 'package:dutchmenserve/Presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'Infrastructure/cubit/event_cubit.dart';
import 'Infrastructure/cubit/organization_cubit.dart';
import 'Infrastructure/cubit/report_cubit.dart';
import 'Infrastructure/cubit/users_cubit.dart';

final GetIt getIt = GetIt.instance;

void main() async {
  GetIt.I.registerSingleton<Repository>(FakeRepository());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
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
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: basicTheme(),
          home: InitialLoginHome(),
          routes: <String, WidgetBuilder>{
            '/profile': (BuildContext context) => new ProfilePage(),
          },
        ));
  }
}

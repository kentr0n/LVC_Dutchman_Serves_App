import 'package:dutchmenserve/Infrastructure/cubit/report_cubit.dart';
import 'package:dutchmenserve/Infrastructure/cubit/report_state.dart';
import 'package:dutchmenserve/Presentation/reportNewHours.dart';
import 'package:dutchmenserve/models/event.dart';
import 'package:dutchmenserve/models/interest.dart';
import 'package:dutchmenserve/models/report.dart';
import 'package:dutchmenserve/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauges;

/*
This class builds a summary page of service hours:
- total in the center
- gradient progress ring: to bronze, silver, and gold awards
- middle circle breaks down hours by community vs campus hours
- outer circle breaks down hours by interest/need area
scroll to see full legend

FAB brings user to report new hours.  
Navigation passes instance of ReportCubit so listener can track 
whether new reports are received or fail.
*/

class _PieData {
  _PieData(this.xData, this.yData, [this.text, this.color]);
  final String xData;
  final num yData;
  final String text;
  final Color color;
}

// does this really need to be stateful?????? no, change to stateless once bloc hooked up
class ReportHoursPage extends StatefulWidget {
  final User user;
  ReportHoursPage(this.user, {Key key}) : super(key: key);

  @override
  _ReportHoursState createState() => _ReportHoursState(user);
}

class _ReportHoursState extends State<ReportHoursPage> {
  User user;
  _ReportHoursState(this.user);

  final List<Color> camCom = [
    const Color(0xffCCCCFF),
    const Color(0xff8D9EFA),
  ];

  // show breakdown by interest
  Widget interestDonut(List<double> counts, List<Interest> interests) {
    List<_PieData> pieData = List<_PieData>.filled(10, null, growable: false);
    for (int i = 1; i < 11; i++) {
      pieData[i - 1] = _PieData(
        interests[i - 1].interest,
        counts[i],
        (counts[i] / counts[11] * 100).round().toString() + '%',
        interests[i - 1].getColor().withOpacity(0),
      );
    }
    return SfCircularChart(
      margin: const EdgeInsets.all(0),
      tooltipBehavior: TooltipBehavior(
        tooltipPosition: TooltipPosition.pointer,
        enable: true,
        format: 'point.x point.y',
        duration: 1750,
      ),
      series: <DoughnutSeries<_PieData, String>>[
        DoughnutSeries<_PieData, String>(
          explode: true,
          explodeIndex: 0,
          explodeOffset: '0%',
          innerRadius: '90%',
          dataSource: pieData,
          xValueMapper: (_PieData data, _) => data.xData,
          yValueMapper: (_PieData data, _) => data.yData,
          dataLabelMapper: (_PieData data, _) => data.text,
          pointColorMapper: (_PieData data, _) => data.color,
          dataLabelSettings: DataLabelSettings(
            isVisible: false,
            showZeroValue: false,
          ),
        ),
      ],
    );
  }

  // show breakdown by community/campus
  Widget serviceTypeDonut(List<double> counts) {
    List<_PieData> data = [
      _PieData(
        'Campus',
        counts[12],
        (counts[12] / counts[0]).round().toString() + '%',
        camCom[0],
      ),
      _PieData(
        'Community',
        counts[13],
        (counts[13] / counts[0]).round().toString() + '%',
        camCom[1],
      )
    ];
    // or red: 0xffA02A2C
    return SfCircularChart(
      margin: const EdgeInsets.all(0),
      tooltipBehavior: TooltipBehavior(
        tooltipPosition: TooltipPosition.pointer,
        enable: true,
        format: 'point.x point.y',
        duration: 1750,
      ),
      series: <DoughnutSeries<_PieData, String>>[
        DoughnutSeries<_PieData, String>(
          explode: true,
          explodeIndex: 0,
          explodeOffset: '0%',
          innerRadius: '90%',
          dataSource: data,
          xValueMapper: (_PieData data, _) => data.xData,
          yValueMapper: (_PieData data, _) => data.yData,
          dataLabelMapper: (_PieData data, _) => data.text,
          pointColorMapper: (_PieData data, _) => data.color,
          dataLabelSettings: DataLabelSettings(
            isVisible: false,
            showZeroValue: false,
          ),
        ),
      ],
    );
  }

  // show progress till Gold Award
  // Gold: 100+ hours of community service AND at least one residential service project
  // or 250+ hours of community service
  // Silver:
  // Bronze:
  Widget radialBar(List<double> counts) {
    double progress = counts[0];
    if (counts[14] > 0) progress += 150;

    String value = progress.toString();
    if (progress % 1 == 0) value = progress.toStringAsFixed(0);

    return gauges.SfRadialGauge(
      axes: <gauges.RadialAxis>[
        gauges.RadialAxis(
          minimum: 0,
          maximum: 250,
          showLabels: false,
          showTicks: false,
          axisLineStyle: gauges.AxisLineStyle(
            thickness: 0.15,
            cornerStyle: gauges.CornerStyle.bothCurve,
            color: Color.fromARGB(30, 0, 169, 181),
            thicknessUnit: gauges.GaugeSizeUnit.factor,
          ),
          pointers: <gauges.GaugePointer>[
            gauges.RangePointer(
              value: progress,
              width: 0.05,
              pointerOffset: .05,
              sizeUnit: gauges.GaugeSizeUnit.factor,
              cornerStyle: gauges.CornerStyle.startCurve,
              gradient: SweepGradient(
                colors: const <Color>[
                Color(0xFF00a9b5),
                Color(0xFFa4edeb)
              ], stops: <double>[
                0.25,
                0.75
              ]),
            ),
            gauges.MarkerPointer(
              value: progress,
              markerType: gauges.MarkerType.diamond,
              color: const Color(0xFF87e8e8),
            )
          ],
          annotations: <gauges.GaugeAnnotation>[
            gauges.GaugeAnnotation(
              positionFactor: 0.1,
              angle: 90,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'T O T A L',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    value,
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            )
          ],
        ),
        gauges.RadialAxis(
          minimum: 0,
          interval: 1,
          maximum: 3,
          showLabels: false,
          showTicks: true,
          showAxisLine: false,
          tickOffset: -0.05,
          offsetUnit: gauges.GaugeSizeUnit.factor,
          minorTicksPerInterval: 0,
          majorTickStyle: gauges.MajorTickStyle(
              length: 0.3,
              thickness: 3,
              lengthUnit: gauges.GaugeSizeUnit.factor,
              color: const Color(0xfff9f9f9)),
        )
      ],
    );
  }

  // function to count up hours given list of all reports and user id
  // should User object track this?
  // let index 0 be total;
  // 1-10 be for each interest; 11 be adjusted total for interests;
  // 12-13 be for campus/community
  // 14 be for residential
  List<double> countHours(
      List<Report> reports, List<Event> events, List<Interest> interests) {
    List<double> counts = List<double>.filled(15, 0, growable: false);
    for (Report r in reports) {
      Event e = events.singleWhere(
        (element) => element.id == r.eid,
        orElse: () {
          return null;
        },
      );
      if (e == null) {
        continue;
      }
      counts[0] += r.hours;
      for (int i in e.interests) {
        counts[i] += r.hours;
        counts[11] += r.hours;
      }
      if (e.isCommunity)
        counts[13] += r.hours;
      else //campus
        counts[12] += r.hours;
      if (e.isResidential) counts[14]++;
    }
    return counts;
  }

  Widget legendItem(String text, {Color color, Gradient gradient}) {
    Widget child;
    if (color == null) {
      child = Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(gradient: gradient, shape: BoxShape.circle),
        margin: const EdgeInsets.symmetric(horizontal: 10),
      );
    } else {
      child = Container(
        height: 15,
        width: 15,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget legend(List<Interest> interests) {
    return Container(
      color: Colors.grey[200],
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Container(height: 20),
          Text(
            "LEGEND",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 19,
            ),
          ),
          Container(height: 10),
          legendItem(
            'Progress to Service Award',
            gradient: SweepGradient(colors: <Color>[
              const Color(0xFF00a9b5),
              const Color(0xFFa4edeb)
            ], stops: <double>[
              0.25,
              0.75
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              legendItem(
                'Campus',
                color: camCom[0],
              ),
              SizedBox(width: 40),
              legendItem(
                'Community',
                color: camCom[1],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              interests.length,
              (i) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: interests[i].getColor(),
                ),
                padding: const EdgeInsets.all(5),
                child: Icon(
                  IconData(interests[i].iconDataConstant,
                      fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Text('Tap outer ring to see interest labels!',
                style: TextStyle(fontSize: 14)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text('Note: Pull down to refresh.',
                style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Future _refreshReportsList() async {
    BlocProvider.of<ReportCubit>(context).getReports(user.id);
  }

  @override
  Widget build(BuildContext context) {
    final reportBloc = BlocProvider.of<ReportCubit>(context);
    reportBloc.getReports(user.id);
    return BlocConsumer<ReportCubit, ReportState>(
      listener: (context, state) {
        if (state is SendReportFailedState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Oops! Something went wrong submitting the report for " +
                      state.eventName +
                      ". Please refresh and resubmit."),
              action: SnackBarAction(
                textColor: Colors.blue,
                label: 'OK',
                onPressed: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        } else if (state is SendReportSuccessState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content:
                  Text("Your report for " + state.eventName + " was received!"),
              action: SnackBarAction(
                textColor: Colors.blue,
                label: 'OK',
                onPressed: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ReportLoadedState) {
          List<double> res =
              countHours(state.reports, state.events, state.interests);
          return RefreshIndicator(
            color: Color(0xff206090), //Color(0xff002A4E),
            onRefresh: _refreshReportsList,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            child: radialBar(res), height: 200, width: 200),
                        Container(
                          child: serviceTypeDonut(res),
                          height: 300,
                          width: 300,
                        ),
                        Container(
                            child: interestDonut(res, state.interests),
                            height: 380),
                      ],
                    ),
                    legend(state.interests),
                  ],
                ),
              ),
              floatingActionButton: fab(context, reportBloc),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            ),
          );
        } else if (state is ReportLoadingState) {
          return Dialog(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Text("Loading"),
              ],
            ),
          );
        } else if (state is ReportErrorState) {
          return RefreshIndicator(
            color: Color(0xff206090), //Color(0xff002A4E),
            onRefresh: _refreshReportsList,
            child: SingleChildScrollView(
              child: Center(child: Icon(Icons.close)),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget fab(BuildContext context, ReportCubit repBloc) {
    return FloatingActionButton(
      backgroundColor: const Color(0xffFFE400),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute<ReportNewHours>(builder: (context) {
          return BlocProvider.value(
            value: repBloc,
            child: ReportNewHours(user),
          );
        }));

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ReportNewHours(user)),
        // );
      },
      // mini: true,
      tooltip: 'Report Hours',
      child: Icon(Icons.add, color: Colors.black),
    );
  }
}

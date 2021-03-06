import 'package:hourly/Provider/AlarmProvider.dart';
import 'package:hourly/Widgets/AlarmWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<AlarmProvider>(context, listen: false).alarmList;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          elevation: 0,
          title: Text('Hourly', style: TextStyle(fontFamily: 'avenir')),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))),
        ),
        body: Consumer<AlarmProvider>(
          builder: (context, provider, _) {
            if (provider.fetching)
              return Center(child: CircularProgressIndicator());
            else
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: true,
                    itemCount: provider.alarmLength,
                    itemBuilder: (BuildContext context, int index) {
                      return AlarmWidget(
                        time: provider.alarmList[index].key,
                        value: provider.alarmList[index].status,
                        onChanged: (status) => provider.alarmStatus(index, status),
                      );
                    },
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

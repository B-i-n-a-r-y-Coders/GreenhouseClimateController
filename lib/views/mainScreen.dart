import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghclimatecon/controllers/dataCenter.dart';
import 'package:ghclimatecon/models/dataModel.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GreenHouseDataControlller greenHouseDataControlller =
      Get.put(GreenHouseDataControlller());
  Timer timer;
  List<Feed> feed = [];
  DataModel dataModel;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      feed = await greenHouseDataControlller.getDataFromThingspeak();
      print('called');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text('Main Screen'),
          ),
          RaisedButton(onPressed: () {
            greenHouseDataControlller.getDataFromThingspeak();
          }),
          FutureBuilder(
              future: Future.delayed(Duration(seconds: 10)),
              builder: (context, snapshot) {
                return Container(
                    decoration: BoxDecoration(color: Colors.red.shade100),
                    height: 400,
                    child: ListView.builder(
                        itemBuilder: (ctx, i) {
                          return Text(
                              '${greenHouseDataControlller.feed[i]} index : $i ');
                        },
                        itemCount: greenHouseDataControlller.feed.length));
              }),
        ],
      ),
    );
  }
}

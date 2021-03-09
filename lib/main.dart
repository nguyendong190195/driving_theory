import 'dart:convert';

import 'package:driving_theory/extension/colors_extension.dart';
import 'package:driving_theory/models/topic_object.dart';
import 'package:flutter/material.dart';
import 'package:driving_theory/screens/tab1/practice_all_question_screen.dart';
import 'package:driving_theory/screens/tab2/mock_tests_screen.dart';
import 'package:driving_theory/screens/tab3/help_support_screen.dart';

import 'extension/utility.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[];
    return MaterialApp(
        title: _title,
        home: FutureBuilder(
          future: Utility.getDataCacheByTopicName(),
          builder: (context, snapshot) {
            Data? dataCacheSave;
            if (snapshot.data != null) {
              dataCacheSave = snapshot.data as Data;
            }
            return FutureBuilder(
              future: Utility.getDataByName(),
              builder: (context, snapshot) {
                _widgetOptions.clear();
                DataTopic? dataCache;
                if (snapshot.data != null) {
                  dataCache = snapshot.data as DataTopic;
                }
                return FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('data/data.json'),
                  builder: (context1, snapshot1) {
                    var new_data = json.decode(snapshot1.data.toString());
                    DataTopic data = DataTopic('title');
                    if (new_data != null) {
                      data = DataTopic.fromJson(new_data);
                    }
                    if (data != null && new_data != null && data.data != null) {
                      _widgetOptions.add(PracticeAllQuestionScreen(
                          dataCache != null ? dataCache : data.clone(), dataCacheSave));
                      _widgetOptions.add(MockTestsScreen(data.clone()));
                      _widgetOptions.add(HelpAndSupportScreen());
                    }

                    return MyStatefulWidget(_widgetOptions);
                  },
                );
              },
            );
          },
        ));
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  List<Widget> widgets;

  MyStatefulWidget(this.widgets);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.normal);
  static const TextStyle optionStyleNormal =
      TextStyle(fontSize: 12, fontWeight: FontWeight.normal);

  // PracticeAllQuestionScreen(),
  // MockTestsScreen(),
  // HelpAndSupportScreen()
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: widget.widgets.length > 0
              ? widget.widgets[_selectedIndex]
              : Container()),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer_outlined),
            label: 'Practice all questions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.time_to_leave_outlined),
            label: 'Mock Tests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent_outlined),
            label: 'Help & Support',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: HexColor.mainColor(),
        selectedLabelStyle: optionStyle,
        unselectedLabelStyle: optionStyleNormal,
        onTap: _onItemTapped,
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bahanlatihan/widgets/gridview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './models/activity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SimpelTodoApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SimpelTodoApp extends StatefulWidget {
  @override
  _SimpelTodoAppState createState() => _SimpelTodoAppState();
}

class _SimpelTodoAppState extends State<SimpelTodoApp> {
  List<Activity> _userActivuty = [
    Activity(
      id: '1',
      title: 'Bersih Bersih Rumah',
      subTitle: 'Bersihi kamar tidur',
    ),
    Activity(
      id: '2',
      title: 'Ngerjakna Kalkulus',
      subTitle: 'Kalkulus Materi 11',
    ),
    Activity(
      id: '3',
      title: 'Ngerjakna KOPRO',
      subTitle: 'KOPRO Materi 11',
    ),
    Activity(
      id: '4',
      title: 'Belajar Flutter',
      subTitle: 'State Management',
    ),
    Activity(
      id: '5',
      title: 'Nonton Kalle Halden',
      subTitle: 'What is agil scrum',
    ),
  ];

  final _titleController = TextEditingController();

  final _descController = TextEditingController();

  void addTask(BuildContext context) {
    _titleController.clear();
    _descController.clear();
    awesomeDialog(context, DialogType.INFO, 'Add New ToDo List');
  }

  void editTask(BuildContext context) {
    awesomeDialog(context, DialogType.INFO, 'Edit Current ToDo List');
  }

  AwesomeDialog awesomeDialog(
      BuildContext context, DialogType a, String title) {
    return AwesomeDialog(
      context: context,
      dialogType: a,
      animType: AnimType.SCALE,
      // title: 'Dialog Title',
      // desc: 'Dialog description here.............',
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title of ToDo',
                prefixIcon: Icon(
                  Icons.title,
                ),
              ),
            ),
            TextField(
              controller: _descController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Description of ToDo',
                prefixIcon: Icon(
                  Icons.description,
                ),
              ),
            ),
          ],
        ),
      ),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        setState(() {
          submitData();
        });
      },
    )..show();
  }

  void submitData() {
    if (_titleController.text.isEmpty || _descController.text.isEmpty) {
      return;
    }
    _userActivuty.add(
      Activity(
          id: Random().nextInt(5).toString(),
          title: _titleController.text,
          subTitle: _descController.text),
    );
    _titleController.clear();
    _descController.clear();
  }

  String _timeString;
  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: BottomAppBar(
        //   clipBehavior: Clip.antiAliasWithSaveLayer,
        //   shape: CircularNotchedRectangle(),
        //   child: Container(
        //     height: 60.0,
        //     color: Colors.indigo,
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addTask(context);
          },
          backgroundColor: Colors.indigo,
          child: Icon(
            Icons.add,
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Todo Application'),
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
        drawer: Drawer(),
        body: Center(
          child: Container(
            color: Colors.indigo,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.indigo,
                  margin: EdgeInsets.only(
                    bottom: 30.0,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _timeString,
                        style: TextStyle(fontSize: 55.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Current Time',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                TodoList(
                  titleController: _titleController,
                  descController: _descController,
                  userActivity: _userActivuty,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

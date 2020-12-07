import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_crud/bloc/scientist_bloc.dart';
import 'package:sql_crud/database_helper.dart';
import 'package:sql_crud/model.dart';

class AddNewScientist extends StatefulWidget {
  @override
  _AddNewScientistState createState() => _AddNewScientistState();
}

class _AddNewScientistState extends State<AddNewScientist> {
  DatabaseHelper helper = DatabaseHelper();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController knownForCtrl = TextEditingController();
  TextEditingController urlCtrl = TextEditingController();
  Map<String, dynamic> detail = {'name': '', 'known_for': '', 'image_url': ''};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime[700],
        title: Text('Add New'),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), labelText: 'Name'),
              onChanged: (val) {
                detail['name'] = val;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: knownForCtrl,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.group_work_outlined),
                  labelText: 'Known for'),
              onChanged: (val) {
                detail['known_for'] = val;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: urlCtrl,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.link), labelText: 'Image url'),
              onChanged: (val) {
                detail['image_url'] = val;
              },
            ),
            const SizedBox(
              height: 32,
            ),
            RaisedButton.icon(
                color: Colors.lime[800],
                onPressed: () {
                  BlocProvider.of<ScientistBloc>(context).add(
                      ScientistAddEvent(scientist: Scientist.fromJson(detail)));
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.save_rounded,
                  color: Colors.white,
                ),
                label: Text(
                  'SAVE',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      )),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'HTTPHelper.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class addTask extends StatefulWidget {
  const addTask({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _addTaskState createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  var subject = TextEditingController();
  var description = TextEditingController();
  String statusValueChoose = 'Open';
  String priorityValueChoose = 'Low';
  String? project;
  String? type;
  String? parentTask;
  List<String> projectList = [];
  List<String> typeList = [];
  List<String> parentTaskList = [];
  DateTime? _selectedDate;
  String? date;

  Future<void> posts() async {
    projectList = await HTTPHelper().fetchProject();
    typeList = await HTTPHelper().fetchType();
    parentTaskList = await HTTPHelper().fetchParentTask();
  }

  List statusItem = [
    "Open",
    "Working",
    "Pending Review",
    "Overdue",
    "Template",
    "Completed",
    "Cancelled"
  ];

  List priorityItem = ["Low", "Medium", "High", "Urgent"];

  @override
  void initState() {
    posts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: subject,
                decoration: InputDecoration(
                  labelText: 'Enter Subject',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                          BorderSide(color: Colors.deepOrange, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.black45, width: 2)),
                )),
            Container(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(16)),
              child: DropdownButton(
                padding: EdgeInsets.only(left: 16, right: 16),
                hint: Text("Select Status"),
                borderRadius: BorderRadius.circular(16),
                dropdownColor: Colors.white,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 32,
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: Colors.black, fontSize: 16),
                value: statusValueChoose,
                onChanged: (newValue) {
                  setState(() {
                    statusValueChoose = newValue.toString();
                  });
                },
                items: statusItem.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(16)),
              child: DropdownButton(
                padding: EdgeInsets.only(left: 16, right: 16),
                hint: Text("Select Projects"),
                borderRadius: BorderRadius.circular(16),
                dropdownColor: Colors.white,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 32,
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: Colors.black, fontSize: 16),
                value: project,
                onChanged: (String? newValue) {
                  setState(() {
                    project = newValue;
                  });
                },
                items: projectList.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(16)),
              child: DropdownButton(
                padding: EdgeInsets.only(left: 16, right: 16),
                hint: Text("Select Priority"),
                borderRadius: BorderRadius.circular(16),
                dropdownColor: Colors.white,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 32,
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: Colors.black, fontSize: 16),
                value: priorityValueChoose,
                onChanged: (newValue) {
                  setState(() {
                    priorityValueChoose = newValue.toString();
                  });
                },
                items: priorityItem.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(16)),
              child: DropdownButton(
                padding: EdgeInsets.only(left: 16, right: 16),
                hint: Text("Select Type"),
                borderRadius: BorderRadius.circular(16),
                dropdownColor: Colors.white,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 32,
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: Colors.black, fontSize: 16),
                value: type,
                onChanged: (String? newValue) {
                  setState(() {
                    type = newValue;
                  });
                },
                items: typeList.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(16)),
              child: DropdownButton(
                padding: EdgeInsets.only(left: 16, right: 16),
                hint: Text("Select Parent Task"),
                borderRadius: BorderRadius.circular(16),
                dropdownColor: Colors.white,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 32,
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: Colors.black, fontSize: 16),
                value: parentTask,
                onChanged: (String? newValue) {
                  setState(() {
                    parentTask = newValue;
                  });
                },
                items: parentTaskList.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
            Container(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Row(children: [
                Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await _selectDate(context);
                  },
                  child: Text('Select Date'),
                ),
              ]),
            ),
            Container(
              height: 8,
            ),
            TextField(
              controller: description,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Enter Description',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.black45, width: 2)),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  String Subject = subject.text;
                  String Description = description.text;

                  submit();
                  print(
                      "Subject: $Subject, Description: $Description, Status: $statusValueChoose, "
                      "Priority: $priorityValueChoose, Type: $type, Selected Date: $_selectedDate");
                },
                child: Text('Submit')),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        date = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<bool> submit() async {
    try {
      var data = {
        "subject": subject.text,
        "project": project,
        "status": statusValueChoose,
        "priority": priorityValueChoose,
        "type": type,
        "parentTask": parentTask,
        "exp_end_date": date,
        "description": description.text,
      };

      var body = json.encode(data);
      var dio = Dio();
      var response = await dio.request(
        'https://mobilecrm.erpdata.in/api/resource/Task',
        options: Options(
          method: 'POST',
          headers: {'Authorization': "token c2e4e54edf095c2:e25d998f1e6cfff"},
        ),
        data: body,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Task Added Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.lightBlue);
        Navigator.pop(context);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Fluttertoast.showToast(
        gravity: ToastGravity.BOTTOM,
        msg:
            'Error: ${e.response!.data["exception"].toString().split(":").elementAt(1).trim()} ',
        textColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFFBA1A1A),
      );
    }
    return false;
  }
}

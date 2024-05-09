import 'package:flutter/material.dart';
import 'package:form_2/task_model.dart';
import 'HTTPHelper.dart';
import 'addTask.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tasks',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? task;
  List<TaskList> taskList = [];

  Future<void> posts() async {
    taskList = await HTTPHelper().fetchTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        // Theme.of(context).colorScheme.background,
        title: Text(widget.title),
      ),
      body: FutureBuilder<void>(
        future: posts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color(0xFFE1F5FE),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, top: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      taskList[index].priority ??
                                          "Data not found",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF378805),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 32, top: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      taskList[index].status ??
                                          "Data not found",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF5050FF),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 4, bottom: 4),
                          child: Text("Project:  ",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFFFF0000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 4),
                          child: Text(
                            taskList[index].name ?? "Data not found",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF5050FF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),]),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 4, bottom: 4),
                          child: Text("Subject:  ",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFFFF0000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            taskList[index].subject ?? "Data not found",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFF5050FF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),]),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.calendar_month, color: Colors.grey),
                          Padding(
                            padding: const EdgeInsets.only(left: 8,bottom: 8),
                            child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Text(
                                  taskList[index].expEndDate ?? "Data not found",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const addTask(title: 'Add Task')),);
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}

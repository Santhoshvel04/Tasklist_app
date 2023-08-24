import 'package:flutter/material.dart';
import 'package:flutter_app_testing/FirstPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List task = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task List',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SecondPage(
        taskLists: task,
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final taskLists;
  const SecondPage({
    super.key,
    required this.taskLists,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int selectedIndex = -1;
  List task = [];
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: Column(
        children: [
          task.isEmpty
              ? Center(
                  child: const Text(
                    'No Tasks or Yet',
                    style: TextStyle(
                      fontSize: 22,
                      height: 5.0,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: task.length,
                  itemBuilder: (context, index) => getRow(index),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FirstPage(
                status: "add",
                arr: (v) {
                  setState(() {
                    task.add(v);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getRow(int index) {
    print("the tileee is : ${task[index]}");
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Card(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          elevation: 5,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task[index]["title"],
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  task[index]["description"],
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Text(
                      task[index]["date"],
                      style: const TextStyle(
                        fontSize: 8.0,
                        color: Colors.grey,
                        height: 1.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: SizedBox(
              width: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onTap: (() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FirstPage(
                            status: "edit",
                            value: task[index],
                            arr: (v) {
                              setState(() {
                                task[index] = v;
                              });
                            },
                          ),
                        ),
                      );
                      setState(() {
                        selectedIndex = index;
                      });
                      _titleController.text = task[index].title;
                      _descriptionController.text = task[index].description;
                      _dateController.text = task[index].date;
                    }),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onTap: (() {
                      setState(() {
                        task.removeAt(index);
                      });
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}

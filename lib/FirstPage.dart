import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  final status;
  final value;
  final ValueChanged arr;
  const FirstPage({super.key, required this.arr, this.value, this.status});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  List task = [];

  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    if (widget.status == "edit") {
      setState(() {
        _titleController.text = widget.value["title"];
        _descriptionController.text = widget.value["description"];
        _dateController.text = widget.value['date'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.status == "add" ? 'Add Task' : 'Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Title'),
                    SizedBox(
                      width: 60.0,
                    ),
                    new Flexible(
                      child: new TextField(
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Description'),
                    SizedBox(
                      width: 20.0,
                    ),
                    new Flexible(
                      child: new TextField(
                        controller: _descriptionController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        width: 70,
                        height: 50,
                        child: Text('Task Date and Time')),
                    SizedBox(
                      width: 20.0,
                    ),
                    new Flexible(
                      child: new TextField(
                        decoration: const InputDecoration(
                          // hintText: 'Date and time',
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                        ),
                        controller: _dateController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.utc(2023),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2050));

                          if (pickedDate != null) {
                            _dateController.text = pickedDate.toString();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Container(
                  height: 400,
                  width: 300,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          String title = _titleController.text.trim();
                          String description =
                              _descriptionController.text.trim();
                          String date = _dateController.text.trim();
                          if (title.isNotEmpty &&
                              description.isNotEmpty &&
                              date.isNotEmpty) {
                            setState(() {
                              _titleController.text = '';
                              _descriptionController.text = '';
                              _dateController.text = '';
                            });
                          }
                          debugPrint("the tasksss : $task");
                          Navigator.of(context).pop();
                          widget.arr({
                            "title": title,
                            "description": description,
                            "date": date,
                          });
                        },
                        child: Text(widget.status == "add"
                            ? 'Add Task'
                            : "Update Task"),
                      ),
                    ],
                  ),
                ),
              ),
              // Center(
              //   child: Container(
              //     height: 100,
              //     width: 300,
              //     alignment: Alignment.bottomCenter,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         ElevatedButton(
              //           onPressed: () {
              //             String title = _titleController.text.trim();
              //             String description =
              //                 _descriptionController.text.trim();
              //             String date = _dateController.text.trim();
              //             if (title.isNotEmpty &&
              //                 description.isNotEmpty &&
              //                 date.isNotEmpty) {
              //               setState(() {
              //                 // _titleController.text = '';
              //                 // _descriptionController.text = '';
              //                 // _dateController.text = '';
              //                 task.add({
              //                   "title": title,
              //                   "description": description,
              //                   "date": date
              //                 });
              //               });
              //             }
              //             debugPrint("the tasksss : $task");
              //             Navigator.of(context).push(
              //               MaterialPageRoute(
              //                 builder: (context) => SecondPage(
              //                   taskLists: task,
              //                 ),
              //               ),
              //             );
              //           },
              //           child: Text('Update Task'),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

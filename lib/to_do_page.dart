import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final TextEditingController _taskController = TextEditingController();
  final List<Map<String, dynamic>> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text(
          'TODO App',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 5,
        shadowColor: Colors.grey,
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Add task...',
                      labelText: 'Task',
                      prefixIcon: Icon(Icons.task_alt, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      String task = _taskController.text.trim();
                      if (task.isNotEmpty) {
                        _tasks.add({"title": task, "done": false});

                        _taskController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Task Added Successfully!')),
                        );
                      }
                    });
                  },

                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,

                  child: Icon(Icons.add, size: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return Dismissible(
                    key: Key(
                      _tasks[index]["title"] + index.toString(),
                    ), // unique key
                    direction: DismissDirection.endToStart, // swipe left
                    onDismissed: (direction) {
                      final deletedTask = task;
                      setState(() {
                        _tasks.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Task deleted!'),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              setState(() {
                                _tasks.insert(index, deletedTask);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white, size: 30),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: Colors.teal[200],
                        leading: IconButton(
                          icon: Icon(
                            _tasks[index]["done"]
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            setState(() {
                              _tasks[index]["done"] = !_tasks[index]["done"];
                            });
                          },
                        ),
                        title: Text(
                          _tasks[index]["title"],
                          style: TextStyle(
                            decoration: _tasks[index]["done"]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

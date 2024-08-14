import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Map<String, String>> tasks = [
    {
      'title': 'Inspect Western Fence',
      'description': 'Check for any damages or breaches in the western fence.',
      'dueDate': '2024-08-15',
      'status': 'Pending'
    },
    {
      'title': 'Monitor Wildlife Activity',
      'description': 'Observe and report any unusual animal behavior in the park.',
      'dueDate': '2024-08-16',
      'status': 'Completed'
    },
    // Add more tasks as needed
  ];

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String description = '';
        String dueDate = '';
        String status = 'Pending';

        return AlertDialog(
          title: Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Due Date'),
                onChanged: (value) {
                  dueDate = value;
                },
              ),
              DropdownButton<String>(
                value: status,
                onChanged: (String? newValue) {
                  setState(() {
                    status = newValue!;
                  });
                },
                items: <String>['Pending', 'Completed']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text('Select Status'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks.add({
                    'title': title,
                    'description': description,
                    'dueDate': dueDate,
                    'status': status,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Add Task'),
            ),
          ],
        );
      },
    );
  }

  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addTask,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Dismissible(
            key: Key(task['title'] ?? ''),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              _removeTask(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Task removed'),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(task['title'] ?? ''),
                subtitle: Text(task['description'] ?? ''),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Due: ${task['dueDate'] ?? ''}'),
                    Text(
                      task['status'] ?? '',
                      style: TextStyle(
                        color: task['status'] == 'Completed'
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Student {
  final String name;
  final String fatherName;
  final String idCard;
  final String rollNumber;

  Student({required this.name, required this.fatherName, required this.idCard, required this.rollNumber});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _name = '';
  String _fatherName = '';
  String _idCard = '';
  String _rollNumber = '';

  void _submitData() {
    // Display data in a dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Student Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: $_name'),
              Text('Father\'s Name: $_fatherName'),
              Text('ID Card: $_idCard'),
              Text('Roll Number: $_rollNumber'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page '),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Add Student screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudentScreen(
                      onSave: (name, fatherName, idCard, rollNumber) {
                        setState(() {
                          _name = name;
                          _fatherName = fatherName;
                          _idCard = idCard;
                          _rollNumber = rollNumber;
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Add Student'),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Show Student Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddStudentScreen extends StatelessWidget {
  final Function(String, String, String, String) onSave;

  AddStudentScreen({required this.onSave});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController idCardController = TextEditingController();
  final TextEditingController rollNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: fatherNameController,
              decoration: InputDecoration(labelText: 'Father\'s Name'),
            ),
            TextField(
              controller: idCardController,
              decoration: InputDecoration(labelText: 'ID Card'),
            ),
            TextField(
              controller: rollNumberController,
              decoration: InputDecoration(labelText: 'Roll Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save student data and pop screen
                onSave(
                  nameController.text,
                  fatherNameController.text,
                  idCardController.text,
                  rollNumberController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

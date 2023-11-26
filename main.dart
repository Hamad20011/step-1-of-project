import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Form'),
        ),
        body: UserForm(),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  int labelId = 0;
  String username = '';
  String gender = '';
  List<Map<String, String>> users = [
    {'id': '1', 'name': 'HAMAD', 'gender': 'Male'},
    {'id': '2', 'name': 'Nadim', 'gender': 'Male'},
    {'id': '3', 'name': 'DR KAMAL', 'gender': 'Male'},
    {'id': '4', 'name': 'MAHER', 'gender': 'Male'},
  ];

  bool isButtonEnabled() {
    return labelId != 0 && username.isNotEmpty && gender.isNotEmpty;
  }

  bool isAddButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID:'),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  labelId = int.tryParse(value) ?? 0;
                  isAddButtonEnabled = false; // Disable  ID change
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Username:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  username = value;
                  isAddButtonEnabled = false; // Disable  username change
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Gender:'),
            Row(
              children: [
                Radio(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                      isAddButtonEnabled = false; 
                    });
                  },
                ),
                Text('Male'),
                Radio(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                      isAddButtonEnabled = false; // Disable gender Hamad Nadim
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isButtonEnabled()
                  ? () {
                Map<String, String> newUser = {
                  'id': labelId.toString(),
                  'name': username,
                  'gender': gender,
                };
                setState(() {
                  users.add(newUser);
                  isAddButtonEnabled = true; // Enable "Let's Go" 
                });

                setState(() {
                  labelId = 0;
                  username = '';
                  gender = '';
                });
              }
                  : null,
              child: Text('Add'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: isAddButtonEnabled
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage()),
                );
              }
                  : null,
              child: Text("Let's Go"),
            ),
            SizedBox(height: 20.0),
            Text(
              'User List:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Card(
                elevation: 4.0,
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        'ID: ${users[index]['id']}, Name: ${users[index]['name']}, Gender: ${users[index]['gender']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
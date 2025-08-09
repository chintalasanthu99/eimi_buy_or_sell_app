import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  String _role = 'user'; // default role

  Future<void> _register() async {
    final response = await http.post(
      Uri.parse("http://your-api-url.com/api/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": _nameCtrl.text,
        "email": _emailCtrl.text,
        "password": _passwordCtrl.text,
        "role": _role,
      }),
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registered successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${result['message'] ?? result}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameCtrl, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _emailCtrl, decoration: InputDecoration(labelText: 'Email')),
            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 10),
            Text("Select Role:"),
            RadioListTile(
              title: Text("User"),
              value: 'user',
              groupValue: _role,
              onChanged: (val) => setState(() => _role = val!),
            ),
            RadioListTile(
              title: Text("Vendor"),
              value: 'vendor',
              groupValue: _role,
              onChanged: (val) => setState(() => _role = val!),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}

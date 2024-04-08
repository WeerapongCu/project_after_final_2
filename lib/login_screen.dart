import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'register_screen.dart';
import 'UserListPage.dart';
import 'period_form_screen.dart';
import 'calendar_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _message = '';

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    try {
      // Load user data from users.json
      final String usersJson =
          await DefaultAssetBundle.of(context).loadString('assets/users.json');
      final List<dynamic> users = jsonDecode(usersJson);

      // Find user by username
      final user = users.firstWhere((user) => user['username'] == username,
          orElse: () => null);

      if (user != null && user['password'] == password) {
        setState(() {
          _message = 'Login successful';
          if (user['Used'] == true) {
            _goTocalendar_screen(DateTime.parse(user['date_to_used']));
          } else {
            _goToPeriodFormScreen();
          }
        });
        // Navigate to home screen
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _message = 'Invalid username or password';
        });
      }
    } catch (e) {
      setState(() {});
    }
  }

  void _goToRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  void _goToUserListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserListPage()),
    );
  }

  void _goToPeriodFormScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PeriodFormScreen()),
    );
  }

  void _goTocalendar_screen(DateTime firstDay) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CalendarScreen(
                firstDay: firstDay,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _goToRegisterScreen,
              child: Text('Register'),
            ),
            SizedBox(height: 16.0),
            Text(_message),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _goToUserListPage,
              child: Text('ดูว่ารหัสเป็นอะไร'),
            ),
          ],
        ),
      ),
    );
  }
}

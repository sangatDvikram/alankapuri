import 'package:alankapuri/constants/constants.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Column(
          children: [
            Center(
              child: Text(LOGIN_TITLE),
            )
          ],
        ),
        elevation: 0,
      ),
    );
  }
}

import 'package:alankapuri/constants/constants.dart';
import 'package:alankapuri/pages/login.dart';
import 'package:flutter/material.dart';

class BottonNavigation extends StatefulWidget {
  const BottonNavigation({super.key});

  @override
  State<BottonNavigation> createState() => _BottonNavigationState();
}

class _BottonNavigationState extends State<BottonNavigation> {
  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      onTap: (tapped){
        print('Tappend on ${tapped}');
        if (tapped==1){
          Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (Route<dynamic> route) => false);
        }
      },
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: 'Security',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Logout',
        )
      ],
    );
  }
}

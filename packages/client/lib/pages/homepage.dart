import 'package:alankapuri/components/molecules/bottomNavigation.dart';
import 'package:alankapuri/constants/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _listTapped(String routeName){
    print('List tapped');
    Navigator.pushNamed(context, routeName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(APP_TITLE),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Welcome, User',
            style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 16,),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(title:Text('Applications', style: TextStyle(fontWeight: FontWeight.bold),)),
                  ListTile(leading:Icon(Icons.payments),title: Text(MAINTENANCE_TITLE), onTap:()=>_listTapped(MAINTAINANCE_ROUTE),),
                  ListTile(leading:Icon(Icons.celebration),title: Text(EVENTS_TITLE),onTap:()=>_listTapped(EVENTS_ROUTE)),
                  ListTile(leading:Icon(Icons.groups),title: Text(GROUPS_TITLE),onTap:()=>_listTapped(GROUPS_ROUTE)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:const BottonNavigation(),
    );
  }
}

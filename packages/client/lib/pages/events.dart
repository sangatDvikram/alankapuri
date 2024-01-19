import 'package:alankapuri/components/molecules/bottomNavigation.dart';
import 'package:alankapuri/constants/constants.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  void _listTapped(upiApp) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(EVENTS_TITLE),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: Text(
                        'List of Events',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      ListTile(
                        leading: Icon(Icons.celebration),
                        title: Text('Event 1'),
                        onTap: () => _listTapped('1'),
                      ),
                      ListTile(
                        leading: Icon(Icons.cake),
                        title: Text('Event 2'),
                        onTap: () => _listTapped('1'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
      bottomNavigationBar: const BottonNavigation(),
    );
  }
}

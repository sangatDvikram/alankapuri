import 'package:alankapuri/components/molecules/bottomNavigation.dart';
import 'package:alankapuri/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pay_upi/flutter_pay_upi_manager.dart';
import 'package:flutter_pay_upi/model/upi_response.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  void _listTapped(upiApp) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(GROUPS_TITLE),
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
                        'List of Groups',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      ListTile(
                        leading: Icon(Icons.people),
                        title: Text('Group 1'),
                        onTap: () => _listTapped('1'),
                      ),
                      ListTile(
                        leading: Icon(Icons.groups),
                        title: Text('Group 2'),
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

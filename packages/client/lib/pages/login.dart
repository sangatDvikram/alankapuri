import 'package:alankapuri/constants/constants.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _moveToHomePage() {
    Navigator.pushReplacementNamed(
      context,
      HOME_ROUTE,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Expanded(
                              child:  Center(
                            child: SizedBox(
                                height: 300,
                                child: Image(
                                  image:
                                      AssetImage('assets/logo/logo-banner.png'),
                                )),
                          )),
                          Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50)),
                                color: Colors.white,
                              ),
                              child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        LOGIN_TITLE,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const  TextField(
                                        key:  ValueKey(
                                            'carNumberTextField'),
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Enter Phone Number',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ElevatedButton.icon(
                                          onPressed: _moveToHomePage,
                                          key: const ValueKey(
                                              'parkingLotAllotmentButton'),
                                          icon: false
                                              ? Container(
                                                  width: 20,
                                                  height: 20,
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child:
                                                      const CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                                )
                                              : const Icon(Icons.login),
                                          label: const Text('Login')),
                                    ],
                                  ))),
                        ])))));
  }
}

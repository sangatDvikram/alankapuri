import 'package:alankapuri/components/molecules/bottomNavigation.dart';
import 'package:alankapuri/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pay_upi/flutter_pay_upi_manager.dart';
import 'package:flutter_pay_upi/model/upi_response.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  final paymentController =
      TextEditingController(text: MAINTENANCE_AMMOUNT.toString());

  final upiDetails = UPIDetails(
      upiID: MAINTENANCE_UPI_ID,
      payeeName: MAINTENANCE_USER_NAME,
      transactionID: '123456789',
      transactionNote: "Maintainance 302 JAN 2024",
      amount: MAINTENANCE_AMMOUNT.toDouble());

  void _listTapped(upiApp) {
    FlutterPayUpiManager.startPayment(
        paymentApp: upiApp!,
        payeeVpa: MAINTENANCE_UPI_ID,
        payeeName: MAINTENANCE_USER_NAME,
        transactionId: 'TRZ123456789',
        payeeMerchantCode: '5330',
        description: 'Maintanance For Flat 302',
        amount: MAINTENANCE_AMMOUNT.toString(),
        response: (UpiResponse response, String s) {
          // TODO: add your success logic here
          print('Paid Successfully');
          print(response);
          print(s);
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Payment Success'),
                      Text('Transaction Id : ${response.transactionID}'),
                      Text(
                          'Transaction Ref Id: ${response.transactionReferenceId}'),
                      Text(
                          'Transaction Ref Id: ${response.transactionReferenceId}'),
                      ElevatedButton(
                        child: const Text('Close'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        error: (e) {
          print('Error happend');
          print(e);
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Payment Error'),
                      Text('Error : ${e.toString()}'),
                      ElevatedButton(
                        child: const Text('Close'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          // TODO: add your exception logic here
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(MAINTENANCE_TITLE),
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
                TextField(
                  controller: paymentController,
                  key: const ValueKey('carNumberTextField'),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Maintenance Ammount',
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                    child: FutureBuilder(
                        future: FlutterPayUpiManager.getListOfAndroidUpiApps(),
                        builder: (context, snapshot) {
                          print('UPI Apps: ${snapshot.data}');
                          if (snapshot.hasData && snapshot.data!.length > 0) {
                            return Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                      title: Text(
                                    'Pay Using',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        leading: Image.memory(
                                          snapshot.data![index].icon!,
                                          width: 40,
                                          height: 40,
                                        ),
                                        title: Text(snapshot.data![index].app!),
                                        onTap: () => _listTapped(
                                            snapshot.data![index].app),
                                      );
                                    },
                                  )
                                ],
                              ),
                            );
                          }
                          return Text(
                            'No upi application is installed',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          );
                        })),
                UPIPaymentQRCode(
                  upiDetails: upiDetails,
                  embeddedImagePath: 'assets/logo/logo.png',
                  embeddedImageSize: const Size(80, 80),
                ),
              ],
            ),
          )),
      bottomNavigationBar: const BottonNavigation(),
    );
  }
}

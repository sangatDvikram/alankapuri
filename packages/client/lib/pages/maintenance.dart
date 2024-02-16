import 'package:alankapuri/components/molecules/bottomNavigation.dart';
import 'package:alankapuri/constants/constants.dart';
import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pay_upi/flutter_pay_upi_manager.dart';
import 'package:flutter_pay_upi/model/upi_response.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  final _razorpay = Razorpay();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }

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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('Payment success ${response}');
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
                Text('Order Id : ${response.orderId}'),
                Text('Payment Id: ${response.paymentId}'),
                Text('Extra: ${response.data.toString()}'),
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
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Payment error ${response}');
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
                Text('Error : ${response.message}'),
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
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print('Payment via external wallet ${response}');

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
                Text('Data : ${response.walletName}'),
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
                SizedBox(
                  height: 16,
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        final response =
                            await EasyUpiPaymentPlatform.instance.startPayment(
                          EasyUpiPaymentModel(
                            payeeVpa: 'gaurav.jajoo@upi',
                            payeeName: 'Gaurav Jajoo',
                            amount: 10.0,
                            description: 'Testing payment',
                          ),
                        );
                        // TODO: add your success logic here
                        print(response);
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
                                    Text(
                                        'Transaction Id : ${response?.transactionId}'),
                                    Text(
                                        'Transaction Ref Id: ${response?.transactionRefId}'),
                                    Text(
                                        'Transaction Amount: ${response?.amount}'),
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
                      } on EasyUpiPaymentException catch (error) {
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
                                    Text('Error : ${error.toString()}'),
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
                      }
                    },
                    icon: Icon(Icons.currency_rupee),
                    label: Text('Pay using UPI')),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      var options = {
                        'key': RAZORPAY_KEY,
                        'amount': MAINTENANCE_AMMOUNT * 100,
                        'name': 'Maintenance 302 JAN 2024',
                        'description': 'Maintenance 302 JAN 2024',
                        'prefill': {
                          'name': 'Vikram Sangat',
                          'contact': '9503415652',
                          'email': 'v.sangat98@gmail.com'
                        },
                        "theme": {"color": "#94d785"}
                      };
                      _razorpay.open(options);
                    },
                    icon: Icon(Icons.currency_rupee),
                    label: Text('Pay using razerpay')),
                SizedBox(
                  height: 16,
                ),
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

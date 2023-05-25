import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:Hitchcake/data/provider/user_provider.dart';
import 'package:Hitchcake/ui/widgets/app_image_with_text.dart';
import 'package:Hitchcake/ui/widgets/custom_modal_progress_hud.dart';
import 'package:Hitchcake/ui/widgets/rounded_button.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:http/http.dart' as http;

class Premium extends StatefulWidget {
  static const String id = 'premium';

  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _inputEmail = '';
  String _inputPassword = '';
  bool _isLoading = false;
  bool choosen1 = false;
  bool choosen2 = true;
  bool choosen3 = false;

  String price = '7.49';
  late UserProvider _userProvider;

  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: CustomModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.clear,
                            size: 30,
                            color: Color.fromARGB(255, 40, 21, 29),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(child: AppIconTitle()),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Hitchcake Premium',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 30),
                  ),
                  Text(
                    'Upgrade to Find Your Perfect Match',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    color: const Color.fromARGB(255, 236, 234, 234),
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                choosen1 = true;
                                choosen2 = false;
                                choosen3 = false;
                                price = '4.99';
                              });
                            },
                            child: Container(
                              height: 159,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: choosen1
                                    ? Colors.white
                                    : Colors.transparent,
                                border: Border.all(
                                  color: choosen1
                                      ? const Color.fromARGB(255, 246, 103, 162)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: const Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Text(
                                        '12',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            color: Color.fromARGB(
                                                255, 135, 134, 132)),
                                      ),
                                      Text(
                                        'months',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromARGB(
                                                255, 135, 134, 132)),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        '4\.99/mo',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Color.fromARGB(
                                                255, 135, 134, 132)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                choosen2 = true;
                                choosen1 = false;
                                choosen3 = false;
                                price = '7.49';
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: choosen2
                                    ? Colors.white
                                    : Colors.transparent,
                                border: Border.all(
                                  color: choosen2
                                      ? const Color.fromARGB(255, 246, 103, 162)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Transform.translate(
                                        offset: const Offset(0, -35),
                                        child: choosen2
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: const Color.fromARGB(
                                                        255, 224, 83, 142)),
                                                child: const Text(
                                                  'Save 50%',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                ),
                                              )
                                            : const Text(''),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(0, -14),
                                        child: const Column(
                                          children: [
                                            Text(
                                              '6',
                                              style: TextStyle(
                                                  fontSize: 24.0,
                                                  color: Color.fromARGB(
                                                      255, 135, 134, 132)),
                                            ),
                                            Text(
                                              'months',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Color.fromARGB(
                                                      255, 135, 134, 132)),
                                            ),
                                            SizedBox(height: 10.0),
                                            Text(
                                              '7\.49/mo',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Color.fromARGB(
                                                      255, 135, 134, 132)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                choosen3 = true;
                                choosen2 = false;
                                choosen1 = false;
                                price = '14.99';
                              });
                            },
                            child: Container(
                              height: 159,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: choosen3
                                    ? Colors.white
                                    : Colors.transparent,
                                border: Border.all(
                                  color: choosen3
                                      ? const Color.fromARGB(255, 246, 103, 162)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: const Card(
                                elevation: 0,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Text(
                                        '1',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            color: Color.fromARGB(
                                                255, 135, 134, 132)),
                                      ),
                                      Text(
                                        'month',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromARGB(
                                                255, 135, 134, 132)),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        '14\.99/mo',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Color.fromARGB(
                                                255, 135, 134, 132)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RoundedButton(
                        text: 'CONTINUE',
                        color: Colors.white,
                        onPressed: () async {
                          createPremiumCollection();
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createPremiumCollection() async {
    // get the current user
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    // calculate expiry date
    DateTime now = DateTime.now();
    DateTime expiryDate = new DateTime(now.year, now.month + 6, now.day);

    // create document with user id as document id
    await FirebaseFirestore.instance.collection('premium').doc(user!.uid).set({
      'expiry-date': expiryDate,
    }).then((value) => debugPrint('done'));
  }

  Future<void> makePayment() async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntentData = await createPaymentIntent('100', 'USD');
      debugPrint('Payment intent data ${paymentIntentData}');

      //STEP 2: Initialize Payment Sheet
      await stripe.Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: stripe.SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntentData![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Hitchcake'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(price),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance.presentPaymentSheet().then((value) {
        //Clear paymentIntent variable after successful payment
        createPremiumCollection();
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on stripe.StripeException catch (e) {
      print('Error is:---> $e');
    } catch (e) {
      print('$e');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (double.parse(amount)) * 100;
    final centsAmount = calculatedAmout.toInt();
    return centsAmount.toString();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Hitchcake/data/provider/user_provider.dart';
import 'package:Hitchcake/firebase_options.dart';
import 'package:Hitchcake/ui/premium.dart';
import 'package:Hitchcake/ui/screens/chat_screen.dart';
import 'package:Hitchcake/ui/screens/login_screen.dart';
import 'package:Hitchcake/ui/screens/matched_screen.dart';
import 'package:Hitchcake/ui/screens/register_screen.dart';
import 'package:Hitchcake/ui/screens/splash_screen.dart';
import 'package:Hitchcake/ui/screens/start_screen.dart';
import 'package:Hitchcake/ui/screens/top_navigation_screen.dart';
import 'package:Hitchcake/util/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_live_51NAJzeHp5Scoa9fFKLu6JrvZ59quJu06mOcLGfArNYGCiX7UmKPAKMnmqJBY9C8rhH593CWOTGb7ssuppTypnSMH00OGJtRdcA';
  await Stripe.instance.applySettings();
  await dotenv.load(fileName: "images/.env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void checkExpiryDate() async {
    // get the current user
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    // query the document and get the expiry date
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('premium')
        .doc(user!.uid)
        .get();
    Timestamp expiryTimestamp = doc.get('expiry-date');
    DateTime expiryDate = expiryTimestamp.toDate();

    // check if today's date is the same as the expiry date
    DateTime now = DateTime.now();
    bool expired = expiryDate.year == now.year &&
        expiryDate.month == now.month &&
        expiryDate.day == now.day;

    if (expired) {
      await FirebaseFirestore.instance
          .collection('premium')
          .doc(user!.uid)
          .delete();
      print("Your subscription has expired.");
    } else {
      print("Your subscription is still active.");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.black));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: kFontFamily,
          indicatorColor: kAccentColor,
          primarySwatch:
              MaterialColor(kBackgroundColorInt, kThemeMaterialColor),
          scaffoldBackgroundColor: kPrimaryColor,
          hintColor: kSecondaryColor,
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            headline3: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold),
            headline4: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            button: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ).apply(
            bodyColor: kSecondaryColor,
            displayColor: kSecondaryColor,
          ),
          buttonTheme: ButtonThemeData(
            splashColor: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 14),
            buttonColor: kAccentColor,
            textTheme: ButtonTextTheme.accent,
            highlightColor: Color.fromRGBO(0, 0, 0, .3),
            focusColor: Color.fromRGBO(0, 0, 0, .3),
          ),
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          StartScreen.id: (context) => StartScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          Premium.id: (context) => Premium(),
          RegisterScreen.id: (context) => RegisterScreen(),
          TopNavigationScreen.id: (context) => TopNavigationScreen(),
          MatchedScreen.id: (context) => MatchedScreen(
                myProfilePhotoPath: (ModalRoute.of(context)?.settings.arguments
                    as Map?)?['my_profile_photo_path'],
                myUserId: (ModalRoute.of(context)?.settings.arguments
                        as Map?)?['my_user_id'] ??
                    '',
                otherUserProfilePhotoPath: (ModalRoute.of(context)!
                    .settings
                    .arguments as Map)?['other_user_profile_photo_path'],
                otherUserId: (ModalRoute.of(context)!.settings.arguments
                        as Map)?['other_user_id'] ??
                    '',
              ),
          ChatScreen.id: (context) => ChatScreen(
                chatId: (ModalRoute.of(context)!.settings.arguments
                    as Map)['chat_id'],
                otherUserId: (ModalRoute.of(context)!.settings.arguments
                    as Map)['other_user_id'],
                myUserId: (ModalRoute.of(context)!.settings.arguments
                    as Map)['user_id'],
              ),
        },
      ),
    );
  }
}

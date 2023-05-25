import 'package:flutter/material.dart';
import 'package:Hitchcake/util/constants.dart';
import 'package:Hitchcake/ui/widgets/app_image_with_text.dart';
import 'package:Hitchcake/ui/widgets/rounded_button.dart';
import 'package:Hitchcake/ui/widgets/rounded_outlined_button.dart';
import 'package:Hitchcake/ui/screens/login_screen.dart';
import 'package:Hitchcake/ui/screens/register_screen.dart';

class StartScreen extends StatelessWidget {
  static const String id = 'start_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: kDefaultPadding,
          child: Container(
            margin: EdgeInsets.only(bottom: 40, top: 120),
            child: Column(
              children: [
                AppIconTitle(),
                Expanded(child: Container()),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'Hitchcake - Connect with dessert lovers on Hitchcake - the dating app where love and desserts meet! Happy matching!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                SizedBox(height: 60),
                RoundedButton(
                    text: 'CREATE ACCOUNT',
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, RegisterScreen.id);
                    }),
                SizedBox(height: 20),
                RoundedOutlinedButton(
                  text: 'LOGIN',
                  onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

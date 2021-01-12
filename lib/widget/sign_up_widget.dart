import 'package:email_signin_example/page/auth_page.dart';
import 'package:flutter/material.dart';


class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/newbg.jpg"),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
                begin: Alignment(0.03, 1.15),
                end: Alignment(0.03, -1.06),
                colors: [
                  const Color(0xff000000),
                  const Color(0xff080808),
                  const Color(0x692d2d2d)
                ],
                stops: [0.0, 0.176, 1.0],
              ),
        ),
        child: buildSignUp(context),
      ),
      
     
    );
  }

  Widget buildSignUp(BuildContext context) => Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
          
          ),
          Spacer(),
          SizedBox(height: 12),
          OutlineButton(
            child: Text('Sign In with Email & Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: StadiumBorder(),
            highlightedBorderColor: Colors.black,
            borderSide: BorderSide(color: Colors.black),
            textColor: Colors.white,
            color: Colors.black,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AuthPage()),
            ),
            
          ),
          SizedBox(height: 12),
          // GoogleSignupButtonWidget(),
          // fbSignupButtonWidget(),
          Spacer()
        ],
      );
}

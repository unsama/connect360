import 'package:email_signin_example/provider/email_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
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
        child: buildAuthForm()
      ),
    );
  }

  Widget buildAuthForm() {
    final provider = Provider.of<EmailSignInProvider>(context);

    return Center(
      child: Card(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 220),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  buildEmailField(),
                  if (!provider.isLogin) buildUsernameField(),
                  buildPasswordField(),
                  SizedBox(height: 12),
                  buildButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUsernameField() {
    final provider = Provider.of<EmailSignInProvider>(context);

    return TextFormField(
      key: ValueKey('username'),
      autocorrect: true,
      textCapitalization: TextCapitalization.words,
      enableSuggestions: false,
      validator: (value) {
        if (value.isEmpty || value.length < 4 || value.contains(' ')) {
          return 'Please enter at least 4 characters without space';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(labelText: 'Username'),
      onSaved: (username) => provider.userName = username,
    );
  }

  Widget buildButton(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);

    if (provider.isLoading) {
      return CircularProgressIndicator();
    } else {
      return Column(
        children: [
          buildLoginButton(),
          buildSignupButton(context),
        ],
      );
    }
  }

  Widget buildLoginButton() {
    final provider = Provider.of<EmailSignInProvider>(context);

    return OutlineButton(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      highlightedBorderColor: Colors.black,
      borderSide: BorderSide(color: Colors.black),
      textColor: Colors.black,
      child: Text(provider.isLogin ? 'Login' : 'Signup'),
      onPressed: () => submit(),
    );
  }

  Widget buildSignupButton(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);

    return FlatButton(
      textColor: Colors.black,
      child: Text(
        provider.isLogin ? 'Need an account? Register' : 'I already have an account',
      ),
      onPressed: () => provider.isLogin = !provider.isLogin,
    );
  }

  Widget buildEmailField() {
    final provider = Provider.of<EmailSignInProvider>(context);

    return TextFormField(
      key: ValueKey('email'),
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      enableSuggestions: false,
      validator: (value) {
        final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
        final regExp = RegExp(pattern);

        if (!regExp.hasMatch(value)) {
          return 'Enter a valid mail';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'Email address'),
      onSaved: (email) => provider.userEmail = email,
    );
  }

  Widget buildPasswordField() {
    final provider = Provider.of<EmailSignInProvider>(context);

    return TextFormField(
      key: ValueKey('password'),
      validator: (value) {
        if (value.isEmpty || value.length < 7) {
          return 'Password must be at least 7 characters long.';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      onSaved: (password) => provider.userPassword = password,
    );
  }

  Future submit() async {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();

      final isSuccess = await provider.login();

      if (isSuccess) {
        Navigator.of(context).pop();
      } else {
        final message = 'An error occurred, please check your credentials!';

        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    }
  }
}

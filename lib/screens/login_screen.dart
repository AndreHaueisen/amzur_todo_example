import 'package:amzur_todo_example/constants.dart';
import 'package:amzur_todo_example/main.dart';
import 'package:amzur_todo_example/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: _buildScreenLeading(),
        title: Text(
          "Back",
          style: TextStyle(
            color: textColorPrimary,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Login',
                style: TextStyle(
                    color: textColorPrimaryDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: _buildFormFields(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8),
              child: _buildLoginOptionsSection(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: _buildLoginButton(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: _buildSeparator(),
            ),
            _buildSocialLoginButtons(),
            Padding(
              padding:
                  const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 24),
              child: _buildDontHaveAccount(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenLeading() {
    return GestureDetector(
        onTap: () {
          // There is nowhere at the moment
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(Icons.keyboard_backspace, color: primaryColor,),
        ),);
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _autoValidate = false;
  bool _obscureText = false;

  Widget _buildFormFields() {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            validator: _emailValidator,
            textInputAction: TextInputAction.done,
            cursorColor: accentColor,
            decoration: InputDecoration(
                labelText: "Email", border: UnderlineInputBorder(),),
          ),
          TextFormField(
            controller: _passwordController,
            validator: _passwordValidator,
            textInputAction: TextInputAction.done,
            obscureText: _obscureText,
            cursorColor: accentColor,
            decoration: InputDecoration(
              labelText: "Password",
              border: UnderlineInputBorder(),
              suffix: GestureDetector(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  child: _obscureText
                      ? Icon(
                          Icons.visibility_off,
                          color: primaryColor,
                        )
                      : Icon(
                          Icons.visibility,
                          color: primaryColor,
                        ),
                ),
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _rememberMe = true;

  Widget _buildLoginOptionsSection() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Checkbox(
          value: _rememberMe,
          activeColor: primaryColor.withOpacity(0.75),
          onChanged: (rememberMe) {
            setState(
              () {
                _rememberMe = rememberMe;
              },
            );
          },
        ),
        Text(
          "Remember me",
          style: TextStyle(color: textColorPrimary),
        ),
        Spacer(),
        GestureDetector(
            child: Text(
              "Forgot password?",
              style: TextStyle(
                color: textColorPrimary,
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () {
              // DEAL WITH FORGOTTEN PASSWORD
            })
      ],
    );
  }

  Widget _buildLoginButton() {
    return RaisedButton(
      elevation: 8,
      onPressed: () {
        if (_formKey.currentState.validate()){
          Navigator.of(context).pushNamed(Constants.ROUTE_TODO);
        } else {
          setState(() {
            _autoValidate = true;
          });
        }
      },
      color: accentColor,
      textColor: Colors.white,
      child: Text("Login"),
    );
  }

  Widget _buildSeparator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("or"),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialLoginButton(
          title: "Facebook",
          iconData: FontAwesomeIcons.facebookSquare,
          onPressed: () {
            // TODO handle facebook login
          },
        ),
        Container(
          width: 24,
        ),
        SocialLoginButton(
          title: "Google",
          iconData: FontAwesomeIcons.google,
          onPressed: () {
            // TODO handle google login
          },
        ),
      ],
    );
  }

  Widget _buildDontHaveAccount() {
    return GestureDetector(
      onTap: () {},
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Don't have an account?",
          style: TextStyle(color: textColorPrimary),
          children: [
            TextSpan(
              text: " Register now",
              style: TextStyle(color: accentColor, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  String _emailValidator(String text) {
    if (!text.contains('@')) {
      return "Invalid email";
    }

    return null;
  }

  String _passwordValidator(String text) {
    if (text.length < 6) {
      return "6 character password";
    }

    return null;
  }
}

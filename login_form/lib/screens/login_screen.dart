import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_form/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  Widget _buildEmailTF() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("Email", style: kLabelStyle),
          const SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: const TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    hintText: "Enter your email",
                    hintStyle: kHintTextStyle),
              ))
        ]);
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("Password", style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: const TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  hintText: "Enter your password",
                  hintStyle: kHintTextStyle),
            ))
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => print("Forgot password button pressed"),
          style:
              TextButton.styleFrom(padding: const EdgeInsets.only(right: 0.0)),
          child: const Text("Forgot Password?", style: kLabelStyle),
        ));
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
        alignment: Alignment.centerLeft,
        height: 20.0,
        child: Row(
          children: <Widget>[
            Theme(
                data: ThemeData(unselectedWidgetColor: Colors.white),
                child: Checkbox(
                  value: _rememberMe,
                  checkColor: Colors.green,
                  activeColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  },
                )),
            const Text("Remember me", style: kLabelStyle)
          ],
        ));
  }

  Widget _buildLoginBtn() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () => print("Login button pressed"),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.all(15.0),
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                elevation: 5.0),
            child: const Text("LOGIN",
                style: TextStyle(
                    color: Color(0xff527daa),
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans'))));
  }

  Widget _buildSignInWithText() {
    return const Column(children: <Widget>[
      Text("- OR -",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
      SizedBox(height: 20.0),
      Text("Sign in with", style: kLabelStyle)
    ]);
  }

  Widget _buildSocialBtn(VoidCallback onTap, AssetImage logo) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.9)
              ],
              image: DecorationImage(image: logo)),
        ));
  }

  Widget _buildSocialBtnRow() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildSocialBtn(() => print("Login with Facebook"),
                  const AssetImage('assets/logos/facebook.jpg')),
              _buildSocialBtn(() => print("Login with Google"),
                  const AssetImage('assets/logos/google.jpg'))
            ]));
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
        onTap: () => print("Sign Up button pressed"),
        child: RichText(
            text: const TextSpan(children: [
          TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400)),
          TextSpan(
              text: "Sign Up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color(0xff73aef5),
                          Color(0xff61a4f1),
                          Color(0xff478de0),
                          Color(0xff398ae5)
                        ],
                            stops: [
                          0.1,
                          0.4,
                          0.7,
                          0.9
                        ])),
                  ),
                  Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 120.0,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text("Sign In",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 30.0),
                                _buildEmailTF(),
                                const SizedBox(height: 30.0),
                                _buildPasswordTF(),
                                _buildForgotPasswordBtn(),
                                _buildRememberMeCheckbox(),
                                _buildLoginBtn(),
                                _buildSignInWithText(),
                                _buildSocialBtnRow(),
                                _buildSignupBtn()
                              ])))
                ]))));
  }
}

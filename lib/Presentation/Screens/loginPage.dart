import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants/strings.dart';
import '../../Data/repository/firebase_auth_srevices.dart';
import '../../Data/repository/user_repo.dart';
import '../Widgets/bezierContainer.dart';
import '../Widgets/warning.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.title});

  final String? title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthServices auth = FirebaseAuthServices();

  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xff6e4302)),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              cursorColor: Colors.orange,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: !isPassword
                  ? (value) {
                      if (!_emailRegex.hasMatch(value!)) {
                        return 'Email address is not valid';
                      }
                    }
                  : (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your Password';
                      }
                    },
              controller: controller,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: _emailController.text.isEmpty || _passwordController.text.isEmpty
          ? null
          : _signIn,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return InkWell(
      onTap: _signInWithGoogle,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: const Text('G',
                    style: TextStyle(
                        color: Color(0xffa96800),
                        fontSize: 30,
                        fontFamily: 'DriverStationDemoBold',
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffe7e7e7),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: const Text('Log in with Google',
                    style: TextStyle(
                        color: Color(0xffe08800),
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, signUp);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff6e4302)),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'A',
          style: TextStyle(
              color: Color(0xfffa9a04),
              fontSize: 35,
              fontFamily: 'BabyShowerTime'),
          children: [
            TextSpan(
              text: 'F',
              style: TextStyle(color: Color(0xfffa9a04), fontSize: 35),
            ),
            TextSpan(
              text: ' ',
              style: TextStyle(color: Color(0xff9f6201), fontSize: 15),
            ),
            TextSpan(
              text: 'Watches',
              style: TextStyle(
                color: Color(0xffD48203),
                fontSize: 30,
                fontFamily: 'DriverStationDemoBold',
              ),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email", _emailController),
        _entryField("Password", _passwordController, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  const SizedBox(height: 50),
                  _emailPasswordWidget(),
                  const SizedBox(height: 20),
                  _submitButton(),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: _resetPassword,
                      child: const Text('Forgot Password ?',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff6e4302))),
                    ),
                  ),
                  _divider(),
                  _facebookButton(),
                  //SizedBox(height: height * .005),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    User? user = await auth.SignIn(email, password);
    if (user != null) {
      print("Success");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', email.split('@').first);
      print("done");
      Navigator.pushReplacementNamed(context, homeScreen);
    } else {
      WarningPopup.showWarningDialog(context, false,
          'The Email address or Password is incorrect. Please retry...!');
    }
  }

  void _signInWithGoogle() async {
    await auth.signInWithGoogle();
    if (FirebaseAuth.instance.currentUser == null) {
      print('errorr');
    } else {
      String? userName =
          FirebaseAuth.instance.currentUser!.displayName!.split(' ').first;
      String? email=FirebaseAuth.instance.currentUser!.email;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', userName);
      UserRepo userRepo= UserRepo();
      userRepo.setUserData(userName, email!);
    }
    Navigator.pushReplacementNamed(context, homeScreen);
  }
  void _resetPassword() async {
    String email = _emailController.text;
    await auth.ForgetPassword(email);
    print('done');
    //Navigator.pushReplacementNamed(context, homeScreen);
  }
}

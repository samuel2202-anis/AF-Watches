import 'package:af_watches2/Data/repository/firebase_auth_srevices.dart';
import 'package:af_watches2/Data/repository/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants/strings.dart';
import '../Widgets/bezierContainer.dart';
import '../Widgets/warning.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, this.title});
  final String? title;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuthServices auth= FirebaseAuthServices();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }


  Widget _entryField(String title, TextEditingController controller,{bool isPassword = false,bool isEmail=false}) {
    return Container(
      margin:const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color:Color(0xff6e4302) ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              cursorColor: Colors.orange,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator:isEmail? (value){if (!_emailRegex.hasMatch(value!)) {
                return 'Email address is not valid';
              }
              }:(value){if (value!.isEmpty) {
                return 'Please Complete your data';
              }},
            controller: controller,
              obscureText: isPassword,
              decoration:const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: _emailController.text.isEmpty||_passwordController.text.isEmpty||_usernameController.text.isEmpty? null:_SignUp,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding:const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset:const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child:const Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(
            context,loginPage);
      },
      child: Container(
        margin:const EdgeInsets.symmetric(vertical: 20),
        padding:  const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child:const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color:Color(0xff6e4302)),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
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
      text:const TextSpan(
          text: 'A',
          style:TextStyle(color:   Color(0xfffa9a04), fontSize: 35,fontFamily: 'BabyShowerTime'),
          children: [
            TextSpan(
              text: 'F',
              style: TextStyle(color:   Color(0xfffa9a04), fontSize: 35),
            ),
            TextSpan(
              text: ' ',
              style: TextStyle(color:  Color(0xff9f6201), fontSize: 15),
            ),
            TextSpan(
              text: 'Watches',
              style: TextStyle(color:   Color(0xffD48203), fontSize: 30,fontFamily: 'DriverStationDemoBold',),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("User name",_usernameController),
        _entryField("Email ",_emailController,isEmail: true),
        _entryField("Password",_passwordController, isPassword: true),
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
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    const SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    _submitButton(),

                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _SignUp() async{
    String username=_usernameController.text;
    String email=_emailController.text;
    String password =_passwordController.text;
    UserRepo userRepo= UserRepo();
    User? user =await auth.SignUp(email, password);
    if(user != null){
      print("Success");
      userRepo.setUserData(username, email);
      print("done");
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setString('name', username);
      var test=prefs.getString('name');
      print(test);
      Navigator.pushReplacementNamed(context, homeScreen);
    }else{
      WarningPopup.showWarningDialog(context, false, 'Please check your internet connection and try again later ..!');
    }
    }


}
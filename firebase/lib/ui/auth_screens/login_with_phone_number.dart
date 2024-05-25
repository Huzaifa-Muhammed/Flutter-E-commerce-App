import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});
  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {

  late double _screenWidth;
  final _phoneNumber=TextEditingController();
  FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    _screenWidth=MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                _title(),
                _phoneNumberFeild(),
                _Button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(){
    return Text('Firebase Login App',style: GoogleFonts.playfairDisplay(fontSize:_screenWidth*0.1),);
  }

  Widget _phoneNumberFeild(){
    return TextFormField(
      controller: _phoneNumber,
      decoration: InputDecoration(hintText: "3188858855",hintStyle: GoogleFonts.aBeeZee(fontWeight: FontWeight.w100,color: Colors.black26),prefixIcon: Icon(Icons.phone_android_sharp,color: Colors.redAccent,)),
      onSaved: (value){
      },
    );
  }


  Widget _Button(){
    return MaterialButton(
      onPressed: () {  },
      color: Colors.redAccent,
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
      child: const Text("LogIn",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 4),),
    );
  }

}

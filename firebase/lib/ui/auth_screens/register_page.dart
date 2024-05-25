import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import '../home_screen.dart';
import 'login_screen.dart';

class RegisterPage extends StatefulWidget {

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  FirebaseAuth _auth=FirebaseAuth.instance;

  late double _screenWidth;
  late double _screenHeight;

  final GlobalKey<FormState> _registerFormKey=GlobalKey<FormState>();

  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _screenHeight=MediaQuery.of(context).size.height;
    _screenWidth=MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container
          (
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                _titleWidget(),
                _regestrationForm(),
                _registerButton(),
                _haveAccontText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget(){
    return Text('Firebase Login App',style: GoogleFonts.playfairDisplay(fontSize:_screenWidth*0.1),);
  }

  Widget _haveAccontText(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      },
      child: const Text("already have an account? login",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w300)),
    );
  }

  Widget _registerButton(){
    return MaterialButton(
      onPressed: (){
        _auth.createUserWithEmailAndPassword(email: _emailController.text.toString(), password: _passwordController.text.toString()).then((value){
          Navigator.pushAndRemoveUntil(context, PageTransition(child: HomeScreen(), type: PageTransitionType.leftToRightWithFade,alignment: Alignment.center,duration: const Duration(milliseconds: 1000)), (Route<dynamic> route) => false,);
        }).catchError((error){
          showDialog(context: context, builder: (context) => _notSignedinDialouge(error.toString()),);
        });
      },
      color: Colors.blueAccent,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: const Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 4,),),
    );
  }

  Widget _notSignedinDialouge(String error){
    return AlertDialog(
      title:Text(error,style: GoogleFonts.playfairDisplay(fontSize: 20),),
      content:Image.asset('lib/assets/images/cancel.png',width: 100,height: 100,),
      backgroundColor: Colors.white,
      shadowColor:Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
    );
  }

  Widget _regestrationForm(){
    return SizedBox(
      height: _screenHeight*0.27,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _emailTextFeild(),
            _passwordTextFeild(),
          ],
        ),
      ),
    );
  }

  Widget _emailTextFeild(){
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: "Email...",prefixIcon: Icon(Icons.email_outlined,color: Colors.blueAccent,)),
    );
  }

  Widget _passwordTextFeild(){
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(hintText: "Password...",prefixIcon: Icon(Icons.key,color: Colors.blueAccent,)),
    );
  }
}

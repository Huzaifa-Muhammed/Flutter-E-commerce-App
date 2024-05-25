import 'package:email_validator/email_validator.dart';
import 'package:firebase/ui/auth_screens/register_page.dart';
import 'package:firebase/ui/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../../utils/image_paths.dart';
import 'login_with_phone_number.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  late double _screenWidth ,_screenHeight;

  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();

  final GlobalKey<FormState> _loginFormKey= GlobalKey<FormState>();

  String? email;
  String? password;
  bool _isObscure=true;

  Images images=Images();
  
  FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    _emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    _screenHeight=MediaQuery.of(context).size.height;
    _screenWidth=MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20,left: 30,right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                _titleWidget(),
                _loginForm(),
                _loginButton(),
                _registerPageLink(),
                _loginWithPhoneLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _titleWidget(){
    return Image(
      width: 300,
      height: 250,
      image: AssetImage(images.loginPageImage),
      fit: BoxFit.fitWidth,
    );
  }

  Widget _loginForm(){
    return SizedBox(
      height: _screenHeight*0.20,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField(){
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(hintText: "Email...",hintStyle: GoogleFonts.aBeeZee(color: const Color.fromRGBO(105, 105, 105, 0.4)),prefixIcon: Icon(Icons.email_outlined,color: Colors.blueAccent,)),
      onSaved: (value){
        setState(() {
          email=value;
        });
      },
      validator: (value){
        bool result=EmailValidator.validate(value!);
        return result ? null : "Please enter valid Email";
      },
    );
  }

  Widget _passwordTextField(){
    return TextFormField(
      controller: _passwordController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: "Password...",
        hintStyle:  GoogleFonts.aBeeZee(color: const Color.fromRGBO(105, 105, 105, 0.4)),
        prefixIcon: const Icon(Icons.key_outlined,color: Colors.blueAccent,),
        suffixIcon: GestureDetector(
          onTap: (){
            setState(() {
              _isObscure=!_isObscure;
            });
          },
          child: Icon(_isObscure?Icons.visibility_off_outlined:Icons.visibility_outlined),
        ),
      ),
      onSaved: (value){
        setState(() {
          password=value;
        });
      },
      validator: (value)=>
      value!.length>6 ? null:"Please Enter the correct password",
    );
  }

  void _loginValidator(){
    if(_loginFormKey.currentState!.validate()){
      _loginFormKey.currentState!.save();
    }
  }

  Widget _loginButton(){
    return MaterialButton(
      onPressed: (){
        _loginValidator();
        _auth.signInWithEmailAndPassword(
          email: _emailController.text.toString(),
          password: _passwordController.text.toString(),
        ).then(
              (value) => Navigator.pushAndRemoveUntil(context, PageTransition(child: HomeScreen(), type: PageTransitionType.leftToRightWithFade,alignment: Alignment.center,duration: const Duration(milliseconds: 1000),), (Route<dynamic> route) => false,),
        ).onError(
              (error, stackTrace) => showDialog(
            context: context,
            builder: (context) => _notSignedinDialouge(),
          ),
        );
      },
      color: Colors.blueAccent,
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
      child: Text("LogIn",style: GoogleFonts.aBeeZee(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 4),),
    );
  }

  Widget _registerPageLink(){
    return GestureDetector(
        onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterPage()) ),
        child: Text("Don't have an account?  register",style: GoogleFonts.aBeeZee(color: Colors.blueAccent,fontWeight: FontWeight.w300),)
    );
  }

  Widget _loginWithPhoneLink(){
    return GestureDetector(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPhoneNumber())),
      child: Text('Login with mobile number',style: GoogleFonts.aBeeZee(color: Colors.blueAccent,fontWeight: FontWeight.w300,)),
    );
  }

  
  Widget _notSignedinDialouge(){
    return AlertDialog(
      title:Text("Username or password is wrong",style: GoogleFonts.aBeeZee(fontSize: 20),),
      content:Image.asset('lib/assets/images/cancel.png',width: 100,height: 100,),
      backgroundColor: Colors.white,
      shadowColor:Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
    );
  }
}

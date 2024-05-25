import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/image_paths.dart';

class UpdateUserInfo extends StatelessWidget {

  Images images = Images();

  late double _screenHeight;
  late double _screenWidth;

  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.lightBlue.shade400,),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 150, width: _screenWidth, color: Colors.lightBlue)),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 2, bottom: 2),
                            child: Text(
                              'change picture',
                              style: GoogleFonts.acme(
                                  color: Colors.black, letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                      _textFormField('Username', controller: usernameController),
                      _textFormField('Email', postFixText: '@gmail.com', controller: emailController),
                      _textFormField('Phone', controller: phoneController),
                      _textFormField('Password', controller: passwordController),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 90, right: 90),
                            child: Text(
                              'Update',
                              style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 120, top: 100),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 10),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(images.profileImage),
                      fit: BoxFit.fill)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFormField(String labelText,
      {String? preFixText,
        String? postFixText,
        TextEditingController? controller}) {
    return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  prefixText: preFixText,
                  suffixText: postFixText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ));
  }
}

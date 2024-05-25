import 'package:firebase/ui/auth_screens/update_user_info.dart';
import 'package:firebase/ui/bottom_nav_pages/cart_page.dart';
import 'package:firebase/ui/bottom_nav_pages/favorite_page.dart';
import 'package:firebase/utils/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late double _screenWidth;

  Images images = Images();

  @override
  Widget build(BuildContext context) {

    _screenWidth=MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(flex: 1,child: Container(height: 150,width: _screenWidth,color: Colors.lightBlue)),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),backgroundColor: Colors.black,elevation: 10),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateUserInfo()));},child: Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 2,bottom: 2),
                          child: Text('Edit Profile',style: GoogleFonts.acme(color: Colors.white,letterSpacing: 2),),
                        )),
                      ),
                      headingRow('Mini Headlines'),
                      navigationRow('Worker Mode'),
                      navigationRow('Seller Mode'),
                      headingRow('Content'),
                      navigationRow('Favourite', icon: const Icon(Icons.favorite_border),onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoritePage(showAppBar: true,)));},),
                      navigationRow('Cart', icon: const Icon(Icons.shopping_cart_outlined),onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage(showAppBar: true,)));},),
                      headingRow('Preferences'),
                      navigationRow('Languages', icon: const Icon(Icons.translate)),
                      navigationRow('Dark Mode', icon: const Icon(Icons.dark_mode_outlined)),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120,top: 60),
              child: Container(width: 150,height: 150,decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 10),shape: BoxShape.circle,image: DecorationImage(image: AssetImage(images.profileImage),fit: BoxFit.fill)),),
            ),
          ],
        )
    );
  }

  Widget headingRow(String text){
    return Container(
      width: _screenWidth,
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
        child: Text(text,style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),),
      ),
    );
  }

  Widget navigationRow(String text, {Icon? icon, VoidCallback? onTap,})
  {
    return GestureDetector(
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (icon != null) icon,
                Padding(padding: icon != null ? const EdgeInsets.only(left: 15) : EdgeInsets.zero, child: Text(text, style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w600),),),
              ],
            ),
            const Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}
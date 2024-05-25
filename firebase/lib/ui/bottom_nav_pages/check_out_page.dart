import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../assets/widgets/checkout_container.dart';

class CheckOutPage extends StatefulWidget {
  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text('Checkout', style: GoogleFonts.acme(fontSize: 30, letterSpacing: 3)),
      ),),
      body: Column(
        children: [
          CheckOutContainer(
            title: "Shipping Information",
            heading: "Name",
            subHeading: "Chak 497/EB ,Burewala,Vehari",
            showShippingInfo: true,
          ),
          CheckOutContainer(
            boxHeight: 155,
            title: "courier service",
            heading: "DHL Express",
            subHeading: "Will be delivered in 3 days",
            showShippingInfo: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Payment Methode", style: GoogleFonts.aBeeZee(fontSize: 10)),
                Text("Add new card", style: GoogleFonts.aBeeZee(fontSize: 10, color: Colors.blueAccent)),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            width: 400,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset('lib/assets/images/card.png',fit: BoxFit.fitWidth,);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 50),
                shape: RoundedRectangleBorder()
              ),
              onPressed: (){},
              child: const Text("Check Out"),
            ),
          ),
        ],
      ),
    );
  }

}

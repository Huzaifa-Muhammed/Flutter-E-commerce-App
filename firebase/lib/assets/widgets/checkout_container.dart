import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutContainer extends StatelessWidget {

  double boxHeight;
  double boxWidth;
  final String title;
  final String heading;
  final String subHeading;
  final bool showShippingInfo;

  CheckOutContainer({
    this.boxHeight=200,
    this.boxWidth=400,
    required this.title,
    required this.heading,
    required this.subHeading,
    required this.showShippingInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        width: boxWidth,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(showShippingInfo)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,style: GoogleFonts.aBeeZee(fontSize: 12),),
                      const Icon(Icons.edit),
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(title,style: GoogleFonts.aBeeZee(fontSize: 12),),
                ),
              Text(heading,style: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.bold),),
              if(showShippingInfo)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.location_on,color: Colors.grey.shade400,),
                      Expanded(child: Text(subHeading)),
                    ],
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(child: Text(subHeading)),
                      const Icon(Icons.chevron_right,),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
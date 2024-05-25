import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/item_class.dart';

class ItemBox extends StatelessWidget{

  final Item item;
  final bool isForCategory;
  final double boxWidth;
  final double boxHeight;
  final double imageWidth;
  final double imageHeight;
  final BoxFit imageBehaviour;
  final Color backgroundColor;
  final double topMargin;
  final double bottomMargin;
  final double rightMargin;
  final double leftMargin;
  final VoidCallback? onClick;

  ItemBox({
    required this.item,
    required this.isForCategory,
    this.boxWidth=200,
    this.boxHeight=200,
    required this.imageWidth,
    required this.imageHeight,
    this.imageBehaviour=BoxFit.fill,
    required this.backgroundColor,
    this.topMargin=0,
    this.bottomMargin=0,
    this.rightMargin=20,
    this.leftMargin=20,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        width: boxWidth,
        height: boxHeight,
        child: Card(
          elevation: 10,
          margin: EdgeInsets.only(left: leftMargin,right: rightMargin,top: topMargin,bottom: bottomMargin),
          color: backgroundColor,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: NetworkImage(item.image),fit: imageBehaviour,width: imageWidth,height: imageHeight,),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(item.title,style: GoogleFonts.aBeeZee(),),
                    ),
                    if (!isForCategory)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: List.generate(5, (index) => Icon(size: 15,index < item.rating.toInt() ? Icons.star : Icons.star_outline_sharp, color: index < item.rating.toInt() ? Colors.orange : Colors.grey,),),
                        ),
                      ),
                  ],
                ),
                if (!isForCategory)
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text('${item.price} USD', style: GoogleFonts.aBeeZee(),),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
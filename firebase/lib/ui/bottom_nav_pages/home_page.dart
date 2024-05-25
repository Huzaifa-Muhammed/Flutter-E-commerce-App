import 'package:firebase/data/cart_list.dart';
import 'package:firebase/data/categories_list.dart';
import 'package:firebase/data/trending_items_api_data.dart';
import 'package:firebase/data/trending_items_list.dart';
import 'package:firebase/utils/item_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../../assets/widgets/item_box.dart';
import '../../utils/image_paths.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Images images= Images();

  @override
  void initState() {
    super.initState();
    fetchData(); // Call your asynchronous method
  }

  void fetchData() async {
    ApiData apiData = ApiData();
    await apiData.apiCall();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    List temp=CategoriesListData.categories.toList();

    return Scaffold(
      body: Column(
        children: [
          Container(color: Colors.blueAccent,height: 120,child: Center(child: Text('Shopping app demo Functions',style: GoogleFonts.aBeeZee(color:Colors.white,fontSize: 20,letterSpacing: 2),),),),
          Padding(
            padding: const EdgeInsets.only(right: 270,top: 10,bottom: 10),
            child: Text('Categories',style: GoogleFonts.aBeeZee(color:Colors.blueAccent,letterSpacing: 2,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: CategoriesListData.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      color: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(temp[index],style: GoogleFonts.aBeeZee(color: Colors.white,letterSpacing: 1),)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: Center(child: Text('Top Trending',style: GoogleFonts.aBeeZee(color:Colors.blueAccent,fontWeight: FontWeight.bold,letterSpacing: 3,wordSpacing: 5),)),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: (TrendingItemList.trendingItems.length / 2).ceil(),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    ItemBox(item: TrendingItemList.trendingItems[index * 2], imageWidth: 145, imageHeight: 130,boxHeight: 350,boxWidth: 195, backgroundColor: Colors.white, topMargin: 10, bottomMargin: 10, rightMargin: 10, onClick: () => Navigator.push(context, PageTransition(child: ItemsDetailScreen(item: TrendingItemList.trendingItems[index * 2],onCartButtonTap: (){CartDataList.cartList.add(TrendingItemList.trendingItems[index * 2]);}, itemNameandDescriptionPadding: 10, itemDescriptionandButtonsPadding: 20,), type: PageTransitionType.topToBottom, alignment: Alignment.center, duration: const Duration(milliseconds: 600),),), isForCategory: false,),
                    if (index * 2 + 1 < TrendingItemList.trendingItems.length)
                      ItemBox(item: TrendingItemList.trendingItems[index * 2 + 1], imageWidth: 145, imageHeight: 130,boxHeight: 350,boxWidth: 195 ,backgroundColor: Colors.white, leftMargin: 10, topMargin: 10, bottomMargin: 10, onClick: () => Navigator.push(context, PageTransition(child: ItemsDetailScreen(item: TrendingItemList.trendingItems[index * 2 + 1],onCartButtonTap: (){CartDataList.cartList.add(TrendingItemList.trendingItems[index * 2 + 1]);}, itemNameandDescriptionPadding: 10, itemDescriptionandButtonsPadding: 20,), type: PageTransitionType.topToBottom, alignment: Alignment.center, duration: const Duration(milliseconds: 600),),), isForCategory: false,),
                  ],
                );
              },
            )
          ),
        ],
      ),
    );
  }
}

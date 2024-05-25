import 'package:firebase/assets/widgets/cart_item.dart';
import 'package:firebase/data/favorite_list.dart';
import 'package:firebase/utils/item_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePage extends StatefulWidget {
  final bool showAppBar;
  FavoritePage({this.showAppBar = false});
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar ? AppBar() : null,
      body: Padding(
        padding: widget.showAppBar? const EdgeInsets.only(top: 20,left: 20,right: 20):const EdgeInsets.only(top: 50,left: 20,right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Favorites', style: GoogleFonts.acme(fontSize: 30, letterSpacing: 3)),
                Text(
                  FavoriteDataList.favoriteItems.length > 1 ? '${FavoriteDataList.favoriteItems.length} items' : '${FavoriteDataList.favoriteItems.length} item',
                  style: GoogleFonts.aBeeZee(color: Colors.grey.shade600, letterSpacing: 2),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: FavoriteDataList.favoriteItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemsDetailScreen(
                            item: FavoriteDataList.favoriteItems[index],
                            itemNameandDescriptionPadding: 20,
                            itemDescriptionandButtonsPadding: 20,
                          ),
                        ),
                      );
                    },
                    child: CartItem(
                      item: FavoriteDataList.favoriteItems[index],
                      itemInCart: false,
                      onIncrement: () {},
                      onDecrement: () {},
                      onDismissed: () {
                        setState(() {
                          FavoriteDataList.favoriteItems.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
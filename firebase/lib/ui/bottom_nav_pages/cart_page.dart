import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase/data/cart_list.dart';

import '../../assets/widgets/cart_item.dart';


class CartPage extends StatefulWidget {
  final bool showAppBar;

  CartPage({this.showAppBar = false});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double subTotal = 0;

  @override
  void initState() {
    super.initState();
    _calculateSubTotal();
  }

  void _calculateSubTotal() {
    subTotal = 0;
    for (int i = 0; i < CartDataList.cartList.length; i++) {
      subTotal += double.parse(CartDataList.cartList[i].price) * CartDataList.cartList[i].quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar ? AppBar() : null,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cart', style: GoogleFonts.acme(fontSize: 30, letterSpacing: 3)),
                Text(
                  CartDataList.cartList.length > 1 ? '${CartDataList.cartList.length} items' : '${CartDataList.cartList.length} item',
                  style: GoogleFonts.aBeeZee(color: Colors.grey.shade600, letterSpacing: 2),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: CartDataList.cartList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartItem(
                    item: CartDataList.cartList[index],
                    onIncrement: () {
                      setState(() {
                        CartDataList.cartList[index].quantity++;
                        _calculateSubTotal();
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        if (CartDataList.cartList[index].quantity > 0) {
                          CartDataList.cartList[index].quantity--;
                          _calculateSubTotal();
                          if (CartDataList.cartList[index].quantity <= 0) {
                            CartDataList.cartList.removeAt(index);
                          }
                        }
                      });
                    },
                    onDismissed: () {
                      setState(() {
                        CartDataList.cartList.removeAt(index);
                        _calculateSubTotal();});
                      }, itemInCart: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(elevation: 10, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), minimumSize: const Size(150, 70),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Total : $subTotal'), const Row(children: [Text('Check Out'), Icon(Icons.chevron_right_outlined),],),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/item_class.dart';

class CartItem extends StatelessWidget {
  final Item item;
  final bool itemInCart;
  final Function() onIncrement;
  final Function() onDecrement;
  final Function() onDismissed;

  const CartItem({
    required this.item,
    required this.itemInCart,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.title),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.delete_forever, color: Colors.white),
        ),
      ),
      onDismissed: (direction) => onDismissed(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, offset: const Offset(5, 7)),
                  BoxShadow(color: Colors.grey.shade300, offset: const Offset(-5, 0)),
                ],
                image: DecorationImage(
                  image: NetworkImage(item.image),
                  fit: BoxFit.fitHeight,
                ),
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 280, top: 30, bottom: 30, right: 10),
                child: itemInCart?Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: onIncrement,
                        icon: const Icon(Icons.add),
                      ),
                      Text(item.quantity.toString(), style: const TextStyle(fontSize: 20)),
                      IconButton(
                        onPressed: onDecrement,
                        icon: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ):null
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(item.title)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(item.price.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

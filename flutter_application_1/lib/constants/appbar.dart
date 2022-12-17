import 'package:flutter/material.dart';

import 'package:flutter_application_1/provider/cart.dart';
import 'package:provider/provider.dart';

import '../screen/checkout.dart';

class SoppingAndPrice extends StatelessWidget {
  const SoppingAndPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Row(
      children: [
        Stack(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckOut()));
                },
                icon: const Icon(Icons.add_shopping_cart)),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 112, 224, 118),
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(22)),
              child: Text(
                "${cart.selectedprodct.length}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Text('\$ ${cart.price}'),
        ),
      ],
    );
  }
}

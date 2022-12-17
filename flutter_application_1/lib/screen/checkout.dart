import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants/appbar.dart';
import '../provider/cart.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 141, 95),
        title: Text(
          'Check Out',
          style: GoogleFonts.kaushanScript(
            textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.5),
          ),
        ),
        centerTitle: true,
        actions: const [SoppingAndPrice()],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 317,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: carttt.selectedprodct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(carttt.selectedprodct[index].name),
                        subtitle: Text(
                            "${carttt.selectedprodct[index].price} - ${carttt.selectedprodct[index].location}"),
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage(carttt.selectedprodct[index].imgPath),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              carttt.remove(carttt.selectedprodct[index]);
                            },
                            icon: const Icon(Icons.remove)),
                      ),
                    );
                  }),
            ),
          ),
          const SizedBox(
            height: 110,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Pay \$${carttt.price}",
              style: const TextStyle(fontSize: 19),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.pink),
              padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
          ),
        ],
      ),
    );
  }
}

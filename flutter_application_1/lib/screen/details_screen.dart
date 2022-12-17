// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/appbar.dart';
import 'package:flutter_application_1/model/item.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatefulWidget {
  final Item product;

  const Details({Key? key, required this.product}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 76, 141, 95),
        title: Text(
          'Details Screen',
          style: GoogleFonts.kaushanScript(
            textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.5),
          ),
        ),
        centerTitle: true,
        actions: const [
          SoppingAndPrice(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.product.imgPath,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$ ${widget.product.price}',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 247, 167, 114),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text('New'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Icon(
                      Icons.star,
                      size: 30,
                      color: Colors.amberAccent,
                    ),
                  ],
                ),
                Icon(
                  size: 30,
                  Icons.star,
                  color: Colors.amberAccent,
                ),
                Icon(
                  size: 30,
                  Icons.star,
                  color: Colors.amberAccent,
                ),
                Icon(
                  Icons.star,
                  size: 30,
                  color: Colors.amberAccent,
                ),
                Icon(
                  Icons.star,
                  size: 30,
                  color: Colors.amberAccent,
                ),
                Icon(
                  Icons.edit_location,
                  size: 23,
                  color: Color.fromARGB(170, 3, 65, 27),
                ),
                Text(
                  widget.product.location,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Details :',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Divider(
              height: 7,
              color: Color.fromARGB(255, 223, 138, 68),
              endIndent: 289,
              indent: 2,
              thickness: 2.1,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              ''' A restaurant is a business that prepares and serves food and drinks to customers.[1] Meals are generally served and eaten on the premises, but many restaurants also offer take-out and food delivery services. Restaurants vary greatly in appearance and offerings, including a wide variety of cuisines and service models ranging from inexpensive fast-food restaurants and cafeterias to mid-priced family restaurants, to high-priced luxury establishments.''',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              maxLines: isShowMore ? 3 : null,
              overflow: TextOverflow.fade,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    isShowMore = !isShowMore;
                  });
                },
                child: Text(
                  isShowMore ? 'Show more ' : 'Show less',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    ));
  }
}

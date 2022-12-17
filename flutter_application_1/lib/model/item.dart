class Item {
  String imgPath;
  double price;
  String location;
  String name;
  Item({
    required this.imgPath,
    required this.price,
    required this.location,
    required this.name,
  });
}

List<Item> items = [
  Item(
      imgPath: 'assets/images/image eating.jpg',
      price: 12.99,
      location: 'Katship shop',
      name: 'product:1'),
  Item(
      imgPath: 'assets/images/image2 eating.jpg',
      price: 12.99,
      location: 'Mexico Shop',
      name: 'product:2'),
  Item(
      imgPath: 'assets/images/image3 eating.jpg',
      price: 12.99,
      location: 'vulcano Shop',
      name: 'product:3'),
  Item(
      imgPath: 'assets/images/image4 eating.jpg',
      price: 12.99,
      location: 'Almanufi shop',
      name: 'product:4'),
  Item(
      imgPath: 'assets/images/image5 eating.jpg',
      price: 12.99,
      location: 'Alshabrawy shop',
      name: 'product:5'),
  Item(
      imgPath: 'assets/images/image6 eating.jpg',
      price: 12.99,
      location: 'Alzaeim shop',
      name: 'product:6'),
  Item(
      imgPath: 'assets/images/image7 eating.jpg',
      price: 12.99,
      location: 'Alasli Shop',
      name: 'product:7'),
  Item(
      imgPath: 'assets/images/image8 eating.jpg',
      price: 12.99,
      location: 'Kabak shakir shop',
      name: 'product:8')
];

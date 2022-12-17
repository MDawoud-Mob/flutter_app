import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetDataFromFirestore extends StatefulWidget {
  final String documentId;

  const GetDataFromFirestore({Key? key, required this.documentId})
      : super(key: key);

  @override
  State<GetDataFromFirestore> createState() => _GetDataFromFirestoreState();
}

class _GetDataFromFirestoreState extends State<GetDataFromFirestore> {
  final unc = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('userSS');
  final credential = FirebaseAuth.instance.currentUser;
  myDialog(Map data, dynamic mykeys) {
    return showDialog(
        context: context,
        builder: (_) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11.5)),
              child: Container(
                height: 197,
                padding: const EdgeInsets.all(22.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      controller: unc,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 186, 200, 207),
                          enabledBorder: OutlineInputBorder(
                              borderSide: Divider.createBorderSide(context)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          hintText: ' ${data[mykeys]} '),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              users
                                  .doc(credential!.uid)
                                  .update({mykeys: unc.text});
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('userSS');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Username: {( ${data['username']} )}?? ",
                    style: const TextStyle(
                        fontSize: 18.3, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              users
                                  .doc(credential!.uid)
                                  .update({"uername": FieldValue.delete()});
                            });
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {
                            myDialog(data, 'username');
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email:${data['email']}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                users
                                    .doc(credential!.uid)
                                    .update({"email": FieldValue.delete()});
                              });
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {
                              myDialog(data, 'email');
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pass: {( ${data['pass']} )}??",
                    style: const TextStyle(
                        fontSize: 17.9, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              users
                                  .doc(credential!.uid)
                                  .update({"pass": FieldValue.delete()});
                            });
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {
                            myDialog(data, 'pass');
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Title: {( ${data['title']} )}?? ",
                    style: const TextStyle(
                        fontSize: 17.9, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              users
                                  .doc(credential!.uid)
                                  .update({"title": FieldValue.delete()});
                            });
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {
                            myDialog(data, 'title');
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Age: {( ${data['age']} years old )}?? ",
                    style: const TextStyle(
                        fontSize: 17.9, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              users
                                  .doc(credential!.uid)
                                  .update({"age": FieldValue.delete()});
                            });
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {
                            myDialog(data, 'age');
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
              Center(
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          users.doc(credential!.uid).delete();
                        });
                      },
                      child: const Text('Delete Data',
                          style: TextStyle(
                              fontSize: 17.9, fontWeight: FontWeight.bold))))
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/data_from_firestore.dart';
import 'package:flutter_application_1/constants/user_img_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' show basename;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;
  File? imgPath;
  String? imgName;
  uploadImage(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int rondom = Random().nextInt(9999999);
          imgName = '$rondom$imgName';
          debugPrint('+++++++++++++++++++++');
          debugPrint(imgName);
        });
      } else {
        debugPrint("NO img selected");
      }
    } catch (e) {
      debugPrint("Error => $e");
    }
  }

  showmodel() {
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              color: Colors.amber[50],
              padding: const EdgeInsets.all(22.5),
              height: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await uploadImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera,
                              size: 31,
                            )),
                        const SizedBox(
                          width: 13,
                        ),
                        const Text('From Camera',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await uploadImage(ImageSource.gallery);

                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.photo_outlined,
                              size: 31,
                            )),
                        const SizedBox(
                          width: 13,
                        ),
                        const Text('From Gallery',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      if (!mounted) return;
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.logout)),
                const Text(
                  'logout',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          )
        ],
        title: Text(
          'Profile Page',
          style: GoogleFonts.kaushanScript(
            textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.5),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.9),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(4.5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(124, 88, 153, 252),
                  ),
                  child: Stack(
                    children: [
                      imgPath == null
                          ? const ImgUser()
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                                height: 130,
                                width: 131,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                          left: 96.9,
                          bottom: -15.6,
                          child: IconButton(
                            onPressed: () async {
                              await showmodel();
                              if (imgPath != null) {
                                final storageRef =
                                    FirebaseStorage.instance.ref(imgName);
                                await storageRef.putFile(imgPath!);
                                String urlll =
                                    await storageRef.getDownloadURL();
                                CollectionReference users = FirebaseFirestore
                                    .instance
                                    .collection('userSS');
                                users.doc(credential!.uid).update({
                                  "imgLink": urlll,
                                });
                              }
                            },
                            icon: const Icon(Icons.add_a_photo_sharp,
                                color: Color.fromARGB(255, 236, 129, 129)),
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 155, 187, 255),
                      borderRadius: BorderRadius.circular(11)),
                  child: const Text(
                    'info from firebase Auth',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22.5),
                  ),
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email : {( ${credential!.email} )}?? ",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.5),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    'Created date: {( ${DateFormat('MMM d,y').format(credential!.metadata.creationTime!)} )}??',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.5),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Last Signed In: {( ${DateFormat('MMM d,y').format(credential!.metadata.lastSignInTime!)} )}??',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.5),
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            credential!.delete();
                            Navigator.pop(context);
                          });
                        },
                        child: const Text('Delete User',
                            style: TextStyle(
                                fontSize: 17.9, fontWeight: FontWeight.bold))),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 155, 187, 255),
                      borderRadius: BorderRadius.circular(11)),
                  child: const Text(
                    'info from firebase firestore',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 22.5),
                  ),
                ),
              ),
              GetDataFromFirestore(
                documentId: credential!.uid,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

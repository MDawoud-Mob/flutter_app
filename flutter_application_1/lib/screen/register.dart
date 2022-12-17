import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/snackbar.dart';
import 'package:flutter_application_1/screen/sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' show basename;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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

  bool isLoading = false;
  bool isvisbality = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  final usernamecontroller = TextEditingController();
  final ageController = TextEditingController();

  final titleController = TextEditingController();

  register() async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passWordController.text,
      );
      // Upload img to firebase.
      final storageRef = FirebaseStorage.instance.ref(imgName);
      await storageRef.putFile(imgPath!);
      String urll = await storageRef.getDownloadURL();

      debugPrint(credential.user!.uid);
      CollectionReference users =
          FirebaseFirestore.instance.collection('userSS');
      debugPrint(credential.user!.uid);
      users
          .doc(credential.user!.uid)
          .set({
            'imgLink': urll,
            'username': usernamecontroller.text,
            'age': ageController.text,
            'title': titleController.text,
            'email': emailController.text,
            'pass': passWordController.text
          })
          .then((value) => debugPrint("User Added"))
          .catchError((error) => debugPrint("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnachBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnachBar(context, 'The account already exists for that email.');
      } else {
        showSnachBar(context, 'Error - please try again late.');
      }
    } catch (e) {
      showSnachBar(context, e.toString());
    }
    setState(() {
      isLoading = false;
    });
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
  void dispose() {
    emailController.dispose();
    passWordController.dispose();
    usernamecontroller.dispose();
    ageController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 76, 141, 95),
            title: Text(
              'Register',
              style: GoogleFonts.kaushanScript(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.5),
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: const Color.fromARGB(255, 209, 201, 201),
          body: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4.5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(124, 88, 153, 252),
                          ),
                          child: Stack(
                            children: [
                              imgPath == null
                                  ? const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 225, 225, 225),
                                      radius: 80,
                                      backgroundImage: NetworkImage(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHfd3PPulVSp4ZbuBFNkePoUR_fLJQe474Ag&usqp=CAU'),
                                    )
                                  : ClipOval(
                                      child: Image.file(
                                        imgPath!,
                                        height: 130,
                                        width: 131,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              Positioned(
                                left: 96.5,
                                bottom: -15.5,
                                child: IconButton(
                                    onPressed: () {
                                      showmodel();
                                    },
                                    icon: const Icon(Icons.add_a_photo_sharp,
                                        color: Color.fromARGB(
                                            255, 236, 129, 129))),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 27,
                        ),
                        TextField(
                          controller: usernamecontroller,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.person)),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 186, 200, 207),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      Divider.createBorderSide(context)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintText: 'Enter Your Username'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                      Icons.pest_control_rodent_rounded)),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 186, 200, 207),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      Divider.createBorderSide(context)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintText: 'Enter Your age'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.person_outline)),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 186, 200, 207),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      Divider.createBorderSide(context)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintText: 'Enter Your title'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            }
                            return null;
                          }),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.email),
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 186, 200, 207),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      Divider.createBorderSide(context)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintText: 'Enter Your Email'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            if (value!.length < 8) {
                              return 'Enter at least 8 characters';
                            }
                            return null;
                          }),
                          controller: passWordController,
                          keyboardType: TextInputType.text,
                          obscureText: isvisbality ? true : false,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isvisbality = !isvisbality;
                                  });
                                },
                                icon: isvisbality
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 186, 200, 207),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      Divider.createBorderSide(context)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintText: 'Enter Your Password'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 36, 121, 38))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  imgName != null &&
                                  imgPath != null) {
                                await register();
                                if (!mounted) return;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Signin()));
                              } else {
                                showSnachBar(context, 'ERROR');
                              }
                            },
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Do not have an account?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Signin()));
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ))
                          ],
                        )
                      ]),
                ),
              ),
            ),
          )),
    );
  }
}

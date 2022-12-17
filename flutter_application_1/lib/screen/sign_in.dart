// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/snackbar.dart';
import 'package:flutter_application_1/provider/google_signin.dart';
import 'package:flutter_application_1/screen/forgot_password.dart';
import 'package:flutter_application_1/screen/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isvisbality = false;
  bool isLoading = false;
  final emailController = TextEditingController();

  final passWordController = TextEditingController();

  signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passWordController.text,
      );
      showSnachBar(context, 'Doneee! ...');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnachBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnachBar(context, 'Wrong password provided for that user.');
      } else {
        showSnachBar(context, 'Error ...!');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignin = Provider.of<GoogleSignInProvider>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 141, 95),
        title: Text(
          'Sign in',
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
        padding: const EdgeInsets.all(11.0),
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    fillColor: const Color.fromARGB(255, 186, 200, 207),
                    enabledBorder: OutlineInputBorder(
                        borderSide: Divider.createBorderSide(context)),
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
                    fillColor: const Color.fromARGB(255, 186, 200, 207),
                    enabledBorder: OutlineInputBorder(
                        borderSide: Divider.createBorderSide(context)),
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
                          const Color.fromARGB(255, 54, 192, 59))),
                  onPressed: () async {
                    await signIn();
                    if (!mounted) return;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Home()));
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Color.fromARGB(255, 247, 118, 109),
                        )
                      : const Text(
                          'sign in',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ForgotPassword()));
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do not have an account?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()));
                      },
                      child: const Text('Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              decoration: TextDecoration.underline))),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                      child: Divider(
                    color: Color.fromARGB(255, 210, 145, 221),
                    thickness: 2,
                  )),
                  Text('OR',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                      child: Divider(
                    color: Color.fromARGB(255, 201, 127, 214),
                    thickness: 2,
                  ))
                ],
              ),
              const SizedBox(
                height: 30.5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    googleSignin.googlelogin();
                  },
                  child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Image(
                        image: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/2991/2991148.png'),
                      )),
                ),
              ])
            ]),
          ),
        ),
      ),
    ));
  }
}

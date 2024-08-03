import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/app_themes.dart';
import '../../../core/utils/validators.dart';
import 'already_have_accout.dart';
import 'sign_up_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isPasswordShown = false;
  String verificationId = '';

  Future<void> _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Otomatik doğrulama
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Verification failed')));
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  Future<void> _signUpWithPhoneNumber(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Kullanıcı Firestore'a kaydediliyor
        await FirebaseFirestore.instance.collection('User').doc(userCredential.user!.uid).set({
          'email': emailController.text,
          'phone': phoneController.text,
          'password': passwordController.text,
        });

        Navigator.pushReplacementNamed(context, AppRoutes.entryPoint);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign up: ${e.toString()}')));
    }
  }

  void onSignUp() async {
    if (_key.currentState!.validate()) {
      await _verifyPhoneNumber();
      // SMS kodunu alıp `_signUpWithPhoneNumber` metodunu çağırmanız gerekiyor
    }
  }

  void onPassShowClicked() {
    setState(() {
      isPasswordShown = !isPasswordShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Email"),
              const SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                validator: Validators.requiredWithFieldName('Email'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppDefaults.padding),
              const Text("Phone Number"),
              const SizedBox(height: 8),
              TextFormField(
                controller: phoneController,
                textInputAction: TextInputAction.next,
                validator: Validators.required,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: AppDefaults.padding),
              const Text("Password"),
              const SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                validator: Validators.required,
                textInputAction: TextInputAction.next,
                obscureText: !isPasswordShown,
                decoration: InputDecoration(
                  suffixIcon: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: onPassShowClicked,
                      icon: SvgPicture.asset(
                        AppIcons.eye,
                        width: 24,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDefaults.padding),
              ElevatedButton(
                onPressed: () async {
                  await _verifyPhoneNumber();
                  showDialog(
                    context: context,
                    builder: (context) {
                      String smsCode = '';
                      return AlertDialog(
                        title: const Text('Enter SMS Code'),
                        content: TextField(
                          onChanged: (value) {
                            smsCode = value;
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await _signUpWithPhoneNumber(smsCode);
                            },
                            child: const Text('Verify'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Sign Up'),
              ),
              const AlreadyHaveAnAccount(),
              const SizedBox(height: AppDefaults.padding),
            ],
          ),
        ),
      ),
    );
  }
}

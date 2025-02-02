import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'otp_screen.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Screen "),centerTitle: true,),
      body: Column(
        children: [
          Text("Phone Screen"),
          TextField(
            controller: phonecontroller,
            keyboardType: TextInputType.phone,
          ),

          SizedBox(height: 10,),

          ElevatedButton(onPressed: ()async{
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: phonecontroller.text.toString(),
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {},
              codeSent: (String verificationId, int? resendToken) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Otpscreen(verificationId: verificationId,)));
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
          }, child: Text("Send OTP")),
      ]),
    );
  }
}

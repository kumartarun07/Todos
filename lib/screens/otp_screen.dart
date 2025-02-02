import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Otpscreen extends StatefulWidget {

  String verificationId = "";
  Otpscreen({required this.verificationId});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  TextEditingController otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Screen "),centerTitle: true,),
      body: Column(
          children: [
            Text("Otp Screen"),
            SizedBox(height: 10,),
            Pinput(
              length: 6,
              keyboardType: TextInputType.number,
              showCursor: true,
              onCompleted: (pin) => print(pin),
              controller: otpcontroller,
              defaultPinTheme: PinTheme(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
              )),
            SizedBox(height: 10,),

            ElevatedButton(onPressed: (){
              
            }, child: Text("Verify OTP")),
          ]),
    );
  }
}

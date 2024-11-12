import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/screens/signup_page.dart';
import '../utills/custom_widget.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget
{
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPassHidden = true;
  static var LoginId = "uid";

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length-1)].shade100,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          height: 400,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),
              color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)].shade200),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Login Your Account",style: myTextstyle25(),),
                SizedBox(height: 20,),
                TextField(
                  controller: emailController,
                  decoration: CustomWidget.textfileDecor(hintext: "Enter Your Email", mLabel: "Email",micon: Icons.email),
                ),
                SizedBox(height: 20,),
                StatefulBuilder(builder: (context,ss){
                  return  TextField(
                    controller: passController,obscureText: isPassHidden,obscuringCharacter: "*",
                    decoration: InputDecoration(
                        hintText: "Enter Your PassWord",
                        label: Text("PassWord"),
                        enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(11),
                            borderSide:BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(11)),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(11)),
                        suffixIcon:IconButton(onPressed: (){
                          isPassHidden=!isPassHidden;
                          ss((){});
                        }, icon: Icon(isPassHidden?Icons.visibility_off:Icons.visibility))
                    ),
                  );
                }),
                SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(onPressed: ()
                  async{
                    String email = emailController.text;
                    String pass = passController.text;
                    try{
                      UserCredential cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email, password: pass);
                      SharedPreferences pref =await SharedPreferences.getInstance();
                      pref.setString(LoginId, cred.user!.uid);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
                    }on FirebaseAuthException catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: Invalid Credentials!!")));
                    }
                    catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error:${e.toString()}")));
                    }
                  }, child: Text("Login",style: myTextstyle20())),
                ),
                SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Create New Account",style:myTextstyle15(),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                    }, child: Text("SignUp",style: myTextstyle20(mColor: Colors.blue),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../utills/custom_widget.dart';
class SignUpPage extends StatelessWidget
{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: Colors.blueGrey.shade300,
      appBar: AppBar(title: Text("Register Your Account",style: myTextstyle20(mFontWeight: FontWeight.bold),),centerTitle: true,backgroundColor: Colors.blueGrey.shade300,),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.blueGrey.shade300),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  decoration: CustomWidget.textfileDecor(hintext: 'Enter Your Name', mLabel: "Name",micon: Icons.account_circle),
                ),
                TextField(
                  controller: emailController,
                  decoration: CustomWidget.textfileDecor(hintext: 'Enter Your Email', mLabel: "Email",micon: Icons.email),
                ),
                TextField(
                  controller: ageController,
                  decoration: CustomWidget.textfileDecor(hintext: 'Enter Your Age', mLabel: "Age",),
                ),
                TextField(
                  controller: mobNoController,
                  decoration: CustomWidget.textfileDecor(hintext: 'Enter Your Mobile Number', mLabel: "Mobile",micon: Icons.call),
                ),
                TextField(
                  controller: passController,
                  decoration: CustomWidget.textfileDecor(hintext: 'Enter Your PassWord', mLabel: "Password",micon: Icons.password),
                ),
                TextField(
                  controller: confirmPassController,
                  decoration: CustomWidget.textfileDecor(hintext: 'Enter Your Confirm PassWord',
                      mLabel: "Confirm PassWord",micon: Icons.password),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: ()async{
                      if(nameController.text.isNotEmpty && emailController.text.isNotEmpty&&
                          ageController.text.isNotEmpty && mobNoController.text.isNotEmpty &&
                          passController.text.isNotEmpty && confirmPassController.text.isNotEmpty)
                      {
                        if(passController.text==confirmPassController.text){
                          try {
                            UserCredential cred =await auth.createUserWithEmailAndPassword(
                                email: emailController.text, password: passController.text);
                            FirebaseFirestore.instance.collection("Users").doc(cred.user!.uid).set(
                              UserModel(
                                  name: nameController.text, email: emailController.text,
                                  profilePic: "",
                                  age: int.parse(ageController.text), mobNo: int.parse(mobNoController.text)).toMap(),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success: User Registered Sucessfully")));
                          }on FirebaseAuthException catch(e){
                            if(e.code=='weak-password'){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: The Password provided is too week")));
                            }else if(e.code=="email-already-in-use"){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: The account already exits for that email ")));

                            }
                          }

                          catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error:$e")));
                          }
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password does not match")));
                        }
                        Navigator.pop(context);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill the required blanks")));
                      }
                    }, child: Text("Register")),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel")),
                  ],
                ),
                Row(
                  children: [
                     Text("Already Have an Account ,",style: myTextstyle15(),),
                    TextButton(onPressed: ()
                    {
                  Navigator.pop(context);
                  }, child: Text("Login now",style: myTextstyle20(mColor: Colors.blue),))
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

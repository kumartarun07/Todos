import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget
{
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
{
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),()
    async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String check = prefs.getString(LoginPage.LoginId)??"";
      Widget newPage = LoginPage();
      if(check !="")
      {
        newPage = HomePage();
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>newPage));
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image(image: AssetImage("lib/assets/image/todo.jpeg",),fit: BoxFit.cover,),),
      floatingActionButton: FloatingActionButton(onPressed: ()
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      },child: Icon(Icons.arrow_forward_sharp,size: 30,),),
    );
  }
}

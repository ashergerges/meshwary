import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meshawery/modules/Authentication/ChooesScreen.dart';
import 'package:meshawery/modules/HomeScreen/home_Screen.dart';
import 'package:meshawery/modules/HomeScreen/tab_screen.dart';
import 'package:meshawery/shared/Components.dart';
import 'package:meshawery/splashScreen/WaitingScreen.dart';

import '../modules/Authentication/AuthLoginScreen.dart';







class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class _MySplashScreenState extends State<MySplashScreen>
{
  startTimer()
  {
    Timer(const Duration(seconds: 1), () async
    {
      //if rider is loggedin already
      if(firebaseAuth.currentUser != null)
      {
       // navigateAndFinish(context, TabScreen);
        FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .get().then((value) {
              if(value['type']=='bus'){
                if(value['isActive']==false){
                 print('haaa');
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=> const WaitingScreen()),(route) {
                    return false;
                  },);
                }
                else{
                  print('toto');
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=> const TabScreen()),(route) {
                    return false;
                  },);
                }
              }
              else{
                print('toto');
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=> const TabScreen()),(route) {
                  return false;
                },);
              }
              setState(() {

              });
        });

      }
      //if rider is NOT loggedin already
      else
      {
        navigateAndFinish(context, OnBoarding);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=> const OnBoarding()),(route) {
          return false;
        },);
      }
    });
  }

  @override
  void initState() {
    super.initState();
   startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("assets/images/logo.png"),
              ),

              const SizedBox(height: 10,),

            ],
          ),
        ),
      ),
    );
  }
}

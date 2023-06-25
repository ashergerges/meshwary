
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meshawery/modules/Authentication/ChooesScreen.dart';
import 'package:meshawery/modules/HomeScreen/home_Screen.dart';
import 'package:meshawery/modules/HomeScreen/tab_screen.dart';
import 'package:meshawery/shared/Components.dart';
import 'package:meshawery/shared/Style.dart';
import 'package:meshawery/splashScreen/WaitingScreen.dart';

import '../modules/Authentication/AuthLoginScreen.dart';







class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class _MySplashScreenState extends State<WaitingScreen>
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
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 15, vertical: 5),
        child: materialWidget(
          context,
          sizeFromHeight(context, 3, hasAppBar: true),
          sizeFromWidth(context, 1),
          20,
          null,
          BoxFit.fill,
          [
            textWidget(
              'Waiting For admin check your data is Valid or not',
              null,
              null,
              petroleum,
              sizeFromWidth(context, 20),
              FontWeight.bold,
            ),
          ],
          MainAxisAlignment.center,
          false,
          10,
          Colors.amber,
              () {},
        ),
      ),
    );
  }
}

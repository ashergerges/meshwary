import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshawery/modules/Authentication/AuthLoginScreen.dart';
import 'package:meshawery/modules/Authentication/AuthSingUpScreen.dart';
import 'package:meshawery/modules/Authentication/cubit/cubit.dart';
import 'package:meshawery/modules/Authentication/cubit/states.dart';
import 'package:meshawery/shared/Style.dart';

import '../../../shared/Components.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AuthenticationCubit(),
      child: BlocConsumer<AuthenticationCubit,AuthenticationStates>(
        listener: ( context,  state) {  },
        builder: ( context, state)
        {
          return Scaffold(
            backgroundColor: white,
            body: SingleChildScrollView(
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Container(
                      height: sizeFromHeight(context, 1.5),
                      decoration: BoxDecoration(
                        image: const DecorationImage(image: AssetImage('assets/images/choose.jpg',), fit: BoxFit.fill,
                        ),
                        //borderRadius: BorderRadius.circular(20.0),
                        color:loginColor,

                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(30.0),
                      child: Column(),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                    height: sizeFromHeight(context, 15),
                    width: sizeFromWidth(context, 1.5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: backgroundColor2,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      ),
                      onPressed: ()
                      {
                        navigateTo(context, AuthLoginScreen());

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 22),
                          ),
                          Icon(Icons.arrow_forward_outlined)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                    height: sizeFromHeight(context, 15),
                    width: sizeFromWidth(context, 1.5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: backgroundColor2,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      ),
                      onPressed: ()
                      {
                       navigateTo(context, AuthSingUpScreen());

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Sing Up",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 22),
                          ),
                          Icon(Icons.arrow_forward_outlined)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
          );
        },

      ),
    );

  }
}

import 'package:flutter/material.dart';
import 'package:meshawery/modules/Authentication/login.dart';
import 'package:meshawery/shared/Style.dart';



class AuthLoginScreen extends StatefulWidget {
  const AuthLoginScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    backgroundColor2,
                    backgroundColorDark
                  ],
                  begin:  FractionalOffset(0.0, 0.0),
                  end:  FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                )
            ),
          ),
          automaticallyImplyLeading: false,
          title: const Text(
            "MeShWaRy",
            style: TextStyle(
                fontSize: 50,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontFamily: "Signatra",
                letterSpacing: 6
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.white,),
                text: "Login",
              ),

            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 6,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  backgroundColorLight,
                  backgroundColorDark
                ],
              )
          ),
          child: const TabBarView(
            children: [
              LoginScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
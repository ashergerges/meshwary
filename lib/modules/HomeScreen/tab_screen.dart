
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshawery/modules/Authentication/cubit/cubit.dart';
import 'package:meshawery/modules/Authentication/cubit/states.dart';
import 'package:meshawery/shared/Style.dart';




class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getUid()..getProfile()..isActive(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          final items=[
           const  Icon(Icons.home,),
           const Icon(Icons.tour,),

            const Icon(Icons.person,),
          ];
          var cubit=AuthenticationCubit.get(context);
          return Scaffold(
            backgroundColor: white,
            body:cubit.screen[cubit.currentIndex],
            extendBody: true,
            bottomNavigationBar: BottomNavigationBar(
              iconSize: 30,
              elevation: 0,
              backgroundColor: white,
              items: const [
                BottomNavigationBarItem(
                    icon:Icon(Icons.home,),
                label:'Home',
                ),
                BottomNavigationBarItem(
                  icon:Icon(Icons.tour,),
                  label:'Trip',
                ),
                BottomNavigationBarItem(
                  icon:Icon(Icons.person,),
                  label:'Profile',
                ),
              ],
              currentIndex:cubit.currentIndex,
              onTap: (index){
                cubit.changePage(index);
              },

            )
          );
        },
      ),
    );

  }
}

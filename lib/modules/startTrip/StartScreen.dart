import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshawery/models/bookingMogel.dart';
import 'package:meshawery/modules/Authentication/cubit/cubit.dart';
import 'package:meshawery/modules/Authentication/cubit/states.dart';
import 'package:meshawery/modules/book/bookingScreen.dart';
import 'package:meshawery/shared/Components.dart';
import 'package:meshawery/shared/Style.dart';
import '../../models/StratTripMogel.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getUid()..availableTrips()..isActive()..getUserOnTrip(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print(AuthenticationCubit.get(context).isActiVe);
          print('asher');
          return ConditionalBuilder(
            condition:AuthenticationCubit.get(context).type=='bus',
            builder: (context) =>  SingleChildScrollView  (
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 118.0,),
                      child: SizedBox(
                        height: sizeFromHeight(context, 15),
                        width: sizeFromWidth(context, 1.5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:  AuthenticationCubit.get(context).isActiVe
                                ?Colors.red:const Color(0xFF6AB2DA),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                          ),
                          onPressed: () {
                            print(AuthenticationCubit.get(context).isActiVe);
                            if (AuthenticationCubit.get(context).isActiVe) {
                              print('asher');
                              AuthenticationCubit.get(context).endTrip();

                            }
                            else {
                              AuthenticationCubit.get(context).setTrip();

                              print('gerges');
                            }

                          },
                          child: Text(
                            AuthenticationCubit.get(context).isActiVe? "End Trip":"Start Trip",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    AuthenticationCubit.get(context).isActiVe?Container(
                      padding: EdgeInsets.all(10),
                      width: sizeFromWidth(context, 1.5),
                      decoration: BoxDecoration(
                        color: backgroundColorDark,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        // image: DecorationImage(
                        //   image: image ?? const AssetImage('assets/images/logo.png'),
                        //
                        // ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey, //New
                              blurRadius: 10.0,
                              offset: Offset(0, 10))
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textWidget(
                            'Total Cost',
                            TextDirection.rtl,
                            null,
                            mainColor,
                            sizeFromWidth(context, 20),
                            FontWeight.bold,
                          ),
                          textWidget(
                            '${AuthenticationCubit.get(context).budget} \€',
                            TextDirection.rtl,
                            null,
                            white,
                            sizeFromWidth(context, 25),
                            FontWeight.bold,
                          ),
                        ],
                      ),
                    ):Center(),
                    AuthenticationCubit.get(context).isActiVe?ConditionalBuilder(
                      // condition: true,
                      // condition: AuthenticationCubit.get(context).hotels.isNotEmpty,
                      condition:true,
                      builder: (context) =>  ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                           return buildGameItem(AuthenticationCubit.get(context).userOnTrip[index] ,context,index);
                          //return buildGameItem(context,index);
                        },
                        separatorBuilder: (context, index) =>
                            divider(10, 10, lightGrey),

                        itemCount: AuthenticationCubit.get(context).userOnTrip.length,
                        //itemCount: 5,
                      ),
                      fallback: (context) => Center(
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
                                'There are no Users added in this Trip',
                                null,
                                null,
                                teal,
                                sizeFromWidth(context, 20),
                                FontWeight.bold,
                              ),
                            ],
                            MainAxisAlignment.center,
                            false,
                            10,
                            beige,
                                () {},
                          ),
                        ),
                      ),
                    ):Center() ,
                  ],
                ),
              ),
            ),
            fallback: (context) => Scaffold(
              appBar: AppBar(
                title:  const Text( 'Available Trips'),
                centerTitle:true,
                backgroundColor:const Color(0xFF6AB2DA),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Column(
                    children: [

                       ConditionalBuilder(
                        // condition: true,
                         condition: AuthenticationCubit.get(context).trips.isNotEmpty,
                       // condition:true,
                        builder: (context) =>  ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                              return buildTripsItem(AuthenticationCubit.get(context).trips[index] ,context,index);
                            //return buildGameItem(context,index);
                          },
                          separatorBuilder: (context, index) =>
                              divider(10, 10, lightGrey),

                          itemCount: AuthenticationCubit.get(context).trips.length,

                        ),
                        fallback: (context) => Center(
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
                                  'There are no Available Trips yet',
                                  null,
                                  null,
                                  teal,
                                  sizeFromWidth(context, 20),
                                  FontWeight.bold,
                                ),
                              ],
                              MainAxisAlignment.center,
                              false,
                              10,
                              backgroundColorDark,
                                  () {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

        },
      ),
    );
  }
}
Widget buildGameItem(BookModel model, context,index)
//Widget buildGameItem( context,index)
{
      return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          // border: Border.all(color: Colors.green, width: 1.5),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, //New
                blurRadius: 10.0,
                offset: Offset(0, 10))
          ],
        ),
        padding: const EdgeInsets.all(20.0),

        child: Column(
          children: [
            Row(

              children: [
                CircleAvatar(
                  radius: sizeFromWidth(context, 12),
                  child: storyShape(
                    // context, white, NetworkImage((model.image)), 20, 22),
                      context, white,
                     // NetworkImage(model.image), 20, 22),
                      NetworkImage(model.image), 20, 22),
                ),
                SizedBox(
                  width: sizeFromWidth(context, 30),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Name : ',
                          style: TextStyle(
                            fontSize: sizeFromWidth(context, 18),

                            color: black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          model.name,
                          style: TextStyle(
                            fontSize: sizeFromWidth(context, 22),

                            color: backgroundColor2,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                     Row(
                       children: [
                         Text(
                          'Number of People : ',
                          style: TextStyle(
                              fontSize: sizeFromWidth(context, 22),

                              color: Colors.grey
                          ),
                    ),
                         Text(
                          '${model.numberOfPeople} x',
                          style: TextStyle(
                              fontSize: sizeFromWidth(context, 22),

                              color: backgroundColor2
                          ),
                    ),
                       ],
                     ),
                  ],
                ),
                Spacer(),

              ],
            ),
            SizedBox(
              height: sizeFromHeight(context, 50),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Code : ',
                      style: TextStyle(
                        fontSize: sizeFromWidth(context, 18),

                        color: black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      model.id,
                      style: TextStyle(
                        fontSize: sizeFromWidth(context, 22),

                        color: backgroundColor2,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sizeFromWidth(context, 22),),
                Container(
                  padding: EdgeInsets.all(10),
                  width: sizeFromWidth(context, 1.5),
                  decoration: const BoxDecoration(
                    color: backgroundColorDark,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // image: DecorationImage(
                    //   image: image ?? const AssetImage('assets/images/logo.png'),
                    //
                    // ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, //New
                          blurRadius: 10.0,
                          offset: Offset(0, 10))
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textWidget(
                        'Total Cost',
                        TextDirection.rtl,
                        null,
                        mainColor,
                        sizeFromWidth(context, 20),
                        FontWeight.bold,
                      ),
                      textWidget(
                        '${model.cost} \€',
                        TextDirection.rtl,
                        null,
                        white,
                        sizeFromWidth(context, 25),
                        FontWeight.bold,
                      ),
                    ],
                  ),
                )
              ],
            ),

            SizedBox(
              height: sizeFromHeight(context, 50),
            ),

          ],
        ),
      ),
    );
}
Widget buildTripsItem(TripModel model,context,index)
{
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        // border: Border.all(color: Colors.green, width: 1.5),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey, //New
              blurRadius: 10.0,
              offset: Offset(0, 10))
        ],
      ),
      padding: const EdgeInsets.all(20.0),

      child: Column(
        children: [
          Row(

            children: [
              CircleAvatar(
                radius: sizeFromWidth(context, 12),
                child: storyShape(
                  // context, white, NetworkImage((model.image)), 20, 22),
                    context, white,
                     NetworkImage(model.image), 20, 22),

              ),
              SizedBox(
                width: sizeFromWidth(context, 30),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Name : ',
                        style: TextStyle(
                          fontSize: sizeFromWidth(context, 18),

                          color: black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '${model.name}',
                        style: TextStyle(
                          fontSize: sizeFromWidth(context, 22),

                          color: backgroundColor2,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                   Row(
                     children: [
                       Text(
                        'Model of Bus : ',
                        style: TextStyle(
                            fontSize: sizeFromWidth(context, 20),

                            color: black
                        ),
                  ),
                       Text(
                        '${model.carModel}',
                        style: TextStyle(
                            fontSize: sizeFromWidth(context, 22),

                            color: backgroundColor2
                        ),
                  ),
                     ],
                   ),
                ],
              ),
              Spacer(),

            ],
          ),
          SizedBox(
            height: sizeFromHeight(context, 50),
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'Direction : ',
                    style: TextStyle(
                      fontSize: sizeFromWidth(context, 18),

                      color: black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    model.direction,
                    style: TextStyle(
                      fontSize: sizeFromWidth(context, 22),

                      color: backgroundColor2,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    'Code : ',
                    style: TextStyle(
                      fontSize: sizeFromWidth(context, 18),

                      color: black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    model.busUid,
                    style: TextStyle(
                      fontSize: sizeFromWidth(context, 29),

                      color: backgroundColor2,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  navigateTo(context, Book_Screen(model));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: sizeFromWidth(context, 1.5),
                  decoration: const BoxDecoration(
                    color: backgroundColorDark,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // image: DecorationImage(
                    //   image: image ?? const AssetImage('assets/images/logo.png'),
                    //
                    // ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, //New
                          blurRadius: 10.0,
                          offset: Offset(0, 10))
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {


                        },
                        child: const Text(
                          'Book',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),

          SizedBox(
            height: sizeFromHeight(context, 50),
          ),

        ],
      ),
    ),
  );
}
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshawery/models/StratTripMogel.dart';
import 'package:meshawery/models/bookingMogel.dart';
import 'package:meshawery/modules/Authentication/cubit/cubit.dart';
import 'package:meshawery/modules/Authentication/cubit/states.dart';
import 'package:meshawery/modules/profile/bus/bus_update_screen.dart';
import 'package:meshawery/modules/profile/user/update_screen.dart';
import 'package:meshawery/shared/Components.dart';
import 'package:meshawery/shared/Style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getProfile()..getUid()..getTripBus()..getTripUser(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print(AuthenticationCubit.get(context).type);
          print("hoooohhohhhohhewewqw");
          return ConditionalBuilder(
            condition:AuthenticationCubit.get(context).type=='bus',
            builder: (context) =>  ConditionalBuilder(
              condition:AuthenticationCubit.get(context).modelBus!=null,
              builder: (context) =>  Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),),

                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        Container(
                                          width: sizeFromWidth(context, 2.7),
                                          height: sizeFromHeight(context, 6),
                                          decoration:  BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(AuthenticationCubit.get(context).modelBus!.image),
                                                  fit: BoxFit.cover)),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (c) => BusUpdateProfile(model: AuthenticationCubit.get(context).modelBus!,)));
                                          },
                                          icon: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: backgroundColor2,
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Text(
                                              AuthenticationCubit.get(context).modelBus!.name,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            // Text(
                                            //   'Gerges',
                                            //   style: TextStyle(
                                            //     fontSize: 20,
                                            //     color: Colors.grey,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                 SizedBox(
                                  width: sizeFromWidth(context, 19)
                                ),
                                Container(
                                  width: 0.9,
                                  height: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: sizeFromWidth(context, 15),
                                ),
                                Column(

                                  children:  [
                                    Text(
                                      'Balance',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      AuthenticationCubit.get(context).modelBus!.budget.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            item('Email', Icons.email),
                            extension(AuthenticationCubit.get(context).modelBus!.email,context),

                            separator(),
                            item('Phone Number', Icons.phone),
                            extension(AuthenticationCubit.get(context).modelBus!.phone,context),
                            separator(),
                            item('Car Model', Icons.car_repair),
                            extension(AuthenticationCubit.get(context).modelBus!.carModel,context),
                            separator(),
                            item('Direction', Icons.directions),
                            extension(AuthenticationCubit.get(context).modelBus!.direction,context),
                            separator(),
                            item('Komsary Name', Icons.person),
                            extension(AuthenticationCubit.get(context).modelBus!.komsaryName,context),
                            separator(),
                            Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                // border: Border.all(color: Colors.green, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey, //New
                                      blurRadius: 10.0,
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Get money from your balance',
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: AuthenticationCubit.get(context).mountController,
                                      decoration: const InputDecoration(
                                        hintText: 'Quantity',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: backgroundColorDark,
                                        border: Border.all(color: Colors.white, width: 1.5),
                                      ),
                                      width: 150,
                                      child: MaterialButton(
                                        onPressed: (){
                                          if(int.parse(AuthenticationCubit.get(context).mountController.text)<=AuthenticationCubit.get(context).modelBus!.budget){
                                            print(':tmam');
                                            AuthenticationCubit.get(context).sendRequest(int.parse(AuthenticationCubit.get(context).mountController.text),AuthenticationCubit.get(context).modelBus!.budget,AuthenticationCubit.get(context).modelBus!.id,AuthenticationCubit.get(context).modelBus!.name,AuthenticationCubit.get(context).modelBus!.phone);
                                          }
                                          else{
                                            showToast(text: "Enter the appropriate amount as per the budget ", state: ToastStates.ERROR);
                                            print('Homar');
                                          }
                                        },
                                        height: 50,
                                        child: const Text(
                                          'Request',
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),


                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                // border: Border.all(color: Colors.green, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey, //New
                                      blurRadius: 10.0,
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'send us Our Feedback',
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: AuthenticationCubit.get(context).feedbackController,
                                      decoration: const InputDecoration(
                                        hintText: 'Feedback',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: backgroundColorDark,
                                        border: Border.all(color: Colors.white, width: 1.5),
                                      ),
                                      width: 150,
                                      child: MaterialButton(
                                        onPressed: (){
                                          if(AuthenticationCubit.get(context).feedbackController.text!=''){
                                            AuthenticationCubit.get(context).sendFeedBack(AuthenticationCubit.get(context).feedbackController.text);
                                          }
                                          else{
                                            showToast(text: "you Must enter Text ", state: ToastStates.ERROR);
                                            print('Homar');
                                          }
                                        },
                                        height: 50,
                                        child: const Text(
                                          'Feedback',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),


                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: itemU('History', Icons.history),
                      ),
                      ConditionalBuilder(
                        // condition: true,
                        condition: AuthenticationCubit.get(context).tripBus.isNotEmpty,
                        //condition:true,
                        builder: (context) =>  ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildGameItemBus(AuthenticationCubit.get(context).tripBus[index] ,context,index);
                            //return buildGameItem(context,index);
                          },
                          separatorBuilder: (context, index) =>
                              divider(10, 10, lightGrey),

                          itemCount: AuthenticationCubit.get(context).tripBus.length,
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
                              backgroundColorDark,
                                  () {},
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: backgroundColorDark,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          width: sizeFromWidth(context, 1.5),
                          child: MaterialButton(
                            onPressed: (){
                              AuthenticationCubit.get(context).logout(context);
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            height: 50,


                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 140,
                      ),
                    ],
                  ),
                ),
              ),

              fallback: (context) => Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),),

                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Container(
                                      width: sizeFromWidth(context, 2.7),
                                      height: sizeFromHeight(context, 6),
                                      decoration:  BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://th.bing.com/th/id/R.4b38b1945e88a36e2308debb1c766e94?rik=15AY1JjLsPP5PQ&pid=ImgRaw&r=0"),
                                              fit: BoxFit.cover)),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                         },
                                      icon: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blueGrey,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'User',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          'Admin',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Container(
                              width: 0.9,
                              height: 80,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: sizeFromWidth(context, 15),
                            ),
                            Column(

                              children: const [
                                Text(
                                  'Balance',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '50',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        item('Email', Icons.email),
                        extension('mmmmmmmm@gmail.com',context),

                        separator(),
                        item('Phone Number', Icons.phone),
                        extension('01000000000',context),
                        separator(),
                        item('Car Model', Icons.car_repair),
                        extension('2010',context),
                        separator(),
                        item('Direction', Icons.directions),
                        extension('الجامعه - حبشى',context),
                        separator(),
                        item('Komsary Name', Icons.person),
                        extension('mmmmmmmmmmmmmm',context),
                        separator(),
                        Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                            // border: Border.all(color: Colors.green, width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey, //New
                                  blurRadius: 10.0,
                                  offset: Offset(0, 10))
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text(
                                  'Get money from your balance',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: AuthenticationCubit.get(context).mountController,
                                  decoration: const InputDecoration(
                                    hintText: 'Quantity',
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.blueGrey,
                                    border: Border.all(color: Colors.white, width: 1.5),
                                  ),
                                  width: 150,
                                  child: MaterialButton(
                                    onPressed: (){

                                    },
                                    child: const Text(
                                      'Request',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    height: 50,


                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        item('History', Icons.history),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.blueGrey,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          width: 500,
                          child: MaterialButton(
                            onPressed: (){
                              AuthenticationCubit.get(context).logout(context);
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            height: 50,


                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            fallback: (context) => ConditionalBuilder(
              condition:AuthenticationCubit.get(context).modelUser!=null,
              builder: (context) =>  Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),),

                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      children: [
                                        Container(

                                          width: sizeFromWidth(context, 2.7),
                                          height: sizeFromHeight(context, 6),
                                          decoration:  BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(AuthenticationCubit.get(context).modelUser!.image),
                                                  fit: BoxFit.cover)),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (c) => UpdateProfile(model: AuthenticationCubit.get(context).modelUser! ,)));
                                          },
                                          icon: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: backgroundColor2,
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Text(
                                              AuthenticationCubit.get(context).modelUser!.name,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            // Text(
                                            //   'Gerges',
                                            //   style: TextStyle(
                                            //     fontSize: 20,
                                            //     color: Colors.grey,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Container(
                                  width: 0.9,
                                  height: 90,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: sizeFromWidth(context, 15),
                                ),
                                Column(

                                  children:  [
                                    Text(
                                      'Balance',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${AuthenticationCubit.get(context).modelUser!.budget}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            itemU('Email', Icons.email),
                            extensionU(AuthenticationCubit.get(context).modelUser!.email,context),

                            separatorU(),
                            itemU('Phone Number', Icons.phone),
                            extensionU(AuthenticationCubit.get(context).modelUser!.phone,context),
                            separatorU(),

                            Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                // border: Border.all(color: Colors.green, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey, //New
                                      blurRadius: 10.0,
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'You can increase your balance through  Cash on this number 01001167185  or  01221167185 or 01551167185 or 0111167185',
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                // border: Border.all(color: Colors.green, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey, //New
                                      blurRadius: 10.0,
                                      offset: Offset(0, 10))
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'send us Our Feedback',
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: AuthenticationCubit.get(context).feedbackController,
                                      decoration: const InputDecoration(
                                        hintText: 'Feedback',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        color: backgroundColorDark,
                                        border: Border.all(color: Colors.white, width: 1.5),
                                      ),
                                      width: 150,
                                      child: MaterialButton(
                                        onPressed: (){
                                          if(AuthenticationCubit.get(context).feedbackController.text!=''){
                                            AuthenticationCubit.get(context).sendFeedBack(AuthenticationCubit.get(context).feedbackController.text);

                                          }
                                          else{
                                            showToast(text: "you Must enter Text ", state: ToastStates.ERROR);
                                            print('Homar');
                                          }
                                        },
                                        height: 50,
                                        child: const Text(
                                          'Feedback',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),


                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: itemU('History', Icons.history),
                      ),
                      ConditionalBuilder(
                        // condition: true,
                        condition: AuthenticationCubit.get(context).tripUser.isNotEmpty,

                        builder: (context) =>  ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            print(AuthenticationCubit.get(context).tripUser);
                            print('a121a1');
                            return buildGameItem(AuthenticationCubit.get(context).tripUser[index] ,context,index);
                          },
                          separatorBuilder: (context, index) =>
                              divider(10, 10, lightGrey),

                          itemCount: AuthenticationCubit.get(context).tripUser.length,
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
                                  'There are no Trips added',
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

                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: backgroundColorDark,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          width: sizeFromWidth(context, 1.5),
                          child: MaterialButton(
                            onPressed: (){
                              AuthenticationCubit.get(context).logout(context);
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            height: 50,


                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 140,
                      ),
                    ],
                  ),
                ),
              ),

              fallback: (context) => Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),),

                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Container(

                                      width: sizeFromWidth(context, 2.7),
                                      height: sizeFromHeight(context, 6),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://th.bing.com/th/id/R.4b38b1945e88a36e2308debb1c766e94?rik=15AY1JjLsPP5PQ&pid=ImgRaw&r=0"),
                                              fit: BoxFit.cover)),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(builder: (context) => UpdateProfile()));
                                      },
                                      icon: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: backgroundColor2,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'User',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          'Admin',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Container(
                              width: 0.9,
                              height: 90,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: sizeFromWidth(context, 15),
                            ),
                            Column(

                              children: const [
                                Text(
                                  'Balance',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '50',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        itemU('Email', Icons.email),
                        extensionU('mmmmmmmm@gmail.com',context),

                        separatorU(),
                        itemU('Phone Number', Icons.phone),
                        extensionU('01000000000',context),
                        separatorU(),

                        Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                            // border: Border.all(color: Colors.green, width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey, //New
                                  blurRadius: 10.0,
                                  offset: Offset(0, 10))
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'You can increase your balance through Vodafone Cash on this number 01000000000',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        itemU('History', Icons.history),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.blueGrey,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          width: 500,
                          child: MaterialButton(
                            onPressed: (){

                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            height: 50,


                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
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
        boxShadow: [
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
                    NetworkImage(model.imageBus), 20, 22),
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
                        '${model.nameBus}',
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
                            fontSize: sizeFromWidth(context, 20),

                            color: Colors.grey
                        ),
                  ),
                       Text(
                        '${model.numberOfPeople} x',
                        style: TextStyle(
                            fontSize: sizeFromWidth(context, 22),

                            color: backgroundColor2,
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
                    'Data : ',
                    style: TextStyle(
                      fontSize: sizeFromWidth(context, 18),

                      color: black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    model.date,
                    style: TextStyle(
                      fontSize: sizeFromWidth(context, 20),

                      color: backgroundColor2,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
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
                    model.busCode,
                    style: TextStyle(
                      fontSize: sizeFromWidth(context,32),

                      color: backgroundColor2,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              Container(
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

Widget buildGameItemBus(TripModel model, context,index)
//Widget buildGameItemBus( context,index)
{
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        // border: Border.all(color: Colors.green, width: 1.5),
        boxShadow: [
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
              // CircleAvatar(
              //   radius: 30.0,
              //   child: storyShape(
              //     // context, white, NetworkImage((model.image)), 20, 22),
              //       context, white,
              //       // NetworkImage(model.image), 20, 22),
              //       NetworkImage('https://th.bing.com/th/id/R.970c4d9fcc301c2b7a324502edfbac34?rik=JA0JwvZ7PHA%2fHg&pid=ImgRaw&r=0'), 20, 22),
              // ),
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
                        'Start Time : ',
                        style: TextStyle(
                          fontSize: 19.0,

                          color: black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        model.startDate,
                        style: TextStyle(
                          fontSize: sizeFromWidth(context, 25),

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
                        'End Time : ',
                        style: TextStyle(
                          fontSize: 19.0,

                          color: black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        model.endDate,
                        style: TextStyle(
                          fontSize:sizeFromWidth(context, 25),

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
                        'Code Trip: ',
                        style: TextStyle(
                          fontSize: 19.0,

                          color: black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        model.id,
                        style: TextStyle(
                          fontSize: sizeFromWidth(context, 25),

                          color: backgroundColor2,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
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
                      '${model.budget} \€',
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
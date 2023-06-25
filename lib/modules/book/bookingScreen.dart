import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshawery/models/StratTripMogel.dart';
import 'package:meshawery/modules/Authentication/cubit/cubit.dart';
import 'package:meshawery/modules/Authentication/cubit/states.dart';
import 'package:meshawery/shared/Components.dart';
import 'package:meshawery/shared/Style.dart';


class Book_Screen extends StatelessWidget {
  TripModel model;

  Book_Screen(this.model, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getUid(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthenticationCubit cubit = AuthenticationCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: backgroundColor2,
              elevation: 0,
              title: Text('Booking in ${model.name} '),
              centerTitle: true,

            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Form(
                    key: AuthenticationCubit.get(context).formKeyAddReview,
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        children: [
                          Container(
                            height: sizeFromHeight(context, 1.5),
                            width: double.infinity,
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
                                const SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(10),

                                  width:  sizeFromWidth(context, 1),
                                  decoration:  BoxDecoration(
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
                                        'Ticket Cost ',
                                        TextDirection.rtl,
                                        null,
                                        orange,
                                        sizeFromWidth(context, 20),
                                        FontWeight.bold,
                                      ),
                                      textWidget(
                                        '${model.cost}',
                                        TextDirection.rtl,
                                        null,
                                        white,
                                        sizeFromWidth(context, 25),
                                        FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const SizedBox(height: 20),
                                TextFormField(
                                  onTap: () {
                                    AuthenticationCubit.get(context).addSalaryCostWith(cubit.ticketNumberController.text,model.cost);
                                  },
                                  onChanged: (value) {

                                    AuthenticationCubit.get(context).addSalaryCostWith(cubit.ticketNumberController.text,model.cost);


                                  },
                                  keyboardType: TextInputType.number,
                                  controller: cubit.ticketNumberController,
                                  cursorColor: petroleum,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Must Write Number of Ticket';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'How many Ticket',
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: petroleum,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: ko),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const SizedBox(
                                  height: 1.0,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),

                                  width:  sizeFromWidth(context, 1),
                                  decoration:  BoxDecoration(
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
                                        orange,
                                        sizeFromWidth(context, 20),
                                        FontWeight.bold,
                                      ),
                                      textWidget(
                                        '${AuthenticationCubit.get(context).sal} \€',
                                        TextDirection.rtl,
                                        null,
                                        white,
                                        sizeFromWidth(context, 25),
                                        FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),

                                Spacer(),
                                defaultButton(
                                  height: sizeFromHeight(context, 18),
                                  width:sizeFromWidth(context, 1.7) ,
                                  background: backgroundColorDark,
                                  border: backgroundColor2,
                                  function: ()
                                  {

                                    if(cubit.ticketNumberController.text!='') {
                                      AuthenticationCubit.get(context).submit(
                                          cubit.sal, model,
                                          cubit.ticketNumberController.text,
                                          context,
                                      );
                                    }
                                    else
                                      {
                                        showToast(text: 'Must Write Number of Ticket', state: ToastStates.ERROR);
                                      }

                                  },
                                  text: 'Submit',
                                  textColor: Colors.white,
                                ),

                              ],
                            ),
                          ),
                          //////


                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

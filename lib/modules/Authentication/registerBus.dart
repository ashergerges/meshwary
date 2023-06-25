import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshawery/modules/Authentication/cubit/cubit.dart';
import 'package:meshawery/modules/Authentication/cubit/states.dart';
import 'package:meshawery/shared/Components.dart';
import 'package:meshawery/shared/Style.dart';

class RegisterBusScreen extends StatelessWidget {
  const RegisterBusScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 10,),
                InkWell(
                  onTap: ()
                  {
                    AuthenticationCubit.get(context).getBusImage();
                  },
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.20,
                    backgroundColor: Colors.white,
                    backgroundImage: AuthenticationCubit.get(context).BusImage==null ? null : FileImage(File(AuthenticationCubit.get(context).BusFile!.path)),
                    child: AuthenticationCubit.get(context).BusImage == null
                        ?
                    Text('Select Image',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22),) : null,
                  ),
                ),
                const SizedBox(height: 10,),
                Form(
                  key: AuthenticationCubit.get(context).formKeySignUpBus,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(

                          child: TextFormField(

                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Full Name can not empty';
                              }
                              return null;

                            },
                            controller: AuthenticationCubit.get(context).nameSignUpBus,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              //border: InputBorder.none,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(17.0)),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: backgroundColor2,
                              ),

                            ),
                            keyboardType:TextInputType.name,
                            onFieldSubmitted: (value){

                            },
                            onChanged: (value){

                            },

                          ),
                        ),
                      ),
                      SizedBox(
                        //height: 10.0,
                        height: sizeFromHeight(context, 100),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(

                          child: TextFormField(
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Email can not empty';
                              }
                              else if(!value.contains('@gmail.com'))
                              {
                                return 'please enter a valid email address';
                              }
                              return null;


                            },
                            controller: AuthenticationCubit.get(context).emailSignUpBus,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              //border: InputBorder.none,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(17.0)),
                              prefixIcon: const Icon(
                                  Icons.email,
                                  color: backgroundColor2
                              ),

                            ),
                            keyboardType:TextInputType.emailAddress,
                            onFieldSubmitted: (value){

                            },
                            onChanged: (value){

                            },

                          ),
                        ),
                      ),
                      SizedBox(

                        height: sizeFromHeight(context, 100),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(

                          child: TextFormField(

                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'phone can not empty';
                              }
                              else if (value.length>11)
                              {
                                return 'phone number must consist of 11 ';
                              }
                              else if (value.length<11)
                              {
                                return 'phone number must consist of 11 ';
                              }
                              return null;

                            },
                            controller: AuthenticationCubit.get(context).phoneSignUpBus,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',

                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(17.0)),

                              prefixIcon: const Icon(
                                  Icons.phone_android_outlined,
                                  color: backgroundColor2
                              ),

                            ),
                            keyboardType:TextInputType.number,
                            onFieldSubmitted: (value){

                            },
                            onChanged: (value){

                            },

                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeFromHeight(context, 100),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(

                          child: defaultFormField(
                            emailAddress: AuthenticationCubit.get(context).passwordSignUpBus,
                            text: 'Password',
                            returnSyntex: 'password can not empty',
                            prefixicon: const Icon(Icons.lock,color: backgroundColor2),
                            keyboardtype: TextInputType.visiblePassword,
                            ispassword: AuthenticationCubit.get(context).isPassword ,
                            suffix: AuthenticationCubit.get(context).suffix,
                            suffixPressed: ()
                            {
                              AuthenticationCubit.get(context).changePasswordVisibility();
                            },


                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeFromHeight(context, 60),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(

                          child: TextFormField(
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Car Model can not empty';
                              }

                              return null;


                            },
                            controller: AuthenticationCubit.get(context).cardModelSignUpBus,
                            decoration: InputDecoration(
                              labelText: 'Car Model',
                              //border: InputBorder.none,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(17.0)),
                              prefixIcon: const Icon(
                                  Icons.card_membership,
                                  color: backgroundColor2
                              ),

                            ),
                            keyboardType:TextInputType.name,
                            onFieldSubmitted: (value){

                            },
                            onChanged: (value){

                            },

                          ),
                        ),
                      ),
                      SizedBox(

                        height: sizeFromHeight(context, 100),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(

                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'Direction can not empty';
                            }
                            return null;

                          },
                          controller: AuthenticationCubit.get(context).directionSignUpBus,
                          decoration: InputDecoration(
                            labelText: 'Direction',
                            //border: InputBorder.none,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(17.0)),
                            prefixIcon: const Icon(
                              Icons.directions,
                              color: backgroundColor2,
                            ),

                          ),
                          keyboardType:TextInputType.name,
                          onFieldSubmitted: (value){

                          },
                          onChanged: (value){

                          },

                        ),
                      ),
                      SizedBox(
                        //height: 10.0,
                        height: sizeFromHeight(context, 100),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(

                          child: TextFormField(

                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Komsary Name can not empty';
                              }
                              return null;

                            },
                            controller: AuthenticationCubit.get(context).komsaryNameSignUpBus,
                            decoration: InputDecoration(
                              labelText: 'Komsary Name',
                              //border: InputBorder.none,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(17.0)),
                              prefixIcon: const Icon(
                                Icons.people_alt_rounded,
                                color: backgroundColor2,
                              ),

                            ),
                            keyboardType:TextInputType.name,
                            onFieldSubmitted: (value){

                            },
                            onChanged: (value){

                            },

                          ),
                        ),
                      ),
                      SizedBox(
                        //height: 10.0,
                        height: sizeFromHeight(context, 100),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(

                          child: TextFormField(

                            validator: (value)
                            {
                              print(AuthenticationCubit.get(context).komsaryAgeSignUpBus.text);
                              print(int.parse(value.toString()));
                              print('age');
                              if(value!.isEmpty)
                              {
                                return 'Komsary Age can not empty';
                              }
                              else if (int.parse(value.toString())<=22)
                              {
                                return 'Komsary Age  must by more than 21 years ';
                              }
                              return null;

                            },
                            controller: AuthenticationCubit.get(context).komsaryAgeSignUpBus,
                            decoration: InputDecoration(
                              labelText: 'Komsary Age',
                              //border: InputBorder.none,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(17.0)),
                              prefixIcon: const Icon(
                                Icons.date_range,
                                color: backgroundColor2,
                              ),

                            ),
                            keyboardType:TextInputType.number,
                            onFieldSubmitted: (value){

                            },
                            onChanged: (value){

                            },

                          ),
                        ),
                      ),
                      //////////////
                      SizedBox(
                        //height: 10.0,
                        height: sizeFromHeight(context, 100),
                      ),
                      SizedBox(
                        height: 50,
                        width: sizeFromWidth(context, 1.2),
                        child: textButton(
                          context,
                          'Select Card Info Face',
                          backgroundColor2,
                          white,
                          sizeFromWidth(context, 20),
                          FontWeight.bold,
                              () {
                                AuthenticationCubit.get(context).getCardInfoFaceImage();
                            //cubit.getVideo();
                          },
                        ),
                      ),
                      SizedBox(
                        //height: 10.0,
                        height: sizeFromHeight(context, 100),
                      ),
                      SizedBox(
                        height: 50,
                        width: sizeFromWidth(context, 1.2),
                        child: textButton(
                          context,
                          'Select Card Info Back',
                          backgroundColor2,
                          white,
                          sizeFromWidth(context, 20),
                          FontWeight.bold,
                              () {
                                AuthenticationCubit.get(context).getCardInfoBackImage();
                            //cubit.getVideo();
                          },
                        ),
                      ),
                      SizedBox(
                        //height: 10.0,
                        height: sizeFromHeight(context, 100),
                      ),
                      SizedBox(
                        height: 50,
                        width: sizeFromWidth(context, 1.2),
                        child: textButton(
                          context,
                          'Select License Face',
                          backgroundColor2,
                          white,
                          sizeFromWidth(context, 20),
                          FontWeight.bold,
                              () {
                                AuthenticationCubit.get(context).getLicenseFaceImage();
                            //cubit.getVideo();
                          },
                        ),
                      ),
                      SizedBox(
                        //height: 10.0,
                        height: sizeFromHeight(context, 100),
                      ),
                      SizedBox(
                        height: 50,
                        width: sizeFromWidth(context, 1.2),
                        child: textButton(
                          context,
                          'Select License Back',
                          backgroundColor2,
                          white,
                          sizeFromWidth(context, 20),
                          FontWeight.bold,
                              () {
                                AuthenticationCubit.get(context).getLicenseBackImage();
                            //cubit.getVideo();
                          },
                        ),
                      ),
                      SizedBox(
                        //height: 10.0,
                        height: sizeFromHeight(context, 100),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: backgroundColor2,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  ),
                  onPressed: ()
                  {
                    if(AuthenticationCubit.get(context).BusImage==null){
                      showToast(text: 'You Must Select image',state: ToastStates.ERROR);
                    }
                    else if (AuthenticationCubit.get(context).cardInfoFaceImage==null){
                      showToast(text: 'You Must Select Card Info Face Image',state: ToastStates.ERROR);
                    }
                    else if (AuthenticationCubit.get(context).cardInfoBackImage==null){
                      showToast(text: 'You Must Select Card Info Back Image',state: ToastStates.ERROR);
                    }
                    else if (AuthenticationCubit.get(context).licenseFaceImage==null){
                      showToast(text: 'You Must Select License Face Image',state: ToastStates.ERROR);
                    }
                    else if (AuthenticationCubit.get(context).licenseBackImage==null){
                      showToast(text: 'You Must Select License Back Image',state: ToastStates.ERROR);
                    }
                    else{
                      if (AuthenticationCubit.get(context).formKeySignUpBus.currentState!.validate()) {
                        AuthenticationCubit.get(context).busRegister(
                          name: AuthenticationCubit.get(context).nameSignUpBus.text.trim(),
                          phone:AuthenticationCubit.get(context).phoneSignUpBus.text.trim() ,
                          email: AuthenticationCubit.get(context).emailSignUpBus.text.trim(),
                          password: AuthenticationCubit.get(context).passwordSignUpBus.text.trim(),
                          context: context,
                          type:'bus' ,
                          cardModelSignUpBus: AuthenticationCubit.get(context).cardModelSignUpBus.text.trim(),
                          directionSignUpBus: AuthenticationCubit.get(context).directionSignUpBus.text.trim(),
                          komsaryAgeSignUpBus: AuthenticationCubit.get(context).komsaryAgeSignUpBus.text.trim(),
                          komsaryNameSignUpBus: AuthenticationCubit.get(context).komsaryNameSignUpBus.text.trim(),
                        );
                      }
                      else{
                        showToast(text: 'Try again,and enter right data',state: ToastStates.ERROR);
                      }
                    }
                    // formValidation();
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 22),
                  ),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          );
        },
      ),
    );

  }
}

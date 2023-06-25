import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshawery/models/BusModel.dart';
import 'package:meshawery/modules/Authentication/cubit/cubit.dart';
import 'package:meshawery/modules/Authentication/cubit/states.dart';
import 'package:meshawery/shared/Style.dart';


class BusUpdateProfile extends StatelessWidget {
  BusModel model;
  BusUpdateProfile({required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthenticationCubit cubit = AuthenticationCubit.get(context);
          cubit.nameBussProfileController.text=model.name;
          cubit.phoneBussProfileController.text=model.phone;
          cubit.carModelBussProfileController.text=model.carModel;
          cubit.directionBussProfileController.text=model.direction;
          cubit.komsaryNameBussProfileController.text=model.komsaryName;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),

                ),
              ),
              title: const Text('Edit Profile',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),),

              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          (cubit.updateImage == null) ? Container(
                            width: 150,
                            height: 150,
                            decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        model.image),
                                    fit: BoxFit.cover)
                            ),
                          ) : ClipOval(
                              child: Image.file(
                                cubit.updateImage!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,)
                          ),
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: (){
                              cubit.getUpdateImage();
                            },
                            icon: Container(
                              height: 50,
                              width: 50,
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: backgroundColor2
                              ),
                              child: const Icon(Icons.camera_alt, color: Colors.white,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Form(
                      key: cubit.formKeyUpdateBus,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Card Model can not empty';
                              }

                              return null;


                            },
                            keyboardType: TextInputType.text,
                            controller: cubit.nameBussProfileController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: cubit.phoneBussProfileController,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                            ),
                            validator: (value){
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
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Card Model can not empty';
                              }

                              return null;


                            },
                            keyboardType: TextInputType.text,
                            controller: cubit.carModelBussProfileController,
                            decoration: const InputDecoration(
                              labelText: 'Car Model',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Card Model can not empty';
                              }

                              return null;


                            },
                            keyboardType: TextInputType.text,
                            controller: cubit.directionBussProfileController,
                            decoration: const InputDecoration(
                              labelText: 'Direction',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Card Model can not empty';
                              }

                              return null;


                            },
                            keyboardType: TextInputType.text,
                            controller: cubit.komsaryNameBussProfileController,
                            decoration: const InputDecoration(
                              labelText: 'Komsary Name',
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 50.0,right: 50,top: 50),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: backgroundColor2,
                          // border: Border.all(color: Colors.green, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey, //New
                                blurRadius: 10.0,
                                offset: Offset(0, 10))
                          ],
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: TextButton(
                          style:ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith((states) => Colors.blueGrey),
                          ),
                          onPressed: (){
                            if(cubit.updateImage == null){
                              if(cubit.formKeyUpdateBus.currentState!.validate()){
                                cubit.updateWithoutImage(





                                  carModel: cubit.carModelBussProfileController.text,
                                  direction: cubit.directionBussProfileController.text,
                                  komsaryName: cubit.komsaryNameBussProfileController.text,
                                  name:cubit.nameBussProfileController.text ,
                                  phone: cubit.phoneBussProfileController.text,
                                  context:context ,
                                  uId: model.id,
                                );
                                //updatawithout image
                              }
                            }
                            else{
                              if(cubit.formKeyUpdateBus.currentState!.validate()){
                                cubit.updateWithImage(
                                  carModel: cubit.carModelBussProfileController.text,
                                  direction: cubit.directionBussProfileController.text,
                                  komsaryName: cubit.komsaryNameBussProfileController.text,
                                  name:cubit.nameBussProfileController.text ,
                                  phone: cubit.phoneBussProfileController.text,
                                  context:context ,
                                  uId: model.id,
                                );
                                //updatawith image
                              }
                            }

                          },
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.check_circle_sharp,
                                color: Colors.white,
                                size: 35,
                              ),

                              Text(
                                'Update'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: sizeFromWidth(context, 18),
                                ),
                              ),
                            ],
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

        },
      ),
    );


  }

}

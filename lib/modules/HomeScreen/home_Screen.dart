import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meshawery/modules/Authentication/cubit/cubit.dart';
import 'package:meshawery/modules/Authentication/cubit/states.dart';
import 'package:meshawery/shared/Components.dart';
import 'package:meshawery/shared/Style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getUid()..getProfile()..getMarkers(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(

              body:  GoogleMap(

                initialCameraPosition: const CameraPosition(
                  target:LatLng(28.086346, 30.763124),
                  zoom:15.5,
                ),
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: false,
                markers: Set<Marker>.of(AuthenticationCubit.get(context).markers),
              ),
          );
        },
      ),
    );
  }

}

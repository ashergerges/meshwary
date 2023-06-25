import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meshawery/models/BusModel.dart';
import 'package:meshawery/models/StratTripMogel.dart';
import 'package:meshawery/models/UserModel.dart';
import 'package:meshawery/models/bookingMogel.dart';
import 'package:meshawery/modules/Authentication/ChooesScreen.dart';
import 'package:meshawery/modules/Authentication/cubit/states.dart';
import 'package:meshawery/modules/HomeScreen/tab_screen.dart';
import 'package:meshawery/modules/profile/profileScreen.dart';
import 'package:meshawery/shared/Components.dart';
import 'package:meshawery/splashScreen/WaitingScreen.dart';
import 'package:meshawery/splashScreen/splash_screen.dart';
import 'package:location/location.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


import '../../../shared/Style.dart';
import '../../HomeScreen/home_Screen.dart';
import '../../startTrip/StartScreen.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates>
{
  AuthenticationCubit() : super(AuthenticationInitialState());

  static  AuthenticationCubit get(contex) =>BlocProvider.of(contex);

   Icon suffix= const Icon(Icons.visibility_outlined,color: backgroundColor2,);
   bool isPassword = true;
  TextEditingController mountController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  TextEditingController ticketNumberController = TextEditingController();
  TextEditingController nameBussProfileController = TextEditingController();
  TextEditingController phoneBussProfileController = TextEditingController();
  TextEditingController carModelBussProfileController = TextEditingController();
  TextEditingController directionBussProfileController = TextEditingController();
  TextEditingController komsaryNameBussProfileController = TextEditingController();
  TextEditingController nameUserProfileController = TextEditingController();
  TextEditingController phoneUserProfileController = TextEditingController();
  var picke = ImagePicker();
  File? updateImage;
  Future<void> getUpdateImage() async {
    final pickedFile = await picke.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      updateImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
    emit(PostImagePickedSuccessState());
  }
  ///////////////////////
  void updateWithImage({required BuildContext context,required String uId,required String name,required String phone,required String carModel,required String direction,required String komsaryName,}){
    id=FirebaseAuth.instance.currentUser!.uid.toString();
    FirebaseStorage.instance
        .ref()
        .child('studentImage/$uId')
        .putFile(updateImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update({
            'image':value,
            'name':name,
            'phone':phone,
            'carModel':carModel,
            'direction':direction,
            'komsaryName':komsaryName,
        });
        emit(SignUPCreateUserSuccessState());
      });
      navigateAndFinish(context, const TabScreen());
      emit(SignUPCreateUserSuccessState());
    })
        .catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(SignUPCreateUserErrorState(error.toString()));

    });
    emit(SignUPCreateSuccessState());
  }
  ////////////////////////
  void updateWithoutImage({required BuildContext context,required String uId,required String name,required String phone,required String carModel,required String direction,required String komsaryName,}){

    id=FirebaseAuth.instance.currentUser!.uid.toString();
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({
      'name':name,
      'phone':phone,
      'carModel':carModel,
      'direction':direction,
      'komsaryName':komsaryName,
    }).then((value) {
      navigateAndFinish(context, const TabScreen());
      emit(SignUPCreateUserSuccessState());
    }) .catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(SignUPCreateUserErrorState(error.toString()));

    });

    emit(SignUPCreateSuccessState());
  }
////////////
  ///////////////////////
  void updateWithImageUser({required BuildContext context,required String uId,required String name,required String phone,}){
    id=FirebaseAuth.instance.currentUser!.uid.toString();
    FirebaseStorage.instance
        .ref()
        .child('studentImage/$uId')
        .putFile(updateImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update({
          'image':value,
          'name':name,
          'phone':phone,

        });
        emit(SignUPCreateUserSuccessState());
      });
      navigateAndFinish(context, const TabScreen());
      emit(SignUPCreateUserSuccessState());
    })
        .catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(SignUPCreateUserErrorState(error.toString()));

    });
    emit(SignUPCreateSuccessState());
  }
  ////////////////////////
  void updateWithoutImageUser({required BuildContext context,required String uId,required String name,required String phone,}){

    id=FirebaseAuth.instance.currentUser!.uid.toString();
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({
      'name':name,
      'phone':phone,

    }).then((value) {
      navigateAndFinish(context, const TabScreen());
      emit(SignUPCreateUserSuccessState());
    }) .catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(SignUPCreateUserErrorState(error.toString()));

    });

    emit(SignUPCreateSuccessState());
  }
////////////
  void changePasswordVisibility()
   {
     isPassword = !isPassword;
     suffix = isPassword?const Icon(Icons.visibility_outlined,color:  Color(0xFF4A5367),): const Icon(Icons.visibility_off_outlined,color:  Color(0xFF4A5367),);

     emit(LoginChangePasswordVisibilityState(),);

   }
   ///////////////////////////
  String startDate = '';
  void selectStartDatePerDay(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2, 3, 5),
      maxTime: DateTime(3500, 6, 7),
      onChanged: (date) {
        startDate = DateFormat.yMMMd().format(date).toString();
        emit(SelectDatePerDayState());
      },
      onConfirm: (date) {
        startDate = DateFormat.yMMMd().format(date).toString();
        emit(SelectDatePerDayState());
      },
      currentTime: DateTime.now(),
    );
  }
  String endDate = '';
  void selectEndDatePerDay(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2, 3, 5),
      maxTime: DateTime(3500, 6, 7),
      onChanged: (date) {
        endDate = DateFormat.yMMMd().format(date).toString();
        emit(SelectDatePerDayState());
      },
      onConfirm: (date) {
        endDate = DateFormat.yMMMd().format(date).toString();
        emit(SelectDatePerDayState());
      },
      currentTime: DateTime.now(),
    );
  }
////////////////////////////////////////////////////////////////////
  int salCost=0;
  int salCostWith=0;
  int sal=0;

  void addSalaryCostWith(String salary,int cost){
    sal=0;
    if(salary.length==0){
      sal=0;
    }
    else{
      sal+=(int.parse(salary)*(cost));
    }
    print(salary);
    print(cost);
    print('!^&*(');

    emit(AddSalaryState());
  }
//////////////
 void sendRequest(int moment,int balence,String id,String name,String phone){

   FirebaseFirestore.instance
       .collection('request')
       .doc()
       .set({
       'money':moment,
       'id':id,
       'name':name,
       'phone':phone,
       }).then((value) {
     FirebaseFirestore.instance
         .collection('users')
         .doc(id)
         .update({
       'budget':balence-moment,
     }).then((value) {
       getProfile();
       mountController.text='';
     });
     showToast(text: "Successfully waiting the process", state:ToastStates.SUCCESS );
     emit(LoginSuccessState());
   });
     emit(LoginSuccessState());

 }
///////////////////////////////
  int currentIndex=0;
  List<Widget>screen=[
    const HomeScreen(),
    const StartScreen(),
    const ProfileScreen(),

  ];

  void changePage(int index) {
    if(index==0){
      id=FirebaseAuth.instance.currentUser!.uid.toString();
    //  getGame();
    }
    if(index==1){
     // getAppointment();
    }
    currentIndex = index;
    emit(TabChangeScreenState());
  }
  /////////////////////////////////////

  // //////////////////////////////////////////////////////////////////////
  bool isShowSignInDialog = false;

  //////////////////////Login/////////////////
  var emailLogin = TextEditingController();
  var passwordLogin = TextEditingController();
  var commentController = TextEditingController();
  var reviewController = TextEditingController();

  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyUpdateBus = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyUpdateUser = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeySignUpUser = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeySignUpBus = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAddHotel = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAddTourist = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAddReview = GlobalKey<FormState>();
///////////////////////////////////////////////////////////////////////////
  File? pickedVideo;
  void getVideo() async {
    final pickedFile = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      pickedVideo = File(pickedFile.path);
      showToast(text: 'Video Selected', state: ToastStates.SUCCESS);
      emit(VideoPickedSuccessState());
    } else {
      emit(VideoPickedErrorState());
    }
  }

  ////////////////////////////////SignUP///////////////////////////////////////
  var phoneSignUpUser = TextEditingController();
  var passwordSignUpUser = TextEditingController();
  var emailSignUpUser = TextEditingController();
  var nameSignUpUser = TextEditingController();
  ////////////////////
  var phoneSignUpBus = TextEditingController();
  var passwordSignUpBus = TextEditingController();
  var emailSignUpBus = TextEditingController();
  var nameSignUpBus = TextEditingController();
  var cardModelSignUpBus = TextEditingController();
  var directionSignUpBus = TextEditingController();
  var komsaryNameSignUpBus = TextEditingController();
  var komsaryAgeSignUpBus = TextEditingController();
  ////////////////////postScreen////////////////////////////////
  File? postImage;
  File? BusImage;
  File? cardInfoFaceImage;
  File? cardInfoBackImage;
  File? licenseFaceImage;
  File? licenseBackImage;
  String? imageUrl;
  String? cardInfoFaceImageUrl;
  String? cardInfoBackImageUrl;
  String? licenseFaceImageUrl;
  String? licenseBackImageUrl;
  String id='';
  String type='';
  var picker = ImagePicker();
  late final pickedFile;
  late final BusFile;

  late final cardInfoFaceFile;
  late final cardInfoBackFile;
  late final licenseFaceFile;
  late final licenseBackFile;
  Future<void> getPostImage() async {
     pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }
  Future<void> getBusImage() async {
    BusFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (BusFile != null) {
      BusImage = File(BusFile.path);
      emit(PostImagePickedTestSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedTestErrorState());
    }
  }
  Future<void> getCardInfoFaceImage() async {
    cardInfoFaceFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (cardInfoFaceFile != null) {
      cardInfoFaceImage = File(cardInfoFaceFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }
  Future<void> getCardInfoBackImage() async {
    cardInfoBackFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (cardInfoBackFile != null) {
      cardInfoBackImage = File(cardInfoBackFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }
  Future<void> getLicenseFaceImage() async {
    licenseFaceFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (licenseFaceFile != null) {
      licenseFaceImage = File(licenseFaceFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }
  Future<void> getLicenseBackImage() async {
    licenseBackFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (licenseBackFile != null) {
      licenseBackImage = File(licenseBackFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }
  Future<void> openPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }
  void removePostImage()
  {
    postImage = null;
    emit(RemovePostImageState());
  }

/////////////////////////////////////////////////////
  TextEditingController searchGameController = TextEditingController();
/////////////////////////Update////////////////////////////



//////////////////////////////////////

  void userRegister({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
    required String phone,
    required String type,

  }) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      id=FirebaseAuth.instance.currentUser!.uid.toString();
      createUser(
        email: email,
        name: name,
        password: password,
        phone: phone,
        uId: value.user!.uid,
        type: type,
        context: context
      );
      emit(SignUPSuccessState());
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(SignUPErrorState(error.toString()));
    });
  }
  //////////////////
  void busRegister({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
    required String phone,
    required String cardModelSignUpBus,
    required String directionSignUpBus,
    required String komsaryNameSignUpBus,
    required String komsaryAgeSignUpBus,
    required String type,

  }) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      id=FirebaseAuth.instance.currentUser!.uid.toString();
      createBus(
          email: email,
          name: name,
          password: password,
          phone: phone,
          uId: value.user!.uid,
          type: type,
          context: context,
        komsaryNameSignUpBus:komsaryNameSignUpBus ,
        komsaryAgeSignUpBus: komsaryAgeSignUpBus,
        directionSignUpBus: directionSignUpBus,
        cardModelSignUpBus:cardModelSignUpBus ,
      );
      emit(SignUPSuccessState());
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(SignUPErrorState(error.toString()));
    });
  }

/////////////////////////////////////////////
  void createUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uId,
    required String type,
    required BuildContext context,

  }) async {
    emit(PickedImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('studentImage/$uId')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl = value;
        UserModel model = UserModel(
          name: name,
          email: email,
          password: password,
          phone: phone,
          image: value,
          id: uId,
          type: type,
          budget: 0,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .set(model.toMap());
          });
      navigateAndFinish(context, const TabScreen());
      emit(SignUPCreateUserSuccessState());
    })
        .catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(SignUPCreateUserErrorState(error.toString()));

    });
     emit(SignUPCreateSuccessState());
  }
////////////////////////////////////////////
  void createBus({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uId,
    required String type,
    required BuildContext context,
    required String cardModelSignUpBus,
    required String directionSignUpBus,
    required String komsaryNameSignUpBus,
    required String komsaryAgeSignUpBus,
  }) async {
    emit(PickedImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('studentImage/$uId')
        .putFile(BusImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value1) {
        imageUrl = value1;
        FirebaseStorage.instance
            .ref()
            .child('cardInfoFaceImage/$uId')
            .putFile(cardInfoFaceImage!)
            .then((value) {
          value.ref.getDownloadURL().then((value2) {
            cardInfoFaceImageUrl = value2;
            FirebaseStorage.instance
                .ref()
                .child('cardInfoBackImage/$uId')
                .putFile(cardInfoBackImage!)
                .then((value) {
              value.ref.getDownloadURL().then((value3) {
                cardInfoBackImageUrl = value3;
                FirebaseStorage.instance
                    .ref()
                    .child('licenseFaceImage/$uId')
                    .putFile(licenseFaceImage!)
                    .then((value) {
                  value.ref.getDownloadURL().then((value4) {
                    licenseFaceImageUrl = value4;
                    FirebaseStorage.instance
                        .ref()
                        .child('licenseBackImage/$uId')
                        .putFile(licenseBackImage!)
                        .then((value) {
                      value.ref.getDownloadURL().then((value5) {
                        licenseBackImageUrl = value5;
                        BusModel model = BusModel(
                          name: name,
                          email: email,
                          password: password,
                          phone: phone,
                          image: value1,
                          id: uId,
                          type: type,
                          carModel: cardModelSignUpBus,
                          direction: directionSignUpBus,
                          komsaryAge: komsaryAgeSignUpBus,
                          komsaryName:komsaryNameSignUpBus ,
                          cardInfoBack: value3,
                          cardInfoFace:value2 ,
                          licenseBack:value5 ,
                          licenseFace:value4 ,
                          isActive: false,
                          budget: 0
                        );
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(uId)
                            .set(model.toMap());
                      });});
                  });});
              });});
          });});
      });
      navigateAndFinish(context, const WaitingScreen());
      emit(SignUPCreateUserSuccessState());
    })
        .catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(SignUPCreateUserErrorState(error.toString()));

    });
    emit(SignUPCreateSuccessState());
  }
  ///////////////////////////////////////





  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {


    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      id=FirebaseAuth.instance.currentUser!.uid.toString();
      navigateAndFinish(context, const TabScreen());
      emit(LoginSuccessState());
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(LoginErrorStateLog(error.toString()));

    });
  }


  void logout(BuildContext context){
    FirebaseAuth.instance.signOut().then((value){
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const OnBoarding()));
    });
  }
  void getUid(){
    id=FirebaseAuth.instance.currentUser!.uid.toString();
    type='';
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get().then((value) {
          type=value['type'];
          emit(LoginSuccessState());
    });

    emit(LoginSuccessState());
  }
/////////////////////////////////

  UserModel? modelUser;

  BusModel? modelBus;
void getProfile(){
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      .get().then((value){
   if(value['type']=='bus'){

     modelBus=BusModel(
       name : value['name'],
       email :value['email'],
       password : value['password'],
       phone :value['phone'],
       image : value['image'],
       id : value['id'],
       carModel : value['carModel'],
       direction :value['direction'],
       cardInfoFace : value['cardInfoFace'],
       cardInfoBack : value['cardInfoBack'],
       licenseFace :value['licenseFace'],
       licenseBack : value['licenseBack'],
       komsaryName : value['komsaryName'],
       komsaryAge : value['komsaryAge'],
       type :value['type'],
       isActive : value['isActive'],
       budget : value['budget'],
     );
     emit(ProfileSuccessState());
   }
   else
   {
     modelUser=UserModel(
       name : value['name'],
       email :value['email'],
       password : value['password'],
       phone :value['phone'],
       image : value['image'],
       id : value['id'],
       type :value['type'],
       budget : value['budget'],
     );
     emit(ProfileSuccessState());
   }
    emit(ProfileSuccessState());
    print("!@!@!@!@!@");
  }).catchError((error){
    print("!@!@!@!@!@");
    print(error.toString());
    emit(ProfileErrorState(error.toString()));
  });
  emit(ProfileSuccessState());
}
///////////////////////////////

///////////////////////////
bool isStart=false;
void changeTrip()
  {
    isStart = !isStart;
    emit(ChangeTripState());

  }
///////////////////////////
void setTrip(){
  String id=FirebaseAuth.instance.currentUser!.uid.toString();
  Location location = Location();
  location.getLocation().then((valoe) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get().then((value) {
      TripModel model = TripModel(
        name: value['name'],
        image: value['image'],
        id: '',
        isActive: true,
        budget: 0,
        direction: value['direction'],
        carModel: value['carModel'],
        busUid: value['id'],
        long: valoe.longitude.toString(),
        lat:valoe.latitude.toString() ,
        cost: 5,
        startDate: DateFormat("yyyy-MM-dd-hh-mm-ss").format(DateTime.now()).toString(),
        endDate: '',
      );
      FirebaseFirestore.instance
          .collection('Trip')
          .doc(id)
          .collection('Trips')
          .add(model.toMap())
          .then((value) {
        FirebaseFirestore.instance
            .collection('Trip')
            .doc(id)
            .collection('Trips')
            .doc(value.id)
            .update({
          'id': value.id,
        });
        FirebaseFirestore.instance
            .collection('Trip')
            .doc(id).set({'id':id});
        emit(TripSuccessState());
      });
      isActive();
      emit(TripSuccessState());
    }).catchError((error){
      emit(TripErrorState(error.toString()));
    });
  });

  emit(TripSuccessState());
}
//////////////////////////
  List<TripModel>trips=[];
void availableTrips(){
  print('availableTrips');
  FirebaseFirestore.instance
      .collection('Trip')
      .get().then((value) {
        print('availableTrips1');
        print(value.docs);
        trips=[];
        for(var element in value.docs)
        {
          print('availableTrips121222');
          print(element.id);
          print('availableTrips121222');
          FirebaseFirestore.instance
              .collection('Trip')
              .doc(element.id)
              .collection('Trips')
              .get().then((value) {
                for(var trip in value.docs)
                {
                  print('availableTrips!!!!!!!!!!!!!!');
                  FirebaseFirestore.instance
                      .collection('Trip')
                      .doc(element.id)
                      .collection('Trips')
                      .doc(trip.id)
                      .get().then((value){
                        if(value['isActive']==true){
                          print('availableTrips@@@@@@@@@');
                          trips.add(TripModel.fromJson(trip.data()));
                        }
                        emit(TripSuccessState());
                  });
                }
                emit(TripSuccessState());
              });
          emit(TripSuccessState());
        }
    emit(TripSuccessState());
  }).catchError((error){
    print(error.toString());
    print('2121212');
  });
    emit(TripSuccessState());

}
//////////////////////////
void submit(int total,TripModel model,String number,BuildContext context){
  String id=FirebaseAuth.instance.currentUser!.uid.toString();
  FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .get().then((value) {
        print(value['budget']);
       if(value['budget']>=total){
         BookModel modely = BookModel(
           name: value['name'],
           image: value['image'],
           id: '',
           cost: total,
           nameUid: id,
           numberOfPeople: int.parse(number),
           date:DateFormat("yyyy-MM-dd-hh-mm-ss").format(DateTime.now()).toString(),
           imageBus: '',nameBus: '',busCode: ''
         );

         FirebaseFirestore.instance
             .collection('users')
             .doc(id)
             .update({'budget':value['budget']-total });
         FirebaseFirestore.instance
             .collection('Trip')
             .doc(model.busUid)
             .collection('Trips')
             .doc(model.id)
             .collection('users')
             .add(modely.toMap())
             .then((value){
           FirebaseFirestore.instance
               .collection('Trip')
               .doc(model.busUid)
               .collection('Trips')
               .doc(model.id)
               .collection('users')
               .doc(value.id)
               .update({
             'id': value.id,
           }).then((value) {
             FirebaseFirestore.instance
                 .collection('Trip')
                 .doc(model.busUid)
                 .collection('Trips')
                 .doc(model.id).get().then((value) {
                   print('1111111111111111');
                   print(value['image']);
               modely.imageBus=value['image'];
               modely.nameBus=value['name'];
               modely.busCode=value['busUid'];

               FirebaseFirestore.instance
                   .collection('users')
                   .doc(id)
                   .collection('trips')
                   .add(modely.toMap());
               emit(SubmitSuccessState());
             });

             emit(SubmitSuccessState());
           });
           emit(SubmitSuccessState());
         });
         FirebaseFirestore.instance
             .collection('Trip')
             .doc(model.busUid)
             .collection('Trips')
             .doc(model.id)
             .get().then((value) {
           FirebaseFirestore.instance
               .collection('Trip')
               .doc(model.busUid)
               .collection('Trips')
               .doc(model.id)
               .update({
             'budget':value['budget']+total,
           });
           showToast(text: 'Ticket Booked Successfully', state: ToastStates.SUCCESS);
           navigateAndFinish(context, const TabScreen());
           emit(SubmitSuccessState());
         });
       }
       else{
         showToast(text: 'You Don\'t Have enough Money', state: ToastStates.ERROR);
       }
  });
  emit(SubmitSuccessState());
}
/////////////////////////
bool isActiVe=false;
void isActive(){
  FirebaseFirestore.instance
      .collection('Trip')
      .doc(id)
      .collection('Trips')
      .get().then((value) {
    isActiVe=false;
        for(var trip in value.docs)
          {
            print('mera!!!!!!!!!');
            FirebaseFirestore.instance
                .collection('Trip')
                .doc(id)
                .collection('Trips')
                .doc(trip.id)
                .get().then((value){
              if(value['isActive']==true){
                print('mera');
                isActiVe=true;
                emit(TripSuccessState());


              }
              emit(TripSuccessState());
            });
            emit(TripSuccessState());
          }
        emit(TripSuccessState());

  });
  emit(TripSuccessState());
}
////////////////////////
void endTrip()
{
  String id=FirebaseAuth.instance.currentUser!.uid.toString();
  FirebaseFirestore.instance
      .collection('Trip')
      .doc(id)
      .collection('Trips')
  .get().then((value) {
    for(var trip in value.docs){
      FirebaseFirestore.instance
          .collection('Trip')
          .doc(id)
          .collection('Trips')
          .doc(trip.id)
          .get().then((valuwe){
            if(valuwe['isActive']){
              FirebaseFirestore.instance
                  .collection('Trip')
                  .doc(id)
                  .collection('Trips')
                  .doc(trip.id)
                  .update({
                'isActive': false,
                'endDate':DateFormat("yyyy-MM-dd-hh-mm-ss").format(DateTime.now()).toString(),
              }).then((value) {
                FirebaseFirestore.instance
                .collection('users')
                    .doc(id).get().then((valuei) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(id).update({'budget':valuei['budget']+int.parse(valuwe['budget']/(80/100)),});
                });
                isActive();
                emit(TripSuccessState());
              });
              emit(TripSuccessState());
            }
            emit(TripSuccessState());
      });
      emit(TripSuccessState());
    }
    emit(TripSuccessState());
  });
  emit(TripSuccessState());
}
///////////////////////
/// kketab
/// naden
/// ahlak
/// asthma
/// atsor
/// labs
/// trip  0.5h
/// blel doha reem
/////////////////////////
List<TripModel>tripBus=[];
void getTripBus() {
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      .get().then((value) {
    type=value['type'];
    if(type=='bus'){
      String id=FirebaseAuth.instance.currentUser!.uid.toString();
      FirebaseFirestore.instance
          .collection('Trip')
          .doc(id)
          .collection('Trips')
          .get().then((value) {
        tripBus=[];
        for(var trip in value.docs)
        {
          if(trip['isActive']==false){
            tripBus.add(TripModel.fromJson(trip.data()));
          }

        }
        emit(TripSuccessState());
      });
    }
    emit(LoginSuccessState());
  });

  emit(TripSuccessState());
}
List<BookModel>tripUser=[];
int budget=0;
void getTripUser() {
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      .get().then((value) {
    type=value['type'];
    if(type=='user'){

      String id=FirebaseAuth.instance.currentUser!.uid.toString();
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('trips')
          .get().then((value) {
        tripUser=[];
        print('enter');
        for(var trip in value.docs)
        {
          tripUser.add(BookModel.fromJson(trip.data()));
        }
        print('enter3');
        print(tripUser);
        emit(TripSuccessState());
      });

    }

  });

  emit(TripSuccessState());
  }
List<BookModel>userOnTrip=[];
void getUserOnTrip(){
  {
    FirebaseFirestore.instance
        .collection('Trip')
        .doc(id)
        .collection('Trips')
        .get().then((value) {
      isActiVe=false;
      budget=0;
      for(var trip in value.docs)
      {
        print('mera!!!!!!!!!');
        FirebaseFirestore.instance
            .collection('Trip')
            .doc(id)
            .collection('Trips')
            .doc(trip.id)
            .get().then((value){
          if(value['isActive']==true){
            budget=value['budget'];
            FirebaseFirestore.instance
                .collection('Trip')
                .doc(value['busUid'])
                .collection('Trips')
                .doc(value['id'])
                .collection('users')
                .get().then((value) {
                 userOnTrip=[];
                 for(var trip in value.docs)
              {
                userOnTrip.add(BookModel.fromJson(trip.data()));
              }
              emit(TripSuccessState());
            });

          }
          emit(TripSuccessState());
        });
        emit(TripSuccessState());
      }
      emit(TripSuccessState());

    });
    emit(TripSuccessState());
  }

  emit(TripSuccessState());
}
////////////////////////
  Set<Marker> markers={};

  void getMarkers()
  {

    Timer.periodic(const Duration(seconds: 5), (Timer t) {


      FirebaseFirestore.instance.
      collection('Trip')
      .get()
      .then((value) {
        markers={};
        for(var element in value.docs)
        {
          FirebaseFirestore.instance.
          collection('Trip')
          .doc(element.id)
          .collection('Trips')
          .get().then((value) {
            for(var element in value.docs)
            {
              if(element['isActive']==true){
                markers.add(
                    Marker(
                      markerId: MarkerId("Source${element['id']}"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: LatLng(double.parse(element['lat']),double.parse(element['long']) ),
                      onTap: ()
                      {

                      },
                    )
                );
              }
            }
            emit(getMarkerState());
          });

          emit(getMarkerState());
        }
        emit(getMarkerState());
      }).
      catchError((error){

      });
      //
    });

  }
///////////////////////
void sendFeedBack(String text){
    FirebaseFirestore.instance
        .collection('FeedBack')
        .doc()
        .set({
      'id':FirebaseAuth.instance.currentUser!.uid.toString(),
      'FeedBck':text,
    }).then((value){
      feedbackController.text='';
      showToast(text: 'Our FeedBack is Send ', state: ToastStates.SUCCESS);
    });
    emit(TripSuccessState());
}
////////////////////////
///map marker
///
}

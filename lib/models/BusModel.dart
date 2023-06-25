class BusModel {
  late String name;
  late String email;
  late String password;//
  late String phone;
  late String image;
  late String id;//
  late String carModel;
  late String direction;
  late String cardInfoFace;//
  late String cardInfoBack;//
  late String licenseFace;//
  late String licenseBack;//
  late String komsaryName;
  late String komsaryAge;//
  late int budget;
  late String type;//
  late bool isActive;//

  BusModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.image,
    required this.id,
    required this.carModel,
    required this.direction,
    required this.cardInfoFace,
    required this.cardInfoBack,
    required this.licenseFace,
    required this.licenseBack,
    required this.komsaryName,
    required this.komsaryAge,
    required this.type,
    required this.isActive,
    required this.budget,
  });

  BusModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    image = json['image'];
    id = json['id'];
    carModel = json['carModel'];
    direction = json['direction'];
    cardInfoFace = json['cardInfoFace'];
    cardInfoBack = json['cardInfoBack'];
    licenseFace = json['licenseFace'];
    licenseBack = json['licenseBack'];
    komsaryName = json['komsaryName'];
    komsaryAge = json['komsaryAge'];
    type = json['type'];
    isActive = json['isActive'];
    budget = json['budget'];


  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
      'id': id,
      'carModel': carModel,
      'direction': direction,
      'cardInfoFace': cardInfoFace,
      'cardInfoBack': cardInfoBack,
      'licenseFace': licenseFace,
      'licenseBack': licenseBack,
      'komsaryName': komsaryName,
      'komsaryAge': komsaryAge,
      'type': type,
      'isActive': isActive,
      'budget': budget,

    };
  }
}
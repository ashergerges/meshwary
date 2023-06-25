class TripModel {
  late String name;
  late String busUid;
  late String long;
  late String lat;
  late String startDate;
  late String endDate;
  late String image;
  late String id;
  late String carModel;
  late String direction;
  late int budget;
  late bool isActive;
  late int cost;

  TripModel({
    required this.name,
    required this.image,
    required this.id,
    required this.carModel,
    required this.direction,
    required this.isActive,
    required this.budget,
    required this.busUid,
    required this.long,
    required this.lat,
    required this.cost,
    required this.startDate,
    required this.endDate,
  });

  TripModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    long = json['long'];
    lat = json['lat'];
    image = json['image'];
    id = json['id'];
    carModel = json['carModel'];
    direction = json['direction'];
    isActive = json['isActive'];
    budget = json['budget'];
    busUid = json['busUid'];
    cost = json['cost'];
    startDate = json['startDate'];
    endDate = json['endDate'];


  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'id': id,
      'carModel': carModel,
      'direction': direction,
      'isActive': isActive,
      'budget': budget,
      'busUid': busUid,
      'lat': lat,
      'long': long,
      'cost': cost,
      'startDate': startDate,
      'endDate': endDate,

    };
  }
}
class BookModel {
  late String name;
  late String nameBus;
  late String busCode;
  late String nameUid;
  late String date;
  late String image;
  late String imageBus;
  late String id;
  late int numberOfPeople;
  late int cost;

  BookModel({
    required this.name,
    required this.image,
    required this.id,
    required this.numberOfPeople,
    required this.cost,
    required this.nameUid,
    required this.date,
    required this.imageBus,
    required this.nameBus,
    required this.busCode,
  });

  BookModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    id = json['id'];
    numberOfPeople = json['numberOfPeople'];
    cost = json['cost'];
    nameUid = json['nameUid'];
    date = json['date'];
    imageBus = json['imageBus'];
    nameBus = json['nameBus'];
    busCode = json['busCode'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'id': id,
      'numberOfPeople': numberOfPeople,
      'cost': cost,
      'nameUid': nameUid,
      'date': date,
      'imageBus': imageBus,
      'nameBus': nameBus,
      'busCode': busCode,


    };
  }
}
class UserModel {
  late String name;
  late String email;
  late String password;
  late String phone;
  late String image;
  late String id;
  late String type;
  late int budget;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.image,
    required this.id,
    required this.type,
    required this.budget,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    image = json['image'];
    id = json['id'];
    type = json['type'];
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
      'type': type,
      'budget': budget,

    };
  }
}
class UserModel
{
  String name;
  String email;
  int age;
  int mobNo;
  var profilePic;
  UserModel({required this.name,required this.email,required this.age,required this.mobNo,required this.profilePic});

  factory UserModel.fromMap(Map<String,dynamic>map)=>UserModel(
      profilePic: map['profilePic'],
      name: map['name'], email: map['email'],
      age: map['age'], mobNo: map['mobNo']);

  Map<String,dynamic>toMap()=>{
    "name":name,
    "email":email,
    "age":age,
    "mobNo":mobNo,
    "profilePic":profilePic
  };

}
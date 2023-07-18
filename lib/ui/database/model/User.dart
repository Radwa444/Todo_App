class User{
  String? id;
  String? name;
  String? email;
  User({this.id, this.name, this.email});
  User.fromfirestore(Map<String,dynamic>? data):this(
    id:data?['id'],
    name: data?['name'],
    email: data?['email']
  );
  Map<String,dynamic> tofirestore(){
    return{
      'id':id,
      'name':name,
      'email':email
    };
  }
}
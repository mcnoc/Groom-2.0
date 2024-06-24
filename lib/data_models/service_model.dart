class ServiceModel{
  String title= '';


ServiceModel({required this.title});


  ServiceModel.fromJson(Map<dynamic,dynamic>json){
    title = json['title'];


  }
}
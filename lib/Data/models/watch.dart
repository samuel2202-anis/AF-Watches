//import 'package:equatable/equatable.dart';
class Watch
    //extends Equatable
{
  final int id;
  final String name;
  final String description;
  final int price;
  final String image;

  const Watch(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image});

  factory Watch.fromMap(data) => Watch(
      id: data['id'],
      price: data['price'],
      description: data['description'],
      image: data['img'],
      name: data['name']);

 // @override
  // TODO: implement props
  //List<Object?> get props => throw UnimplementedError();
}

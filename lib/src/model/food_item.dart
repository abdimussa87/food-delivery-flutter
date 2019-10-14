import 'package:flutter/cupertino.dart';

class FoodItem {
  final int id;
  final String title;
  final String hotel;
  final double price;
  final String imgUrl;
   int quantity;

  FoodItem(
      {
    @required  this.id,
    @required  this.title,
    @required  this.hotel,
    @required  this.price,
    @required  this.imgUrl,
     this.quantity = 1
     });
}

class FoodItemList{

  List<FoodItem> foodItems;
  FoodItemList({@required this.foodItems});
}

FoodItemList foodItemList = FoodItemList(foodItems: [
  FoodItem(
    id: 1,
    title: 'Beach BBQ Burger',
    hotel: "Las Vegas Hotel",
    price: 14.49,
    imgUrl: "https://static.food2fork.com/burger53be.jpg"
  ),
  FoodItem(
    id: 2,
    title: "Kick Ass Burgers",
    hotel: "Dudleys",
    price: 11.99,
    imgUrl: "https://b.zmtcdn.com/data/pictures/chains/8/18427868/1269c190ab2f272599f8f08bc152974b.png"
  ),
  FoodItem(
    id:3,
    title: "Supreme Pizza Burger",
    hotel: "Gold Course",
    price: 8.49,
    imgUrl: "https://static.food2fork.com/burger53be.jpg"
  ),
  FoodItem(
    id: 4,
    title: "Chilly Cheese Burger",
  hotel: "Las Vegas Hotel",
  price: 14.49,
  imgUrl:"https://static.food2fork.com/36725137eb.jpg" ,
  ),
  FoodItem(
    id: 5,
    title: "Turkey Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    imgUrl: "https://static.food2fork.com/turkeyburger300x200ff84052e.jpg",
  ),
  FoodItem(
    id: 6,
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    imgUrl: "https://static.food2fork.com/36725137eb.jpg",
  ),
]);

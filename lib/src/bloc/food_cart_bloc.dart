import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:food_delivery/src/bloc/food_list_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../model/food_item.dart';

class FoodCartBloc extends BlocBase {

FoodCartBloc();

//Stream that receives a number and changes the count;
var _foodCartController = BehaviorSubject<List<FoodItem>>.seeded([]); // seeded helps for initializing the stream if no value has been added for the first time to whatever you want
//output
Stream<List<FoodItem>> get foodListStream => _foodCartController.stream;
//input
Sink<List<FoodItem>> get foodListSink => _foodCartController.sink;

// usefull for giving back the List<FoodItem>
FoodListProvider foodListProvider = FoodListProvider();

addToList(FoodItem  foodItem){
  foodListSink.add(foodListProvider.addToList(foodItem));
}

removeFromList(FoodItem foodItem){
  foodListSink.add(foodListProvider.removeFromList(foodItem));
}




//dispose will be called automatically by closing its streams
@override
void dispose() {
  _foodCartController.close();
  super.dispose();
}

}
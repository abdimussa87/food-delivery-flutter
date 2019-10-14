import '../model/food_item.dart';

class FoodListProvider {
  List<FoodItem> foodItems = [];
  bool isPresent = false;
  List<FoodItem> addToList(FoodItem foodItem) {
    if (foodItems.length > 0) {
      for (int i = 0; i < foodItems.length; i++) {
        if (foodItem.id == foodItems[i].id) {
          isPresent = true;
          foodItems[i].quantity += 1;
          break;
        } else {
          isPresent = false;
        }
      }
      if (!isPresent) {
        foodItems.add(foodItem);
      }
    } else {
      foodItems.add(foodItem);
    }

    return foodItems;
  }

  List<FoodItem> removeFromList(FoodItem foodItem) {
    if (foodItem.quantity > 1) {
      foodItem.quantity -= 1;
    } else {
      foodItems.remove(foodItem);
    }
    return foodItems;
  }
}

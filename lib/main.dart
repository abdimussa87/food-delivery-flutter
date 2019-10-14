import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:food_delivery/src/bloc/color_bloc.dart';
import 'package:food_delivery/src/bloc/food_cart_bloc.dart';
import 'package:food_delivery/src/model/food_item.dart';

import 'cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => FoodCartBloc()),
        Bloc((i)=>ColorBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Delivery',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            FirstHalf(),
            SizedBox(
              height: 45,
            ),
            for (var foodItem in foodItemList.foodItems)
              ItemContainer(foodItem: foodItem)
          ],
        ),
      ),
    );
  }
}

class ItemContainer extends StatelessWidget {
  final FoodItem foodItem;
  ItemContainer({Key key, this.foodItem}) : super(key: key);

  final FoodCartBloc bloc = BlocProvider.getBloc<FoodCartBloc>();
  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(foodItem);
        final snackBar = SnackBar(
          content: Text("${foodItem.title} has been added to cart."),
          duration: Duration(seconds: 1),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Items(
        hotel: foodItem.hotel,
        itemName: foodItem.title,
        itemPrice: foodItem.price,
        imgUrl: foodItem.imgUrl,
        leftAligned: (foodItem.id % 2 == 0) ? true : false,
      ),
    );
  }
}

class Items extends StatelessWidget {
  final String hotel;
  final String itemName;
  final double itemPrice;
  final String imgUrl;
  final bool leftAligned;

  const Items(
      {Key key,
      this.hotel,
      this.itemName,
      this.itemPrice,
      this.imgUrl,
      this.leftAligned})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: leftAligned ? 0 : 45,
        right: leftAligned ? 45 : 0,
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(
                left: leftAligned ? Radius.circular(0) : Radius.circular(10),
                right: leftAligned ? Radius.circular(10) : Radius.circular(0),
              ),
              child: Image.network(
                imgUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(
              left: leftAligned ? 20 : 0,
              right: leftAligned ? 0 : 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(itemName,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          )),
                    ),
                    Text(
                      "\$$itemPrice",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.lightGreen,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black45),
                    children: [
                      TextSpan(
                        text: "by ",
                      ),
                      TextSpan(
                        text: hotel,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FirstHalf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 25, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          SizedBox(
            height: 20,
          ),
          title(),
          SizedBox(
            height: 10,
          ),
          searchBar(),
          SizedBox(
            height: 30,
          ),
          categories(),
        ],
      ),
    );
  }

  Widget categories() {
    return Container(
      height: 185,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: true,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Rolls",
            availability: 2,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Pizza",
            availability: 10,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Lasagna",
            availability: 5,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: false,
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.search,
          color: Colors.black45,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintStyle: TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget title() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 45,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Food",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
              Text(
                "Delivery",
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final FoodCartBloc bloc = BlocProvider.getBloc<FoodCartBloc>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          StreamBuilder(
            stream: bloc.foodListStream,
            builder: (context, snapshot) {
              final List<FoodItem> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;

              return GestureDetector(
                onTap: () {
                  if(length > 0){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Cart();
                    }));
                  }
                  else{
                    return null;
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.yellow[800],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(length.toString()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final String categoryName;
  final int availability;
  final bool selected;
  final IconData categoryIcon;

  const CategoryListItem(
      {Key key,
      this.categoryName,
      this.availability,
      this.selected,
      this.categoryIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 20,
      ),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: selected ? Color(0xfffeb324) : Colors.white,
        border: Border.all(
            color: selected ? Colors.transparent : Colors.grey, width: 1.5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[100],
              blurRadius: 15,
              offset: Offset(25, 0),
              spreadRadius: 5),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: selected ? Colors.transparent : Colors.grey,
                  width: 1.5),
            ),
            child: Icon(
              categoryIcon,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 15),
          Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 6, 0, 10),
            width: 1.5,
            height: 15,
            color: Colors.black26,
          ),
          Text(
            "$availability",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

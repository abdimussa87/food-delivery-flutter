import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/src/bloc/color_bloc.dart';
import 'package:food_delivery/src/bloc/food_cart_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:food_delivery/src/model/food_item.dart';

class Cart extends StatelessWidget {
  final FoodCartBloc bloc = BlocProvider.getBloc<FoodCartBloc>();
  @override
  Widget build(BuildContext context) {
    List<FoodItem> foodItems;
    return StreamBuilder(
      stream: bloc.foodListStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          foodItems = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: CartBody(foodItems: foodItems),
            ),
            bottomNavigationBar: BottomBar(foodItems),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}

class BottomBar extends StatelessWidget {
  final List<FoodItem> foodItems;
  BottomBar(this.foodItems);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25, right: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(),
          Divider(
            height: 1,
            color: Colors.grey[800],
          ),
          persons(),
          nextButtonBar(),
        ],
      ),
    );
  }

  Widget nextButtonBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xfffeb324),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "15 -25 min",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            "Next",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget persons() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Persons",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          CustomPersonWidget(),
        ],
      ),
    );
  }

  Widget totalAmount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "Total",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Text(
          "\$${totalFoodPrice(foodItems)}",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.w700, fontSize: 28),
        )
      ],
    );
  }

  String totalFoodPrice(List<FoodItem> foodItems) {
    double totalAmount = 0;
    if (foodItems.length == 0) {
      return totalAmount.toString();
    } else {
      for (int i = 0; i < foodItems.length; i++) {
        totalAmount += foodItems[i].price * foodItems[i].quantity;
      }
      return totalAmount.toStringAsFixed(2);
    }
  }
}

class CustomPersonWidget extends StatefulWidget {
  @override
  _CustomPersonWidgetState createState() => _CustomPersonWidgetState();
}

class _CustomPersonWidgetState extends State<CustomPersonWidget> {
  int noOfPersons = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1.5),
      ),
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                noOfPersons -= 1;
              });
            },
            child: Text(
              "-",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 5,
            ),
            decoration: BoxDecoration(border: Border.all()),
            child: Text(
              "$noOfPersons",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                noOfPersons += 1;
              });
            },
            child: Text(
              "+",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class CartBody extends StatelessWidget {
  final List<FoodItem> foodItems;

  CartBody({Key key, this.foodItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 40, 25, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          title(),
          Expanded(
            //flex: 1,
            child: foodItems.length > 0 ? foodItemList() : noItemContainer(),
          ),
        ],
      ),
    );
  }

  Widget foodItemList() {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (context, int index) {
        return CartListItemContainer(foodItem: foodItems[index]);
      },
    );
  }

  Widget noItemContainer() {
    return Container(
      child: Center(
        child: Text("No Food Added to cart",
            style: TextStyle(
              fontSize: 20,
            )),
      ),
    );
  }

  Widget title() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "My",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
            Text(
              "Order",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class CartListItemContainer extends StatelessWidget {
  final FoodItem foodItem;

  const CartListItemContainer({Key key, this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: foodItem,
      child: DraggableChild(
        foodItem: foodItem,
      ),
      maxSimultaneousDrags: 1,
      feedback: DraggableChildFeedback(
        foodItem: foodItem,
      ),
      childWhenDragging: foodItem.quantity > 1
          ? DraggableChild(
              foodItem: foodItem,
            )
          : Container(),
    );
  }
}

class DraggableChild extends StatelessWidget {
  const DraggableChild({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                foodItem.imgUrl,
                fit: BoxFit.fitHeight,
                height: 55,
                width: 80,
              ),
            ),
          ),
          Expanded(
                      child: RichText(
              text: TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: foodItem.quantity.toString(),
                    ),
                    TextSpan(text: "x"),
                    TextSpan(text: foodItem.title),
                  ]),
            ),
          ),
          Text(
            "\$${foodItem.price * foodItem.quantity}",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class DraggableChildFeedback extends StatelessWidget {
  final FoodItem foodItem;

  const DraggableChildFeedback({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<ColorBloc>();
    return Opacity(
      opacity: 0.7,
      child: Material(
        child: StreamBuilder(
          stream: bloc.colorStream,
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(
                color: snapshot.hasData? snapshot.data : Colors.white,
              ),
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        foodItem.imgUrl,
                        fit: BoxFit.fitHeight,
                        height: 55,
                        width: 80,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: foodItem.quantity.toString(),
                          ),
                          TextSpan(text: "x"),
                          TextSpan(text: foodItem.title),
                        ]),
                  ),
                  Text(
                    "\$${foodItem.price * foodItem.quantity}",
                    style:
                        TextStyle(color: Colors.green, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final bloc = BlocProvider.getBloc<FoodCartBloc>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              size: 30,
            ),
          ),
        ),
        DragTargetWidget(),
      ],
    );
  }
}

class DragTargetWidget extends StatefulWidget {
  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  final bloc = BlocProvider.getBloc<FoodCartBloc>();
  final colorBloc = BlocProvider.getBloc<ColorBloc>();
  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onWillAccept: (FoodItem foodItem) {
        colorBloc.setColor(Colors.red);
        return true;
      },
      onAccept: (FoodItem foodItem) {
        bloc.removeFromList(foodItem);
        colorBloc.setColor(Colors.white);
      },
      onLeave: (FoodItem foodItem){
        colorBloc.setColor(Colors.white);
      },
      builder: (context, incoming, rejected) {
        return Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            child: Icon(
              CupertinoIcons.delete,
              size: 35,
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}

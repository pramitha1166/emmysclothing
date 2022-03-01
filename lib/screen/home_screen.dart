import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/product_item_model.dart';
import 'package:ecommerce/model/tab_item_model.dart';
import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:ecommerce/presentaion/widget/app_text.dart';
import 'package:ecommerce/presentaion/widget/product_item.dart';
import 'package:ecommerce/presentaion/widget/tab_item.dart';
import 'package:ecommerce/service/product_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  //final String _currentCategory = "sneakers";

  List<TabItemModel> tabItems = [
    TabItemModel(img: "img/items/sneaker.png", title: "Sneakers", active: true),
    TabItemModel(img: "img/items/watch.png", title: "Watch", active: false),
    TabItemModel(img: "img/items/jacket.png", title: "Jackets", active: false),
  ];

  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> get_products = [
    {
      "name": "NIKE AIR MAX 2020",
      "price": 240.00,
      "status": "Trending Now",
      "img": "img/items/sneaker.png",
      "category": "sneakers"
    },
    {
      "name": "NIKE AIR 97",
      "price": 220.00,
      "status": "Best Selling",
      "img": "img/items/jacket.png",
      "category": "watch"
    },
    {
      "name": "NIKE AIR II 2021",
      "price": 250.00,
      "status": "Trending Now",
      "img": "img/items/watch.png",
      "category": "jacket"
    },
    {
      "name": "NIKE AIR PRO 2020",
      "price": 340.00,
      "status": "Trending Now",
      "img": "img/items/sneaker.png",
      "category": "sneakers"
    },
  ];

  Stream<QuerySnapshot> product_stream = ProductService().sneakers_products;

  List<ProductItem> mapData(filterRequest) {
    return get_products
        .map((Map rowData) {
          return ProductItem(
            name: rowData["name"],
            img: rowData["img"],
            price: rowData["price"],
            status: rowData["status"],
            category: rowData["category"],
          );
        })
        .where((element) => element.category == filterRequest)
        .toList();
  }

  List<ProductItem> prducts = [];

  AnimationController? _colorAnimationController;
  Animation? _colorAnimation;

  @override
  void initState() {
    setState(() {
      prducts = mapData("sneakers");
    });
    super.initState();

    _colorAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _colorAnimation = ColorTween(begin: Colors.grey, end: AppColors.main)
        .animate(_colorAnimationController!);

    _colorAnimationController?.addListener(() {
      print(_colorAnimationController!.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<User>();

    return PlayAnimation<double>(
      child: homeScreen(user: user),
      builder: (context, child, value) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      tween: Tween(begin: 0, end: 1),
      curve: Curves.bounceInOut,
      duration: const Duration(milliseconds: 1000),
    );
  }

  SafeArea homeScreen({required User user}) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.all(20),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: Offset(0, 0)),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              Expanded(child: Container()),
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 10,
                        offset: Offset(0, 1)),
                  ],
                  image: DecorationImage(
                      image: NetworkImage(user.photoURL!), fit: BoxFit.cover),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                  size: 40,
                  text: "Hello",
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              AppText(
                  size: 30,
                  text: user.displayName!,
                  color: Colors.black45,
                  fontWeight: FontWeight.normal),
              const SizedBox(
                height: 20,
              ),
              AppText(
                  size: 40,
                  text: "Our Products",
                  color: Colors.black87,
                  fontWeight: FontWeight.bold)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.maxFinite,
            height: 80,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tabItems.length,
                itemBuilder: (_, index) {
                  return AnimatedBuilder(
                    animation: _colorAnimationController!,
                    builder: (BuildContext context, _) {
                      return TabItem(
                        tabItemModel: tabItems[index],
                        onTap: () {
                          setState(() {
                            if (tabItems[index].active == true) {
                              tabItems[index].active == true;
                              _colorAnimationController!.forward();
                            } else {
                              for (var element in tabItems) {
                                element.active = false;
                              }
                              tabItems[index].active = true;
                              switch (index) {
                                case 1:
                                  //prducts = mapData("watch");
                                  product_stream =
                                      ProductService().watches_products;
                                  break;
                                case 2:
                                  product_stream =
                                      ProductService().jacket_products;
                                  break;
                                default:
                                  product_stream =
                                      ProductService().sneakers_products;
                                  break;
                              }
                            }
                          });
                        },
                        color: tabItems[index].active
                            ? AppColors.main
                            : Colors.grey,
                      );
                    },
                  );
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: double.maxFinite,
              height: 250,
              // ignore: prefer_is_empty
              child: StreamBuilder<QuerySnapshot>(
                  stream: product_stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    //List<DocumentSnapshot>? products = snapshot.data!.docs;

                    if (snapshot.hasError) {
                      return const Text("Error");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                        itemCount: 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => ProductItemWidget(
                            productItem: ProductItem(
                                name: "",
                                img: "",
                                price: 100,
                                category: "",
                                status: ""),
                            isLoading: true),
                      );
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No item found"));
                    }

                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.docs
                          .map((DocumentSnapshot documentSnapshot) {
                        Map<String, dynamic> data =
                            documentSnapshot.data()! as Map<String, dynamic>;
                        ProductItem productItem = ProductItem(
                            name: data["name"],
                            img: data["img"],
                            price: data["price"].toDouble(),
                            category: data["category"],
                            status: data["status"] ?? "new item");
                        return ProductItemWidget(
                          productItem: productItem,
                          isLoading: false,
                        );
                      }).toList(),
                    );
                  }))
        ],
      ),
    ));
  }
}

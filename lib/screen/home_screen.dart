import 'package:ecommerce/model/product_item_model.dart';
import 'package:ecommerce/model/tab_item_model.dart';
import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:ecommerce/presentaion/widget/app_text.dart';
import 'package:ecommerce/presentaion/widget/product_item.dart';
import 'package:ecommerce/presentaion/widget/tab_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  void initState() {
    setState(() {
      prducts = mapData("sneakers");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return homeScreen();
  }

  SafeArea homeScreen() {
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 10,
                        offset: Offset(0, 1)),
                  ],
                  image: const DecorationImage(
                      image: AssetImage("img/user.jpeg"), fit: BoxFit.cover),
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
                  text: "Our",
                  color: Colors.black87,
                  fontWeight: FontWeight.normal),
              AppText(
                  size: 40,
                  text: "Products",
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
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (tabItems[index].active == true) {
                          tabItems[index].active == true;
                        } else {
                          for (var element in tabItems) {
                            element.active = false;
                          }
                          tabItems[index].active = true;

                          switch (index) {
                            case 1:
                              prducts = mapData("watch");
                              break;
                            case 2:
                              prducts = mapData("jacket");
                              break;
                            default:
                              prducts = mapData("sneakers");
                              break;
                          }
                        }
                      });
                    },
                    child: TabItem(
                      tabItemModel: tabItems[index],
                    ),
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
              child: prducts.length == 0
                  ? const Text("Loading")
                  : ListView.builder(
                      itemCount: prducts.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ProductItemWidget(productItem: prducts[index]);
                      },
                    ))
        ],
      ),
    ));
  }
}

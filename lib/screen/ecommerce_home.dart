import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce/presentaion/misc/colors.dart';
import 'package:ecommerce/presentaion/widget/navigation_drawer.dart';
import 'package:ecommerce/screen/cart_screen.dart';
import 'package:ecommerce/screen/home_screen.dart';
import 'package:ecommerce/screen/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EcommerceHome extends StatefulWidget {
  const EcommerceHome({Key? key}) : super(key: key);

  @override
  _EcommerceHomeState createState() => _EcommerceHomeState();
}

class _EcommerceHomeState extends State<EcommerceHome> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return Scaffold(
        body: switchScreen(),
        drawer: const NavigationDrawer(),
        bottomNavigationBar: CurvedNavigationBar(
          buttonBackgroundColor: AppColors.main,
          backgroundColor: AppColors.ecommerceBackground,
          index: _page,
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          items: <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: _page == 0 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.search,
              size: 30,
              color: _page == 1 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.shop,
              size: 30,
              color: _page == 2 ? Colors.white : Colors.black,
            ),
          ],
        ));
  }

  Widget switchScreen() {
    switch (_page) {
      case 1:
        return const SearchScreen();
      case 2:
        return const CartScreen();
      default:
        return const HomeScreen();
    }
  }
}

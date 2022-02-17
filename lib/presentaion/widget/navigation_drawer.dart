import 'package:ecommerce/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  Color iconColor = Colors.black;
  Color hoverColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          getMenuItem(text: "Settings", icon: Icons.settings),
          const Divider(),
          getMenuItem(
              text: "Signout",
              icon: Icons.logout,
              onClicked: () {
                context.read<AuthenticationService>().signOut();
              }),
        ],
      ),
    ));
  }

  Widget getMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        text,
        style: const TextStyle(fontFamily: 'OpenSans'),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}

import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hello Friend!"),
            automaticallyImplyLeading: false, // 뒤로 가기 버튼 생성 안함
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed("/");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Welcome User!"),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop_rounded),
            title: const Text("Shop"),
            onTap: () => Navigator.of(context).pushReplacementNamed(
              AppRoutes.home,
            ),
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.payment_rounded),
              title: const Text("Orders"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.orders,
                );
              }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.edit_rounded),
              title: const Text("Manage Products"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRoutes.products,
                );
              }),
        ],
      ),
    );
  }
}

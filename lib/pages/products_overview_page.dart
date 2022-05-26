import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductList>(context, listen: false).loadProducts().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My store"),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert_rounded),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      child: Text("Only favorites"),
                      value: FilterOptions.favorite,
                    ),
                    PopupMenuItem(
                      child: Text("All"),
                      value: FilterOptions.all,
                    ),
                  ],
                  onSelected: (FilterOptions selectValue) {
                    setState(() {
                      if (selectValue == FilterOptions.favorite) {
                        _showFavoriteOnly = true;
                      } else {
                        _showFavoriteOnly = false;
                      }
                    });
                  },
                ),
                Consumer<Cart>(
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.cart);
                    },
                  ),
                  builder: (ctx, cart, child) => Badge(
                    position: BadgePosition.topEnd(top: -15),
                    badgeContent: Text(
                      cart.itemsCount.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductGrid(_showFavoriteOnly),
      drawer: const AppDrawer(),
    );
  }
}

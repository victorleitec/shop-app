import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.productForm,
                  arguments: product,
                );
              },
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.edit_rounded),
            ),
            IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Delete Product"),
                    content: const Text("Are you sure?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                ).then(
                  (value) async {
                    if (value ?? false) {
                      try {
                        await Provider.of<ProductList>(context, listen: false)
                            .removeProduct(product);
                      } on HttpException catch (error) {
                        message.showSnackBar(
                          SnackBar(
                            content: Text(error.toString()),
                          ),
                        );
                      }
                    }
                  },
                );
              },
              color: Theme.of(context).errorColor,
              icon: const Icon(Icons.delete_rounded),
            ),
          ],
        ),
      ),
    );
  }

  final Product product;
}

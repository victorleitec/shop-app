import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/constants.dart';

class Product with ChangeNotifier {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    _toggleFavorite();

    final response = await put(
      Uri.parse("${Constants.userFavoritesUrl}/$userId/$id.json?auth=$token"),
      body: jsonEncode(isFavorite),
    );

    if (response.statusCode >= 400) {
      _toggleFavorite();
      throw HttpException(
        message: "Unable to perform desired function.",
        statusCode: response.statusCode,
      );
    }
  }
}

import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final Map<String, dynamic> _productData = {};

  Map<String, dynamic> get productData => _productData;

  void getFormData({
    String? productName,
    double? productPrice,
    int? quantity,
    String? category,
    String? description,
    DateTime? scheduleDate,
    List<String>? imageUrlList,
    bool? chargeShipping,
    int? shippingCharge,
    String? brandName,
    List<String>? sizeList,
  }) {
    // Validate and assign only if the data is correct
    if (productName != null && productName.isNotEmpty) {
      _productData['productName'] = productName;
    }
    if (productPrice != null && productPrice >= 0) {
      _productData['productPrice'] = productPrice;
    }
    if (quantity != null && quantity >= 0) {
      _productData['quantity'] = quantity;
    }
    if (category != null && category.isNotEmpty) {
      _productData['category'] = category;
    }
    if (description != null && description.isNotEmpty) {
      _productData['description'] = description;
    }
    if (scheduleDate != null) {
      _productData['scheduleDate'] = scheduleDate;
    }
    if (imageUrlList != null && imageUrlList.isNotEmpty) {
      _productData['imageUrlList'] = imageUrlList;
    }
    if (chargeShipping != null) {
      _productData['chargeShipping'] = chargeShipping;
    }
    if (shippingCharge != null && shippingCharge >= 0) {
      _productData['shippingCharge'] = shippingCharge;
    }
    if (brandName != null && brandName.isNotEmpty) {
      _productData['brandName'] = brandName;
    }
    if (sizeList != null && sizeList.isNotEmpty) {
      _productData['sizeList'] = sizeList;
    }

    notifyListeners(); // Notify listeners after updating data
  }

  void clearData() {
    _productData.clear();
    notifyListeners(); // Notify listeners after clearing data
  }
}

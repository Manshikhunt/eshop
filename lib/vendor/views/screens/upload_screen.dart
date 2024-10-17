import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:eshop/vendor/views/screens/main_vendor_screen.dart';
import 'package:eshop/vendor/views/screens/upload_tap_screen/attributes_tab_screen.dart';
import 'package:eshop/vendor/views/screens/upload_tap_screen/general_tab_screen.dart';
import 'package:eshop/vendor/views/screens/upload_tap_screen/images_tab_screen.dart';
import 'package:eshop/vendor/views/screens/upload_tap_screen/shipping_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[200],
            bottom: const TabBar(tabs: [
              Tab(child: Text('General')),
              Tab(child: Text('Shipping')),
              Tab(child: Text('Attributes')),
              Tab(child: Text('Images')),
            ]),
          ),
          body: const TabBarView(
            children: [
              GeneralTabScreen(),
              ShippingTabScreen(),
              AttributesTabScreen(),
              ImagesTabScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.only(left: 8.0, right: 240.0, bottom: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                elevation: 6,
                shadowColor: Colors.black.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green.shade100),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  EasyLoading.show(status: 'Please wait...');
                  final productId = const Uuid().v4();

                  try {
                    // Save product data to Firestore
                    await _firestore.collection('products').doc(productId).set({
                      'productId': productId,
                      'productName': productProvider.productData['productName'],
                      'productPrice': productProvider.productData['productPrice'],
                      'quantity': productProvider.productData['quantity'],
                      'category': productProvider.productData['category'],
                      'description': productProvider.productData['description'],
                      'scheduleDate': productProvider.productData['scheduleDate'],
                      'imageUrlList': productProvider.productData['imageUrlList'],
                      'chargeShipping': productProvider.productData['chargeShipping'],
                      'shippingCharge': productProvider.productData['shippingCharge'],
                      'brandName': productProvider.productData['brandName'],
                      'sizeList': productProvider.productData['sizeList'],
                    });

                    // Clear provider data
                    productProvider.productData.clear();

                    // Reset the form
                    _formKey.currentState!.reset();

                    // Dismiss loading and navigate to MainVendorScreen
                    EasyLoading.dismiss();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainVendorScreen(),
                      ),
                    );
                  } catch (e) {
                    // Handle any errors and dismiss loading
                    EasyLoading.dismiss();
                    EasyLoading.showError('Failed to save product: $e');
                    print('Error saving product: $e');
                  }
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

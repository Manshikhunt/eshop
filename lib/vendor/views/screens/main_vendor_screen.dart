import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'earning_screen.dart';
import 'edit_product_screen.dart';
import 'upload_screen.dart';
import 'vendor_logout_screen.dart';
import 'vendor_order_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const EarningScreen(),
    const VendorOrderScreen(),
    const UploadScreen(),
    const EditProductScreen(),
     VendorLogoutScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        height: 90,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.green[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _onTabSelected(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.money_dollar,
                        size: 26,
                        color: _pageIndex == 0
                            ? Colors.green.shade900
                            : Colors.white,
                      ),
                      Text(
                        'Money',
                        style: TextStyle(
                          fontSize: 16,
                          color: _pageIndex == 0
                              ? Colors.green.shade900
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(flex: 1),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _onTabSelected(2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload,
                        size: 26,
                        color: _pageIndex == 2
                            ? Colors.green.shade900
                            : Colors.white,
                      ),
                      Text(
                        'Upload',
                        style: TextStyle(
                          fontSize: 16,
                          color: _pageIndex == 2
                              ? Colors.green.shade900
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(flex: 2),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _onTabSelected(3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 26,
                        color: _pageIndex == 3
                            ? Colors.green.shade900
                            : Colors.white,
                      ),
                      Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 16,
                          color: _pageIndex == 3
                              ? Colors.green.shade900
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(flex: 1),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _onTabSelected(1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.shopping_cart,
                        size: 26,
                        color: _pageIndex == 1
                            ? Colors.green.shade900
                            : Colors.white,
                      ),
                      Text(
                        'Orders',
                        style: TextStyle(
                          fontSize: 16,
                          color: _pageIndex == 1
                              ? Colors.green.shade900
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            _pageIndex = 4; // Navigate to VendorLogoutScreen
          });
        },
        backgroundColor: Colors.green[200],
        child: const Icon(Icons.logout, color: Colors.white, size: 26),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _pages[_pageIndex], // Display the selected page
    );
  }
}

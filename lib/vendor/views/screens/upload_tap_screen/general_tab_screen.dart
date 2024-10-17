import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralTabScreen extends StatefulWidget {
  const GeneralTabScreen({super.key});

  @override
  State<GeneralTabScreen> createState() => _GeneralTabScreenState();
}

class _GeneralTabScreenState extends State<GeneralTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _categoryList = [];

  _getCategories() async {
    return await _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      }
    });
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  String formatDate(date) {
    final outputDateFormat = DateFormat('dd/MM/yyyy');
    final outputDate = outputDateFormat.format(date);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Product Name';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  productProvider.getFormData(productName: value);
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Product Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isEmpty) {
                    productProvider.getFormData(productPrice: null);
                    return;
                  }

                  // Validate and parse the input as a double
                  try {
                    final double parsedValue = double.parse(value);
                    productProvider.getFormData(productPrice: parsedValue);
                  } catch (e) {
                    // Handle the error (e.g., show a message or clear the field)
                    print('Invalid input for price: $e');
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Product Price',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  try {
                    double.parse(value);
                  } catch (e) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isEmpty) {
                    productProvider.getFormData(quantity: null);
                    return;
                  }

                  // Validate and parse the input as an integer
                  try {
                    final int parsedValue = int.parse(value);
                    productProvider.getFormData(quantity: parsedValue);
                  } catch (e) {
                    // Handle the error (e.g., show a message or clear the field)
                    print('Invalid input for quantity: $e');
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Product Quantity',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Product Quantity';
                  }
                  try {
                    int.parse(value);
                  } catch (e) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                  hint: const Text('Select Category'),
                  items: _categoryList.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (value) {
                    productProvider.getFormData(category: value);
                  }),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Product Description';
                  } else {
                    return null;
                  }
                },
                maxLines: 5,
                maxLength: 800,
                onChanged: (value) {
                  productProvider.getFormData(description: value);
                },
                decoration: InputDecoration(
                  labelText: 'Enter Product Descriptions',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(5000),
                        ).then((value) {
                          productProvider.getFormData(scheduleDate: value);
                        });
                      },
                      child: const Text(
                        'Schedule:',
                      ),
                    ),
                  ),
                  if (productProvider.productData['scheduleDate'] != null)
                    Expanded(
                      child: Text(
                        formatDate(
                          productProvider.productData['scheduleDate'],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
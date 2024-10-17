import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/views/buyers/nav_screens/widgets/home_products.dart';
import 'package:flutter/material.dart';

class CategoryText extends StatefulWidget {
  const CategoryText({super.key});

  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoryStream = FirebaseFirestore.instance.collection('categories').snapshots();
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontSize: 19),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading categories");
              }

              return SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, Index) {
                          final categoryData = snapshot.data!.docs[Index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                            child: ActionChip(
                              backgroundColor:
                                  const Color.fromARGB(255, 191, 222, 192),
                              shape: const StadiumBorder(),
                              side: BorderSide.none,
                              onPressed: () {
                                setState(() {
                                  _selectedCategory = categoryData['categoryName'];
                                  print(_selectedCategory);
                                });
                              },
                              label: Text(
                                categoryData['categoryName'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios))
                  ],
                ),
              );
            },
          ),
          if(_selectedCategory != null)
          HomeProductswidget(categoryName: _selectedCategory),
        ],
      ),
    );
  }
}

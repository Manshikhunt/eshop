import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, this.productData});

  final dynamic productData;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _imageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          widget.productData['productName'],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: PhotoView(
                  imageProvider: NetworkImage(
                    widget.productData['imageUrlList'][_imageindex],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productData['imageUrlList'].length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _imageindex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green.shade900,
                              ),
                            ),
                            height: 60,
                            width: 60,
                            child: Image.network(
                                widget.productData['imageUrlList'][index]),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              '₹' + ' ' + widget.productData['productPrice'].toStringAsFixed(2),
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ),
          Text(
            widget.productData['productName'],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          ExpansionTile(title: Row(
            children: [
              Text('Product Discription', style: TextStyle(color: Colors.green.shade900,),),
            ],
          ),),
        ],
      ),
    );
  }
}

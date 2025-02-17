import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List _bannerImages = [];

  getbanner() {
    return _firestore
        .collection('banners')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _bannerImages.add(doc['image']);
        });
      }
    });
  }

  @override
  void initState() {
    getbanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.green[200], borderRadius: BorderRadius.circular(10)),
        child: PageView.builder(
          itemCount: _bannerImages.length,
          itemBuilder: (context, Index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: _bannerImages[Index],
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer(
                  duration: const Duration(seconds: 3), //Default value
                  interval: const Duration(
                      seconds: 5), //Default value: Duration(seconds: 0)
                  color: Colors.white, //Default value
                  colorOpacity: 0, //Default value
                  enabled: true, //Default value
                  direction: const ShimmerDirection.fromLTRB(), //Default Value
                  child: Container(
                    color: Colors.green[200],
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            );
          },
        ),
      ),
    );
  }
}

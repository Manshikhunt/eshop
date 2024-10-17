import 'dart:io';

import 'package:eshop/provider/product_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImagesTabScreen extends StatefulWidget {
  const ImagesTabScreen({super.key});

  @override
  State<ImagesTabScreen> createState() => _ImagesTabScreenState();
}

class _ImagesTabScreenState extends State<ImagesTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ImagePicker picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final List<File> _image = [];
  final List<String> _imageUrlList = [];

  chooseImage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile == null) {
      print('No Image Selected');
    } else {
      setState(() {
        _image.add(File(PickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: _image.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                childAspectRatio: 3 / 3,
              ),
              itemBuilder: (context, index) {
                return index == 0
                    ? Center(
                        child: Container(
                          height: 110,
                          width: 85,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              chooseImage();
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_image[index - 1]),
                          ),
                        ),
                      );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            _image.isNotEmpty
                ? ElevatedButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'Saving Image');
                      for (var img in _image) {
                        Reference ref = _storage
                            .ref()
                            .child('productImage')
                            .child(const Uuid().v4());

                        await ref.putFile(img).whenComplete(() async {
                          await ref.getDownloadURL().then((value) {
                            setState(() {
                              _imageUrlList.add(value);
                            });
                          });
                        });
                      }
                      setState(() {
                        productProvider.getFormData(
                            imageUrlList: _imageUrlList);

                        EasyLoading.dismiss();
                      });
                    },
                    child: Text(
                      'Upload',
                      style: TextStyle(color: Colors.green.shade900),
                    ),
                  )
                : const Text(''),
          ],
        ),
      ),
    );
  }
}

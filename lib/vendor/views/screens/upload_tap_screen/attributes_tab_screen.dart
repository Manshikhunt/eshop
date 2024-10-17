import 'package:eshop/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttributesTabScreen extends StatefulWidget {
  const AttributesTabScreen({super.key});

  @override
  State<AttributesTabScreen> createState() => _AttributesTabScreenState();
}

class _AttributesTabScreenState extends State<AttributesTabScreen> 
  with AutomaticKeepAliveClientMixin {

    @override
    bool get wantKeepAlive => true;

  final TextEditingController _sizecontroller = TextEditingController();
  bool _entered = false;
  final List<String> _sizeList = [];
  bool _isSave = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Enter Brand Nmae';
                    }else{
                      return null;
                    }
                  },
              onChanged: (value) {
                setState(() {
                  productProvider.getFormData(brandName: value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Brand',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 100,
                    child: TextFormField(
                      
                      controller: _sizecontroller,
                      onChanged: (value) {
                        setState(() {
                          _entered = true;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Size',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                _entered == true
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        onPressed: () {
                          setState(() {
                            _sizeList.add(_sizecontroller.text);
                            _sizecontroller.clear();
                          });
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : const Text(''),
              ],
            ),
            if (_sizeList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _sizeList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _sizeList.removeAt(index);
                              productProvider.getFormData(sizeList: _sizeList);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _sizeList[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            if (_sizeList.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  productProvider.getFormData(sizeList: _sizeList);

                  setState(() {
                    _isSave = true;
                  });
                },
                child: Text(
                  _isSave ? 'Saved' : 'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

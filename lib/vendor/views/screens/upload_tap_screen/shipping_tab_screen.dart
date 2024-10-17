// import 'package:eshop/provider/product_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ShippingTabScreen extends StatefulWidget {
//   const ShippingTabScreen({super.key});

//   @override
//   State<ShippingTabScreen> createState() => _ShippingTabScreenState();
// }

// class _ShippingTabScreenState extends State<ShippingTabScreen> 
//   with AutomaticKeepAliveClientMixin {

//     @override
//     bool get wantKeepAlive => true;

//   bool? _chargeShipping = false;

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final ProductProvider productProvider =
//         Provider.of<ProductProvider>(context);
//     return Column(
//       children: [
//         CheckboxListTile(
//           title: const Text(
//             'Charge Shipping',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           value: _chargeShipping,
//           onChanged: (value) {
//             setState(() {
//               _chargeShipping = value;
//               productProvider.getFormData(chargeShipping: _chargeShipping);
//             });
//           },
//         ),
//         if (_chargeShipping == true)
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: TextFormField(
//               validator: (value) {
//                     if(value == null || value.isEmpty){
//                       return 'Enter Shipping Charge';
//                     }else{
//                       return null;
//                     }
//                   },
//               onChanged: (value) {
//                 setState(() {
//                   productProvider.getFormData(
//                     shippingCharge: int.parse(value),
//                   );
//                 });
//               },
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: 'Shipping Charge',
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

import 'package:eshop/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingTabScreen extends StatefulWidget {
  const ShippingTabScreen({super.key});

  @override
  State<ShippingTabScreen> createState() => _ShippingTabScreenState();
}

class _ShippingTabScreenState extends State<ShippingTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool? _chargeShipping = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: const Text(
                'Charge Shipping',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: _chargeShipping,
              onChanged: (value) {
                setState(() {
                  _chargeShipping = value;
                  productProvider.getFormData(chargeShipping: _chargeShipping);
                });
              },
            ),
            if (_chargeShipping == true)
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Shipping Charge';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    // Validate and parse the input as an integer
                    try {
                      final int parsedValue = int.parse(value);
                      productProvider.getFormData(shippingCharge: parsedValue);
                    } catch (e) {
                      // Handle the error (e.g., show a message or clear the field)
                      print('Invalid input for shipping charge: $e');
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Shipping Charge',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

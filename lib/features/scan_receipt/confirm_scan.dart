import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_my_food/common/input.dart';
import 'package:save_my_food/features/food_inventory/saved_products.dart';
import 'package:save_my_food/features/food_inventory/product.dart';
import 'package:save_my_food/features/food_inventory/product_list.dart';

class ConfirmScanPage extends StatefulWidget {
  final List<Product> scannedProducts;
  final Function() onInventory;

  static const route = '/confirm_scan';

  const ConfirmScanPage({
    Key? key,
    required this.scannedProducts,
    required this.onInventory,
  }) : super(key: key);

  @override
  State<ConfirmScanPage> createState() => _ConfirmScanPageState();
}

class _ConfirmScanPageState extends State<ConfirmScanPage> {
  late final List<Product> _products;

  @override
  void initState() {
    super.initState();
    _products = widget.scannedProducts;
  }

  @override
  Widget build(BuildContext context) {
    return ProductListPage(
      title: 'Confirm Products',
      products: _products,
      onRemove: (product) => setState(() => _products.remove(product)),
      floatingButton: MainFloatingButton(
        text: 'Confirm',
        onPressed: () {
          context.read<SavedProducts>().all.addAll(_products);
          widget.onInventory();
          Navigator.pop(context);
        },
      ),
      onEdit: (product, newProduct) {
        for (int i = 0; i < _products.length; i++) {
          if (_products[i].id == product.id) {
            setState(() => _products[i] = newProduct);
          }
        }
      },
    );
  }
}

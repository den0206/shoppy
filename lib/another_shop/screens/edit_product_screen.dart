import 'package:flutter/material.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/Extension/validator.dart';
import 'package:shoppy/another_shop/model/item_size.dart';
import 'package:shoppy/another_shop/screens/components/images_form.dart';
import 'package:shoppy/model/product.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen({Key key, this.product}) : super(key: key);

  static const routeName = '/EdeitProductScreen';
  final _formKey = GlobalKey<FormState>(debugLabel: '_EditProductState');
  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    product.images = [];
    product.sizes = [
      ItemSize(
        title: "S",
        price: 100,
        stock: 3,
      ),
      ItemSize(
        title: "M",
        price: 200,
        stock: 3,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ImagesForm(
              product: product,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: product.title,
                    decoration: InputDecoration(
                      hintText: "Title",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    validator: validProductName,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "Price",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    'R\$ ...',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: "Description",
                      border: InputBorder.none,
                    ),
                    validator: validProductDescription,
                  ),
                  SizeForm(
                    product: product,
                  ),
                  CustomButton(
                    title: "Save",
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print("Save");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SizeForm extends StatelessWidget {
  const SizeForm({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: List.from(product.sizes),
      builder: (state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CircleiconButton(
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: () {
                    state.value.add(ItemSize());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value.map((size) {
                return EditItemSize(
                  key: ObjectKey(size),
                  size: size,
                  onRemove: () {
                    state.value.remove(size);
                    state.didChange(state.value);
                  },
                  onMoveUp: size != state.value.first
                      ? () {
                          final index = state.value.indexOf(size);
                          state.value.remove(size);
                          state.value.insert(index - 1, size);
                          state.didChange(state.value);
                        }
                      : null,
                  onMovedown: size != state.value.last
                      ? () {
                          final index = state.value.indexOf(size);
                          state.value.remove(size);
                          state.value.insert(index + 1, size);
                          state.didChange(state.value);
                        }
                      : null,
                );
              }).toList(),
            ),
            if (state.hasError)
              Container(
                margin: EdgeInsets.only(top: 16, left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class EditItemSize extends StatelessWidget {
  const EditItemSize(
      {Key key, this.size, this.onRemove, this.onMoveUp, this.onMovedown})
      : super(key: key);

  final ItemSize size;
  final Function() onRemove;
  final Function() onMoveUp;
  final Function() onMovedown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.title,
            decoration: InputDecoration(
              hintText: "Size",
              isDense: true,
            ),
            validator: (name) {
              if (name.isEmpty) return "is Empty";
              return null;
            },
            onChanged: (title) => size.title = title,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Stock",
              isDense: true,
            ),
            validator: (stock) {
              if (int.tryParse(stock) == null) return "is Empty";
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: "price",
              isDense: true,
              prefixText: 'R\$',
            ),
            validator: (price) {
              if (num.tryParse(price) == null) return "is Empty";
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CircleiconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CircleiconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CircleiconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMovedown,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/Extension/global_function.dart';
import 'package:shoppy/Extension/validator.dart';
import 'package:shoppy/another_shop/model/adress.dart';
import 'package:shoppy/another_shop/provider/cart_manager.dart';
import 'package:shoppy/another_shop/screens/cart_screen.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key key}) : super(key: key);

  static const routeName = '/AdressScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AddressCard(),
          Consumer<CartManager>(
            builder: (_, model, __) {
              return PriceCard(
                buttonTitle: "Continue",
                onTap: model.isAddressValid
                    ? () {
                        print("Call");
                      }
                    : null,
              );
            },
          )
        ],
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Consumer<CartManager>(builder: (_, model, __) {
          final adress = model.address;
          print(adress);
          return Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Adress",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                CepInputField(),
                if (adress != null)
                  AddressInputFiled(
                    address: adress,
                  )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CepInputField extends StatelessWidget {
  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: cepController,
          enabled: !cartManager.isLoading,
          decoration: InputDecoration(
            isDense: true,
            labelText: "Add",
            hintText: "12,345-678",
          ),
          inputFormatters: numberFormatter,
          keyboardType: TextInputType.number,
          validator: validCepAddress,
        ),
        if (cartManager.isLoading)
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
            backgroundColor: Colors.transparent,
          ),
        Row(
          children: [
            CustomButton(
              title: "Register Add",
              onPressed: !cartManager.isLoading
                  ? () async {
                      if (Form.of(context).validate()) {
                        try {
                          await cartManager.getAddress(cepController.text);
                        } catch (e) {
                          showErrorAlert(context, e);
                        }
                      }
                    }
                  : null,
            ),
            CustomButton(
              title: "Remove Add",
              backColor: Colors.red,
              onPressed: () {
                cartManager.removeAddress();
              },
            ),
          ],
        )
      ],
    );
  }
}

class AddressInputFiled extends StatelessWidget {
  const AddressInputFiled({
    Key key,
    this.address,
  }) : super(key: key);
  final Address address;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _AddressField(
                initialValue: address.capital,
                labelText: "Capital",
                hintText: "Tokyo",
                onSaved: (value) => address.capital = value,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: _AddressField(
                initialValue: address.city,
                labelText: "city",
                hintText: "Shibuya",
                onSaved: (value) => address.city = value,
              ),
            ),
          ],
        ),
        _AddressField(
          initialValue: address.street,
          labelText: "Street",
          hintText: "",
          onSaved: (value) => address.street = value,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: address.number,
                enabled: !cartManager.isLoading,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: "Number",
                  hintText: "123",
                ),
                inputFormatters: numberFormatter,
                keyboardType: TextInputType.number,
                validator: validEmpty,
                onSaved: (number) => address.number = number,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: _AddressField(
                initialValue: address.complement,
                labelText: "Complement",
                hintText: "optional",
                onSaved: (value) => address.complement = value,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        if (cartManager.isLoading)
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
            backgroundColor: Colors.transparent,
          ),
        CustomButton(
          title: "Caluculate Fee",
          onPressed: !cartManager.isLoading
              ? () async {
                  if (Form.of(context).validate()) {
                    Form.of(context).save();

                    try {
                      await context.read<CartManager>().setAddress(address);
                    } catch (e) {
                      showErrorAlert(context, e);
                    }
                  }
                }
              : null,
        )
      ],
    );
  }
}

class _AddressField extends StatelessWidget {
  const _AddressField({
    Key key,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.onSaved,
  }) : super(key: key);

  final String initialValue;
  final String labelText;
  final String hintText;
  final ValueChanged<String> onSaved;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();

    return TextFormField(
      initialValue: initialValue,
      enabled: !cartManager.isLoading,
      decoration: InputDecoration(
        isDense: true,
        labelText: "capital",
        hintText: "Tokyo",
      ),
      validator: validEmpty,
      onSaved: onSaved,
    );
  }
}

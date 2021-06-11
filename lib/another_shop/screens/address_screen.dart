import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppy/Extension/CostomWidgets.dart';
import 'package:shoppy/Extension/validator.dart';

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
        children: [AddressCard()],
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
          ],
        ),
      ),
    );
  }
}

class CepInputField extends StatelessWidget {
  const CepInputField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: InputDecoration(
            isDense: true,
            labelText: "Add",
            hintText: "12,345-678",
          ),
          inputFormatters: numberFormatter,
          keyboardType: TextInputType.number,
        ),
        CustomButton(
          title: "Register Add",
          onPressed: () {},
        )
      ],
    );
  }
}

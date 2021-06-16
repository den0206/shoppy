import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shoppy/another_shop/model/adress.dart';
import 'package:shoppy/another_shop/model/order.dart';

class CancelOrderDialog extends StatelessWidget {
  const CancelOrderDialog({Key key, this.order}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Ccancel ${order.formatterId}",
      ),
      content: Text("Cancel This Order?"),
      actions: [
        TextButton(
          child: Text(
            "Cancel Order",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            order.cancel();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class ExportAddressDialog extends StatelessWidget {
  ExportAddressDialog({Key key, this.address}) : super(key: key);

  final ScreenshotController screenshotController = ScreenshotController();

  final Address address;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Your Address"),
      content: Screenshot(
        controller: screenshotController,
        child:
            Text('${address.street}, ${address.number} ${address.complement}\n'
                '${address.city}/\n'),
      ),
      contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      actions: [
        TextButton(
          child: Text("Export Address"),
          onPressed: () async {
            Navigator.of(context).pop();
            final file = await screenshotController.capture();
            await GallerySaver.saveImage(file.toString());
          },
        )
      ],
    );
  }
}

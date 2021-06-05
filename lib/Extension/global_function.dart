import 'package:flutter/material.dart';

dismissKeybourd(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

void navigateTo(BuildContext ctx, String routeName) {
  Navigator.of(ctx).pushNamed(
    routeName,
  );
}

Future showAlert(
  BuildContext context,
  String title,
  String subtitle,
  Function() ontap,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Image.network(
                'https://image.flaticon.com/icons/png/128/564/564619.png',
                height: 20,
                width: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title),
            ),
          ],
        ),
        content: Text(subtitle),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
              onPressed: () {
                ontap();
                Navigator.pop(context);
              },
              child: Text('ok'))
        ],
      );
    },
  );
}

Future showErrorAlert(BuildContext context, dynamic error) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: Image.network(
                'https://image.flaticon.com/icons/png/128/564/564619.png',
                height: 20,
                width: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Error"),
            ),
          ],
        ),
        content: Text(error.message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          )
        ],
      );
    },
  );
}

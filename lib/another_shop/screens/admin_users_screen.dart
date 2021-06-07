import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/another_shop/common/custom_drawer.dart';
import 'package:shoppy/another_shop/provider/admin_user_manager.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      drawer: CustomDrawer(),
      body: Consumer<AdminUserManager>(
        builder: (context, model, child) {
          return AlphabetListScrollView(
            highlightTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            indexedHeight: (index) => 80,
            strList: model.names,
            showPreview: true,
            itemBuilder: (context, index) {
              final adminUser = model.users[index];
              return ListTile(
                title: Text(
                  adminUser.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  adminUser.email,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

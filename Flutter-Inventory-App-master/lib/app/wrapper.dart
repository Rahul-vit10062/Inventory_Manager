import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Stock_Manager/app/authenticate/authenticate.dart';
import 'package:Stock_Manager/app/itemlist.dart';
import 'package:Stock_Manager/app/settings.dart';
import 'package:Stock_Manager/services/crud.dart';
import 'package:Stock_Manager/models/user.dart';
import 'package:Stock_Manager/utils/cache.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize the cache for app
    final user = Provider.of<UserData>(context);

    final StartupCache startupCache =
        StartupCache(userData: user, reload: true);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      _initializeCache(startupCache);
      _checkForTargetPermission(user);
      return ItemList();
    }
  }

  void _initializeCache(startupCache) async {
    await startupCache.itemMap;
  }

  void _checkForTargetPermission(UserData userData) async {
    bool permitted = await SettingState.validateTargetEmail(userData);
    if (!permitted) {
      userData.targetEmail = userData.email;
      await CrudHelper().updateUserData(userData);
    }
  }
}

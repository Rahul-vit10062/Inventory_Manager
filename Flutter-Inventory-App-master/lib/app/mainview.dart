import 'package:Stock_Manager/app/authenticate/authenticate.dart';
import 'package:Stock_Manager/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Stock_Manager/app/wrapper.dart';
import 'package:Stock_Manager/app/forms/salesEntryForm.dart';
import 'package:Stock_Manager/app/itemlist.dart';
import 'package:Stock_Manager/app/transactions/transactionList.dart';
import 'package:Stock_Manager/app/settings.dart';
import 'package:Stock_Manager/services/auth.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bookkeeping app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ), // ThemeData
        routes: <String, WidgetBuilder>{
          "/mainForm": (BuildContext context) =>
              SalesEntryForm(title: "Sales Entry"),
          "/itemList": (BuildContext context) => ItemList(),
          "/transactionList": (BuildContext context) => TransactionList(),
          "/settings": (BuildContext context) => Setting(),
        },
        home: Wrapper(),
      ),
    );
  }
}

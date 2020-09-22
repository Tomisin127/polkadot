import 'package:flutter/material.dart';
import 'package:polkadot_app/models/user.dart';
import 'package:polkadot_app/screens/authenticate/authenticate.dart';
import 'package:polkadot_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either home or authenticate widget
    return user != null ? Home() : Authenticate();
    //return Authenticate();
  }
}

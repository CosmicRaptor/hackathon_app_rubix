import 'package:flutter/material.dart';

import '../util/globals.dart';
import '../widgets/drawer.dart';
import 'ar_screen.dart';

class ARListScreen extends StatelessWidget {
  const ARListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AR List')),
      drawer: DrawerWidget(),
      body: ListView.builder(
        itemCount: Globals.models.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(Globals.models[index]),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ARScreen(modelToLoad: Globals.models[index])));
            },
          );
        },
      )
    );
  }
}

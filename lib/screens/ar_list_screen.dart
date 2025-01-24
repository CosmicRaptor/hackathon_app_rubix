import 'package:flutter/material.dart';
import 'package:hackathon_app_rubix/widgets/ar_card.dart';

import '../util/globals.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/drawer.dart';

class ARListScreen extends StatelessWidget {
  const ARListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          title: Text('AR List'),
        ),
        drawer: DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: Globals.models.length,
            itemBuilder: (context, index) {
              return ArCard(
                arSite: Globals.models[index],
              );
            },
          ),
        ));
  }
}

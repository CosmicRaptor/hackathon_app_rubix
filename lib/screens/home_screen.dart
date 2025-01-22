import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/widgets/level_marker.dart';

import '../providers/user_provider.dart';
import 'login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      //yellow-brown old paper color
      backgroundColor: const Color(0xFFE0CDA1),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index){
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      width: 100,
                        height: 200,
                        child: LevelMarker(level: index, era: ['ancient', 'medieval', 'modern'][index % 3],),),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(authNotifierProvider.notifier).signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),),);
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}

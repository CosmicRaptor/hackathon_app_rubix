import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/screens/quiz_levels_list_screen.dart';
import 'package:hackathon_app_rubix/screens/riddles_screen.dart';

import '../providers/user_provider.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Color(0xFFFBEEC1),
      child: Column(
        children: [
          const SizedBox(height: 50,),
          //TODO: Put user pfp here
          FlutterLogo(size: 100),
          const SizedBox(height: 20,),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
          ListTile(
              title: const Text('Profile'),
              onTap: () {}
          ),
          ListTile(
              title: const Text('Quiz'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizLevelsListScreen(),
                  ),
                );
              }
          ),
          ListTile(
            title: const Text('Riddles'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RiddlesScreen(),
                ),
              );
            },
          ),
          ListTile(
              title: const Text('Leaderboard'),
              onTap: () {}
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                // Sign Out Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(authNotifierProvider.notifier).signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

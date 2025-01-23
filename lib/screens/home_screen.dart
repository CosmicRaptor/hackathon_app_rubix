import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/providers/post_provider.dart';
import 'package:hackathon_app_rubix/widgets/drawer.dart';
import 'package:hackathon_app_rubix/widgets/post_card.dart';

import '../providers/leaderboard_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_scaffold.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Welcome back!'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        // backgroundColor: Colors.brown,
      ),
      drawer: DrawerWidget(),
      // Subtle gradient background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // AppBar-style header
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              //   color: Color(0xFFE0CDA1),
              //   child: Text(
              //     'Welcome Back!',
              //     style: TextStyle(
              //       fontSize: 28,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.brown.shade700,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              const SizedBox(height: 20),
          
              // Streak and Rank Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCard(
                      title: 'Daily Streak',
                      value: '0',
                      color: Colors.orange.shade100,
                    ),
                    FutureBuilder<int>(
                      future: ref
                          .read(leaderboardServiceProvider)
                          .getRank(ref.read(userProvider.notifier).state!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                              color: Colors.blue);
                        }
                        return _buildCard(
                          title: 'Your Rank',
                          value: snapshot.data.toString(),
                          color: Colors.blue.shade100,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
          
              // Fact of the Day Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  color: Colors.brown.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Today in history',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                // color: Colors.brown,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 175,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/California_Clipper_500.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'James W. Marshall discovered gold at Sutter\'s Mill in Coloma, California, triggering the California Gold Rush. This discovery attracted hundreds of thousands of people to California in search of wealth.',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            // Action for "Read More"
                          },
                          child: const Text(
                            'Read More...',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Today\'s top post', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              ref.watch(PostListProvider).when(
                data: (posts) {
                  return PostCard(post: posts[0]);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Text('Error: $error'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      {required String title, required String value, required Color color}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      color: color,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final AppBar appBar;
  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  const CustomScaffold({
    super.key,
    required this.appBar,
    required this.body,
    this.drawer,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: appBar.preferredSize,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/vintage3.png'),
              repeat:
                  ImageRepeat.repeat, // Repeats the texture across the AppBar
            ),
          ),
          child: appBar, // Embeds the original AppBar
        ),
      ),
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/vintage2.png'),
            repeat: ImageRepeat.repeat, // Repeats the texture in the body
          ),
        ),
        child: body, // Main content
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hackathon_app_rubix/screens/ar_screen.dart';
import 'package:hackathon_app_rubix/util/get_ar_sites_info.dart';

class ArCard extends StatelessWidget {
  final String arSite;
  const ArCard({super.key, required this.arSite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ARScreen(
                  modelToLoad: arSite,
                )));
      },
      child: Card(
        color: Colors.brown.shade300,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/ar_card_desc_images/$arSite.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                arSite.toUpperCase().replaceAll('_', ' '),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getArSitesInfo(arSite),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

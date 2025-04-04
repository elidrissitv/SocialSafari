import 'package:flutter/material.dart';
import '../widgets/accueil widgets/header.dart';
import '../widgets/accueil widgets/search_bar.dart';
import '../widgets/accueil widgets/category_list.dart';
import '../widgets/accueil widgets/popular_places.dart';
import '../widgets/accueil widgets/special_offer_banner.dart';
import '../widgets/accueil widgets/special_offers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomSearchBar(),
                    const CategoryList(),
                    const PopularPlaces(),
                    const SpecialOfferBanner(),
                    const SpecialOffers(),
                    // Bottom padding to avoid content being hidden by navigation bar
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
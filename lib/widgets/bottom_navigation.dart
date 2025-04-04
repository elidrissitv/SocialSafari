import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFF1F1F1),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        items: [
          _buildNavItem(Icons.home_outlined, 'Accueil'),
          _buildNavItem(Icons.explore_outlined, 'Découverte'),
          _buildNavItem(Icons.calendar_today_outlined, 'Réservation'),
          _buildNavItem(Icons.compare_arrows_outlined, 'Comparateur'),
          _buildNavItem(Icons.group_outlined, 'Communauté'),
          _buildNavItem(Icons.person_outline, 'Profil'),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: const Color(0xFF6D56FF),
        unselectedItemColor: const Color(0xFFA09CAB),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        iconSize: 20,
        backgroundColor: Colors.white,
        selectedLabelStyle: const TextStyle(height: 1.4),
        unselectedLabelStyle: const TextStyle(height: 1.4),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
      backgroundColor: Colors.white,
    );
  }
}

import 'package:flutter/material.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Rechercher dans l\'historique',
              prefixIcon: Icon(Icons.search, color: Color(0xFF9CA3AF)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              filled: true,
              fillColor: Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('Tout', true),
                SizedBox(width: 8),
                _buildFilterChip('Réservations', false),
                SizedBox(width: 8),
                _buildFilterChip('Consultations', false),
                SizedBox(width: 8),
                _buildFilterChip('Fav', false),
              ],
            ),
          ),
          SizedBox(height: 16),
          _buildHistoryItem(
            image:
                'https://cdn.builder.io/api/v1/image/assets/TEMP/59bcc54c19e789e130e1c629e13883fe4bb82e82',
            title: 'Le Petit Bistrot',
            subtitle: 'Réservation pour 2 personnes',
            date: '15 février 2024 - 20:00',
            hasReservation: true,
          ),
          _buildHistoryItem(
            image:
                'https://cdn.builder.io/api/v1/image/assets/TEMP/d1ca5e7d711a292d7a5580df4db8a8786e79bca0',
            title: 'Café de la Place',
            subtitle: 'Consultation du menu',
            date: '14 février 2024 - 15:30',
            hasReservation: false,
          ),
          _buildHistoryItem(
            image:
                'https://cdn.builder.io/api/v1/image/assets/TEMP/86e760f31fda0df9879521d15bc2a2b710ed12b4',
            title: 'Le Vin Rouge',
            subtitle: 'Réservation pour 4 personnes',
            date: '12 février 2024 - 19:30',
            hasReservation: true,
          ),
          _buildHistoryItem(
            image:
                'https://cdn.builder.io/api/v1/image/assets/TEMP/9781ace062553aa13ab48b15bae5d37b5daaf445',
            title: 'Hôtel Saint-Germain',
            subtitle: 'Consultation des chambres',
            date: '10 février 2024 - 11:15',
            hasReservation: false,
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFFEF4444),
              minimumSize: Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Effacer tout l\'historique',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF6D56FF) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Color(0xFF6D56FF) : Color(0xFFE5E7EB),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Color(0xFF6B7280),
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildHistoryItem({
    required String image,
    required String title,
    required String subtitle,
    required String date,
    required bool hasReservation,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (hasReservation)
                      Icon(Icons.calendar_today,
                          size: 20, color: Color(0xFF6D56FF))
                    else
                      Icon(Icons.remove_red_eye,
                          size: 20, color: Color(0xFF9CA3AF)),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

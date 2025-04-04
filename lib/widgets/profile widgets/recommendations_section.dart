import 'package:flutter/material.dart';

class RecommendationsSection extends StatelessWidget {
  const RecommendationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                'https://cdn.builder.io/api/v1/image/assets/TEMP/cf4e3caa3a34243c809bd58cc7cf06e12c5007a2',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF6D56FF),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Populaire',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Loft Design Paris - 2500Mad/nuit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Tous', true),
                  SizedBox(width: 12),
                  _buildFilterChip('Restaurants', false),
                  SizedBox(width: 12),
                  _buildFilterChip('Hôtels', false),
                  SizedBox(width: 12),
                  _buildFilterChip('Bars', false),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.7,
              children: [
                _buildRecommendationCard(
                  image:
                      'https://cdn.builder.io/api/v1/image/assets/TEMP/a5b9da510ac230a8034f2a57f5ac776e3c300ecc',
                  title: 'Le Petit Bistrot - 450Mad/pers',
                  subtitle: 'Restaurant traditionnel',
                  relevance: '98% pertinent',
                ),
                _buildRecommendationCard(
                  image:
                      'https://cdn.builder.io/api/v1/image/assets/TEMP/9781ace062553aa13ab48b15bae5d37b5daaf445',
                  title: 'Hôtel du Palais - 3800Mad/nuit',
                  subtitle: '5 étoiles - Vue mer',
                  relevance: '95% pertinent',
                ),
                _buildRecommendationCard(
                  image:
                      'https://cdn.builder.io/api/v1/image/assets/TEMP/fb8ff07e29ecd8fbcaa4ccf1f1ffb27e0a03c275',
                  title: 'Le Bar Secret - 150Mad/cocktail',
                  subtitle: 'Cocktails & Ambiance',
                  relevance: '92% pertinent',
                ),
                _buildRecommendationCard(
                  image:
                      'https://cdn.builder.io/api/v1/image/assets/TEMP/30bc30a9342538a35e35f8c5920f022a849b58e6',
                  title: 'Parc Aventure - 350Mad/pers',
                  subtitle: 'Activités en plein air',
                  relevance: '90% pertinent',
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Color(0xFF6D56FF) : Color(0xFFE5E7EB),
        ),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Color(0xFF6D56FF) : Colors.white,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildRecommendationCard({
    required String image,
    required String title,
    required String subtitle,
    required String relevance,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8),
            ),
            child: Image.network(
              image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF6D56FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    relevance,
                    style: TextStyle(
                      color: Color(0xFF6D56FF),
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
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

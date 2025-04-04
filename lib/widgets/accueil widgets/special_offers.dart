import 'package:flutter/material.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Offres spéciales',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF11181C),
                ),
              ),
              SizedBox(
                width: 14,
                height: 15,
                child: CustomPaint(
                  painter: BellIconPainter(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Offers List Section
          SizedBox(
            height: 220, // Increased height for better alignment
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                return InkWell(
                  onTap: () {
                    // Handle tap action here
                    // For example, navigate to a details page:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OfferDetailsPage(offer: offer),
                      ),
                    );
                  },
                  child: OfferCard(offer: offer),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class OfferDetailsPage extends StatelessWidget {
  final Map<String, String> offer;

  const OfferDetailsPage({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offer['title']!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                offer['image']!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                offer['title']!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Prix: ${offer['price']}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Durée: ${offer['duration']}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Note: ${offer['rating']} ★',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Extracted Offer Card Widget for Reusability
class OfferCard extends StatelessWidget {
  final Map<String, String> offer;

  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section with Overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  offer['image']!,
                  width: 180,
                  height: 100, // Reduced height to prevent overflow
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[500],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    'Vérifié',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${offer['rating']} ★',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Details Section
          Padding(
            padding: const EdgeInsets.all(8), // Reduced padding slightly
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  offer['originalPrice']!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      offer['price']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6D56FF),
                      ),
                    ),
                    const Text(
                      ' par nuit',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF6D56FF),
                      ),
                    ),
                  ],
                ),
                Text(
                  offer['duration']!,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
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
// Custom Painter for Bell Icon
class BellIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFFCED0F8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    path.moveTo(9.65, 6.27418);
    path.lineTo(9.65, 4.96966);
    path.cubicTo(9.65, 3.28857, 8.2397, 1.92578, 6.5, 1.92578);
    path.cubicTo(4.7603, 1.92578, 3.35, 3.28857, 3.35, 4.96966);
    path.lineTo(3.35, 6.27418);
    path.cubicTo(3.35, 7.70915, 2, 8.05702, 2, 8.88321);
    path.cubicTo(2, 9.62244, 3.755, 10.1877, 6.5, 10.1877);
    path.cubicTo(9.245, 10.1877, 11, 9.62244, 11, 8.88321);
    path.cubicTo(11, 8.05702, 9.65, 7.70915, 9.65, 6.27418);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Sample Data
final List<Map<String, String>> offers = [
  {
    'image': 'https://cdn.builder.io/api/v1/image/assets/TEMP/4184f41b46177ac1923d391c7cc95994a39bc0f6',
    'title': 'L\'étoile des Cévennes, France',
    'originalPrice': '2500MAD',
    'price': '2000MAD ',
    'duration': '6 jours',
    'rating': '4.8',
  },
  {
    'image': 'https://cdn.builder.io/api/v1/image/assets/TEMP/232b88eba8a0efbd6f060b1ed4304a5e516ca0ae',
    'title': 'Évasion insolite à Marrakech à prix DINGUE, Maroc',
    'originalPrice': '2000MAD',
    'price': '1850MAD ',
    'duration': '4 jours',
    'rating': '5',
  },
];
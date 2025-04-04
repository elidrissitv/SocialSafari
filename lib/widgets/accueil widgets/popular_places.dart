import 'package:flutter/material.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Lieux populaires & tendances',
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
          SizedBox(
            height: 120, // Increased height slightly
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];
                return Container(
                  width: 135,
                  margin: const EdgeInsets.only(right: 10),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          place['image']!,
                          width: 135,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(102, 98, 98, 0.61),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place['title']!,
                                style: const TextStyle(
                                  fontSize: 10, // Increased font size
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                place['location']!,
                                style: const TextStyle(
                                  fontSize: 8, // Increased font size
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                place['description']!,
                                style: const TextStyle(
                                  fontSize: 10, // Increased font size
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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

final List<Map<String, String>> places = [
  {
    'image': 'https://cdn.builder.io/api/v1/image/assets/TEMP/9b579a8c72b3e2a3fc25c6b909d91c275bf7834b',
    'title': 'Paris Getaway',
    'location': 'Paris, France',
    'description': 'Réduction spéciale disponible',
  },
  {
    'image': 'https://cdn.builder.io/api/v1/image/assets/TEMP/cb8ae7761808864d7245344b6a9b3fbdbcb65b9b',
    'title': 'Santorini',
    'location': 'Santorini, Greece',
    'description': 'Réduction spéciale disponible',
  },
  {
    'image': 'https://cdn.builder.io/api/v1/image/assets/TEMP/b2de6981bd471ae4d15fcb9cd4583485c28555b2',
    'title': 'Tokyo',
    'location': 'Japon',
    'description': 'Découvrir Tokyo en nuit',
  },
];

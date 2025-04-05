import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  String _optimizedImageUrl(String url) {
    if (url.contains('unsplash.com') || url.contains('builder.io')) {
      return '$url?auto=compress&w=100&q=80';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 21),
      height: 80, // Increased height to accommodate content
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories
              .map((category) => CategoryItem(
                    icon: category['icon']!,
                    name: category['name']!,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String icon;
  final String name;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.name,
  });

  String get _optimizedImageUrl {
    if (icon.contains('unsplash.com') || icon.contains('builder.io')) {
      return '$icon?auto=compress&w=100&q=80';
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16), // Adjust spacing between items
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(99, 74, 255, 0.10),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: _optimizedImageUrl,
                width: 20,
                height: 20,
                memCacheWidth: 40,
                fadeInDuration: const Duration(milliseconds: 300),
                fadeOutDuration: const Duration(milliseconds: 300),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  period: const Duration(milliseconds: 1000),
                  child: Container(
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error_outline,
                  size: 20,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8), // Space between icon and text
          Text(
            name,
            style: const TextStyle(
              fontSize: 12, // Increased font size for readability
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C1B1F),
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> categories = [
  {
    'icon':
        'https://cdn.builder.io/api/v1/image/assets/TEMP/9b579a8c72b3e2a3fc25c6b909d91c275bf7834b',
    'name': 'Plages',
  },
  {
    'icon':
        'https://cdn.builder.io/api/v1/image/assets/TEMP/cb8ae7761808864d7245344b6a9b3fbdbcb65b9b',
    'name': 'Culture',
  },
  {
    'icon':
        'https://cdn.builder.io/api/v1/image/assets/TEMP/b2de6981bd471ae4d15fcb9cd4583485c28555b2',
    'name': 'Aventure',
  },
  {
    'icon':
        'https://cdn.builder.io/api/v1/image/assets/TEMP/9b579a8c72b3e2a3fc25c6b909d91c275bf7834b',
    'name': 'Gastronomie',
  },
  {
    'icon':
        'https://cdn.builder.io/api/v1/image/assets/TEMP/cb8ae7761808864d7245344b6a9b3fbdbcb65b9b',
    'name': 'Luxe',
  },
  {
    'icon':
        'https://cdn.builder.io/api/v1/image/assets/TEMP/b2de6981bd471ae4d15fcb9cd4583485c28555b2',
    'name': 'Romance',
  },
];

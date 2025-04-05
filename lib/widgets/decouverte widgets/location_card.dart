import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class LocationCard extends StatelessWidget {
  final String imageUrl;
  final String location;
  final double rating;
  final String description;
  final String price;
  final String author;
  final bool isFavorite;

  const LocationCard({
    Key? key,
    required this.imageUrl,
    required this.location,
    required this.rating,
    required this.description,
    required this.price,
    required this.author,
    this.isFavorite = false,
  }) : super(key: key);

  String get _optimizedImageUrl {
    // Add Unsplash parameters for smaller, optimized images
    if (imageUrl.contains('unsplash.com')) {
      return '$imageUrl?auto=compress&w=400&q=80';
    }
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImageSection(),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: _buildContentSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          child: CachedNetworkImage(
            imageUrl: _optimizedImageUrl,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
            memCacheHeight: 240,
            fadeInDuration: const Duration(milliseconds: 300),
            fadeOutDuration: const Duration(milliseconds: 300),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => _buildShimmerPlaceholder(),
            errorWidget: (context, url, error) => _buildErrorWidget(),
            maxHeightDiskCache: 240,
            useOldImageOnUrlChange: true,
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite,
              size: 17,
              color: isFavorite ? AppColors.heartRed : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 1000),
      child: Container(
        height: 120,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: 120,
      width: double.infinity,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.grey[400], size: 30),
          const SizedBox(height: 4),
          Text(
            'Image non disponible',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                location,
                style: AppTextStyles.locationTitle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, size: 14, color: AppColors.starYellow),
                const SizedBox(width: 4),
                Text(rating.toString(), style: AppTextStyles.locationTitle),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: AppTextStyles.locationDescription,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(price, style: AppTextStyles.priceText),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, size: 12),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                author,
                style: AppTextStyles.locationDescription,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

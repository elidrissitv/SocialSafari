import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/decouverte widgets/custom_search_bar.dart';
import '../widgets/decouverte widgets/filter_chip.dart' as custom;
import '../widgets/decouverte widgets/category_item.dart';
import '../widgets/decouverte widgets/location_card.dart';
import '../widgets/accueil widgets/header.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen>
    with AutomaticKeepAliveClientMixin {
  String selectedCategory = "Plages"; // This will hold the selected category
  bool isLoading = true;
  bool _didInit = false;

  // List of image URLs to pre-cache
  final List<String> _imageUrls = [
    'https://images.unsplash.com/photo-1520454974749-611b7248ffdb?auto=compress&w=400&q=80',
    'https://images.unsplash.com/photo-1534430480872-3498386e7856?auto=compress&w=400&q=80',
    'https://images.unsplash.com/photo-1549144511-f099e773c147?auto=compress&w=400&q=80',
    'https://images.unsplash.com/photo-1431274172761-fca41d930114?auto=compress&w=400&q=80',
    'https://images.unsplash.com/photo-1595846519845-68e298c2edd8?auto=compress&w=400&q=80',
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didInit) {
      _didInit = true;
      // Pre-cache images
      for (String url in _imageUrls) {
        precacheImage(CachedNetworkImageProvider(url), context);
      }
    }
  }

  Future<void> _loadContent() async {
    if (!mounted) return;
    setState(() => isLoading = true);

    // Simulate network delay (reduced to 200ms)
    await Future.delayed(const Duration(milliseconds: 200));

    if (!mounted) return;
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            header(),
            Expanded(
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 10),
                        const CustomSearchBar(),
                        const SizedBox(height: 20),
                        _buildFiltersSection(),
                        const SizedBox(height: 30),
                        _buildCategoriesSection(),
                        const SizedBox(height: 30),
                        if (isLoading)
                          _buildLoadingShimmer()
                        else
                          _buildCategoryContent(selectedCategory),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Column(
      children: List.generate(
        2,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Expanded(
                child: _buildShimmerCard(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildShimmerCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Filtres', style: AppTextStyles.title),
        SizedBox(height: 15),
        Center(
          // Centre tous les badges dans la colonne
          child: Wrap(
            spacing: 19,
            runSpacing: 12,
            children: [
              custom.FilterChipWidget(
                  label: 'Budget', icon: Icons.attach_money),
              custom.FilterChipWidget(label: 'Sécurité', icon: Icons.security),
              custom.FilterChipWidget(
                  label: 'Accessibilité', icon: Icons.accessible),
              custom.FilterChipWidget(label: 'Ambiance', icon: Icons.star),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Catégories', style: AppTextStyles.title),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CategoryItem(
                label: 'Plages',
                icon: Icon(Icons.beach_access,
                    color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Plages',
                onTap: () => _onCategorySelected('Plages'),
              ),
            ),
            Expanded(
              child: CategoryItem(
                label: 'Culture',
                icon: Icon(Icons.museum, color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Culture',
                onTap: () => _onCategorySelected('Culture'),
              ),
            ),
            Expanded(
              child: CategoryItem(
                label: 'Aventure',
                icon: Icon(Icons.landscape, color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Aventure',
                onTap: () => _onCategorySelected('Aventure'),
              ),
            ),
            Expanded(
              child: CategoryItem(
                label: 'Gastronomie',
                icon:
                    Icon(Icons.restaurant, color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Gastronomie',
                onTap: () => _onCategorySelected('Gastronomie'),
              ),
            ),
            Expanded(
              child: CategoryItem(
                label: 'Luxe',
                icon: Icon(Icons.star, color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Luxe',
                onTap: () => _onCategorySelected('Luxe'),
              ),
            ),
            Expanded(
              child: CategoryItem(
                label: 'Romance',
                icon: Icon(Icons.favorite, color: AppColors.primary, size: 20),
                // Reduced icon size
                isSelected: selectedCategory == 'Romantiques',
                onTap: () => _onCategorySelected('Romantiques'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category; // Update the selected category
      debugPrint('Selected category: $selectedCategory'); // Debug print
    });
  }

  Widget _buildCategoryContent(String category) {
    debugPrint('Building content for category: $category');
    switch (category) {
      case 'Plages':
        return _buildPlagesContent();
      case 'Culture':
        return _buildCultureContent();
      case 'Aventure':
        return _buildAventureContent();
      case 'Gastronomie':
        return _buildGastronomieContent();
      case 'Romantiques':
        return _buildRomantiquesContent();
      default:
        return _buildPlagesContent();
    }
  }

  Widget _buildPlagesContent() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LocationCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1520454974749-611b7248ffdb',
                location: 'Nice, Côte d\'Azur',
                rating: 4.8,
                description:
                    'Un endroit magique où la mer rencontre la culture. La promenade des Anglais est simplement magnifique!',
                price: 'À partir de 1500MAD/nuit',
                author: 'Marouane didi',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: LocationCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1534430480872-3498386e7856',
                location: 'Gordes, Provence',
                rating: 4.9,
                description:
                    'Les champs de lavande sont à couper le souffle. L\'authenticité du village est préservée.',
                price: 'À partir de 1800MAD/nuit',
                author: 'Sami dadah',
                isFavorite: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LocationCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1549144511-f099e773c147',
                location: 'Bordeaux, Nouvelle-Aquitaine',
                rating: 4.7,
                description:
                    'Un mélange parfait de tradition et de modernité. Les vignobles de la région sont incontournables.',
                price: 'À partir de 1600MAD/nuit',
                author: 'Amina L.',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: LocationCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1431274172761-fca41d930114',
                location: 'Paris, Île-de-France',
                rating: 5.0,
                description:
                    'La ville de l\'amour et de la lumière. Explorez ses monuments emblématiques.',
                price: 'À partir de 2200MAD/nuit',
                author: 'Jean-Paul R.',
                isFavorite: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LocationCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1595846519845-68e298c2edd8',
                location: 'Lyon, Auvergne-Rhône-Alpes',
                rating: 4.6,
                description:
                    'Le centre gastronomique de la France, avec ses célèbres bouchons et sa cuisine raffinée.',
                price: 'À partir de 1700MAD/nuit',
                author: 'Lucas M.',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: LocationCard(
                imageUrl:
                    'https://live.staticflickr.com/3699/11007453583_7c331e9e1a_b.jpg',
                location: 'Aix-en-Provence, Provence-Alpes-Côte d\'Azur',
                rating: 4.7,
                description:
                    'Un cadre idyllique entre montagnes et champs de lavande, parfait pour les amoureux de la nature.',
                price: 'À partir de 1800MAD/nuit',
                author: 'Sophie L.',
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: LocationCard(
                imageUrl:
                    'https://aujourdhui.ma/wp-content/uploads/2022/04/marrakech.png',
                location: 'Marrakech, Marrakech-Safi',
                rating: 4.8,
                description:
                    'Une ville vibrante où la culture et la tradition se rencontrent. Explorez les souks et la médina historique.',
                price: 'À partir de 1000MAD/nuit',
                author: 'Ahmed B.',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: LocationCard(
                imageUrl:
                    'https://f2.hespress.com/wp-content/uploads/2023/11/Chefchaouen.jpg',
                location: 'Chefchaouen, Tanger-Tétouan-Al Hoceïma',
                rating: 4.9,
                description:
                    'La perle bleue du Maroc. Profitez des montagnes et des ruelles pittoresques baignées dans un bleu magique.',
                price: 'À partir de 950MAD/nuit',
                author: 'Leila H.',
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: LocationCard(
                imageUrl:
                    'https://www.h24info.ma/wp-content/uploads/2021/05/medina-fe%CC%80s-trtw.jpg',
                location: 'Fès, Fès-Meknès',
                rating: 4.7,
                description:
                    'Une ville historique avec des médinas classées au patrimoine mondial. Plongez dans l\'histoire marocaine à travers ses artisans et monuments.',
                price: 'À partir de 1100MAD/nuit',
                author: 'Youssef Z.',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: LocationCard(
                imageUrl:
                    'https://les-prestigieuses.com/wp-content/uploads/2023/09/plage-taghazout-agadir-surf-scaled.jpg',
                location: 'Agadir, Souss-Massa',
                rating: 4.6,
                description:
                    'Une destination balnéaire magnifique avec des plages dorées et une promenade animée. Idéale pour les amateurs de plage et de détente.',
                price: 'À partir de 1200MAD/nuit',
                author: 'Hicham K.',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCultureContent() {
    return Column(
      children: [
        Text("Culture content goes here.", style: AppTextStyles.title),
        Container(
          color: Colors.red,
          height: 200,
          child: Center(
            child: Text(
              'LocationCard should appear here',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        // Temporary simplified LocationCard for testing
        Container(
          color: Colors.blue,
          height: 200,
          child: Center(child: Text('Simplified LocationCard')),
        ),
      ],
    );
  }

  Widget _buildAventureContent() {
    return Column(
      children: [
        Text("Aventure content goes here.", style: AppTextStyles.title),
        LocationCard(
          imageUrl:
              'https://cdn.pixabay.com/photo/2016/11/19/12/48/adventure-1835116_960_720.jpg',
          location: 'Toubkal, High Atlas Mountains',
          rating: 4.9,
          description:
              'Un trek inoubliable dans les montagnes les plus hautes du Maroc.',
          price: 'À partir de 1200MAD/nuit',
          author: 'Ali R.',
        ),
      ],
    );
  }

  Widget _buildGastronomieContent() {
    return Column(
      children: [
        LocationCard(
          imageUrl:
              'https://cdn.builder.io/api/v1/image/assets/TEMP/eef712589111312df5d01a548bc438c323bd1bfc',
          location: 'Marrakech, Maroc',
          rating: 4.9,
          description:
              'Découvrez les saveurs authentiques de la cuisine marocaine.',
          price: 'À partir de 800MAD/personne',
          author: 'Chef Hassan',
        ),
        SizedBox(height: 16),
        LocationCard(
          imageUrl:
              'https://cdn.builder.io/api/v1/image/assets/TEMP/eef712589111312df5d01a548bc438c323bd1bfc',
          location: 'Paris, France',
          rating: 4.7,
          description:
              'Une expérience gastronomique inoubliable dans la ville lumière.',
          price: 'À partir de 1200MAD/personne',
          author: 'Chef Marie',
        ),
      ],
    );
  }

  Widget _buildRomantiquesContent() {
    return Column(
      children: [
        LocationCard(
          imageUrl:
              'https://cdn.builder.io/api/v1/image/assets/TEMP/eef712589111312df5d01a548bc438c323bd1bfc',
          location: 'Venise, Italie',
          rating: 4.9,
          description: 'Une escapade romantique dans la ville des amoureux.',
          price: 'À partir de 2000MAD/nuit',
          author: 'Marco',
        ),
        SizedBox(height: 16),
        LocationCard(
          imageUrl:
              'https://cdn.builder.io/api/v1/image/assets/TEMP/eef712589111312df5d01a548bc438c323bd1bfc',
          location: 'Santorini, Grèce',
          rating: 4.8,
          description:
              'Couchers de soleil à couper le souffle sur les toits blancs.',
          price: 'À partir de 1800MAD/nuit',
          author: 'Sophia',
        ),
      ],
    );
  }
}

Widget header() {
  return Container(
    height: 47,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.5),
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Découverte',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 14,
              height: 15,
              child: CustomPaint(
                painter: NotificationIconPainter(),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              width: 19,
              height: 19,
              decoration: const BoxDecoration(
                color: Color(0xFFCED0F8),
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  'https://cdn.builder.io/api/v1/image/assets/TEMP/216133e8eea83f5382dba7c712a5a691d784f9b3',
                  width: 19,
                  height: 19,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

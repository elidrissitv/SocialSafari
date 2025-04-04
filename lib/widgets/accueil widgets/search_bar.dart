import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _isExpanded = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(231, 223, 223, 0.5),
          borderRadius: BorderRadius.circular(_isExpanded ? 20 : 40),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search Bar
            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 1),
              child: Row(
                children: [
                  Container(
                    width: 21,
                    height: 21,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6D56FF),
                      borderRadius: BorderRadius.circular(21),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: !_isExpanded
                        ? GestureDetector(
                            onTap: () {
                              setState(() => _isExpanded = true);
                              _focusNode.requestFocus();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Où souhitez-vous aller ?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF11181C),
                                  ),
                                ),
                                Text(
                                  'Cherchez des destinations, des expériences...',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Color(0xFF6A6A6A),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : TextField(
                            focusNode: _focusNode,
                            decoration: const InputDecoration(
                              hintText: 'Où souhitez-vous aller ?',
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF11181C),
                            ),
                          ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                    child: Icon(
                      _isExpanded ? Icons.close : Icons.tune,
                      size: 16,
                      color: Color(0xFF6D56FF),
                    ),
                  ),
                ],
              ),
            ),

            // Expanded Search Content
            if (_isExpanded) ...[
              const Divider(height: 1, color: Color(0xFFE5E7EB)),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Destinations populaires',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildSuggestionChip('Paris'),
                        _buildSuggestionChip('Marrakech'),
                        _buildSuggestionChip('Nice'),
                        _buildSuggestionChip('Bordeaux'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recherches récentes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildRecentSearch('Hôtels à Paris', Icons.history),
                    _buildRecentSearch('Plages à Nice', Icons.history),
                    _buildRecentSearch(
                        'Restaurants à Marrakech', Icons.history),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white,
      side: BorderSide.none,
    );
  }

  Widget _buildRecentSearch(String text, IconData icon) {
    return ListTile(
      leading: Icon(icon, size: 20, color: Colors.grey),
      title: Text(text, style: const TextStyle(fontSize: 14)),
      dense: true,
      visualDensity: VisualDensity.compact,
      onTap: () {},
    );
  }
}

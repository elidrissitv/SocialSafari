import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/reservation.dart';

class HistorySection extends StatefulWidget {
  const HistorySection({Key? key}) : super(key: key);

  @override
  State<HistorySection> createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  String selectedFilter = 'Tout';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  DateTime? _selectedDate;
  int? _selectedPeople;

  final List<Reservation> _allReservations = [
    Reservation(
      restaurantName: 'Le Petit Bistrot',
      numberOfPeople: 2,
      tableType: 'Table en terrasse',
      dateTime: DateTime.now().add(const Duration(days: 1, hours: 20)),
      address: '15 Rue de la Paix, Paris',
      status: 'Confirmée',
      isConfirmed: true,
    ),
    Reservation(
      restaurantName: 'La Belle Vue',
      numberOfPeople: 4,
      tableType: 'Table intérieure',
      dateTime: DateTime(2024, 3, 25, 19, 30),
      address: '8 Avenue des Champs-Élysées, Paris',
      status: 'En attente',
      isConfirmed: false,
    ),
    Reservation(
      restaurantName: 'Le Jardin Secret',
      numberOfPeople: 2,
      tableType: 'Table jardin',
      dateTime: DateTime(2024, 3, 28, 12, 30),
      address: '23 Rue du Faubourg Saint-Antoine, Paris',
      status: 'Confirmée',
      isConfirmed: true,
    ),
    Reservation(
      restaurantName: 'L\'Atelier Gastronomique',
      numberOfPeople: 6,
      tableType: 'Table privée',
      dateTime: DateTime(2024, 4, 1, 20, 00),
      address: '45 Rue de la Roquette, Paris',
      status: 'En attente',
      isConfirmed: false,
    ),
  ];

  List<Reservation> get _filteredReservations {
    List<Reservation> filtered = _allReservations.where((reservation) {
      // Apply search filter
      if (_searchQuery.isNotEmpty) {
        final searchLower = _searchQuery.toLowerCase();
        return reservation.restaurantName.toLowerCase().contains(searchLower) ||
            reservation.address.toLowerCase().contains(searchLower) ||
            reservation.tableType.toLowerCase().contains(searchLower);
      }

      // Apply category filter
      switch (selectedFilter) {
        case 'Réservations':
          return true;
        case 'Confirmées':
          return reservation.isConfirmed;
        case 'En attente':
          return !reservation.isConfirmed;
        default:
          return true;
      }
    }).toList();

    // Sort reservations: En attente first, then Confirmées
    filtered.sort((a, b) {
      if (a.isConfirmed == b.isConfirmed) {
        // If same status, sort by date
        return a.dateTime.compareTo(b.dateTime);
      }
      // Put unconfirmed (En attente) first
      return a.isConfirmed ? 1 : -1;
    });

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _shareReservation(Reservation reservation) async {
    await Share.share(reservation.shareText);
  }

  Future<void> _showPrintPreview(Reservation reservation) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Détails de la Réservation',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 16),
              Text(
                'Restaurant: ${reservation.restaurantName}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'Date: ${reservation.formattedDate}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Nombre de personnes: ${reservation.numberOfPeople}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Type de table: ${reservation.tableType}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Adresse: ${reservation.address}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Statut: ${reservation.status}',
                style: TextStyle(
                  fontSize: 16,
                  color: reservation.isConfirmed ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.print),
                    label: Text('Imprimer'),
                    onPressed: () {
                      // Here you would implement actual printing functionality
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6D56FF),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showModificationDialog(Reservation reservation) async {
    if (reservation.isConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Les réservations confirmées ne peuvent pas être modifiées'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    DateTime selectedDate = reservation.dateTime;
    int selectedPeople = reservation.numberOfPeople;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Modifier la Réservation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                Text('Date et heure'),
                SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    final DateTime now = DateTime.now();
                    final DateTime initialDate =
                        selectedDate.isBefore(now) ? now : selectedDate;
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: now,
                      lastDate: now.add(Duration(days: 365)),
                    );
                    if (picked != null) {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDate),
                      );
                      if (time != null) {
                        setState(() {
                          selectedDate = DateTime(
                            picked.year,
                            picked.month,
                            picked.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} à ${selectedDate.hour}:${selectedDate.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Nombre de personnes'),
                SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: selectedPeople,
                  items: List.generate(10, (index) => index + 1)
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text('$e personne${e > 1 ? 's' : ''}'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedPeople = value;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Annuler'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Update the reservation
                        this.setState(() {
                          final index = _allReservations.indexOf(reservation);
                          if (index != -1) {
                            _allReservations[index] = Reservation(
                              restaurantName: reservation.restaurantName,
                              numberOfPeople: selectedPeople,
                              tableType: reservation.tableType,
                              dateTime: selectedDate,
                              address: reservation.address,
                              status: 'En attente',
                              isConfirmed: false,
                            );
                          }
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Réservation modifiée avec succès'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: Text('Confirmer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6D56FF),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Rechercher dans l\'historique',
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFF9CA3AF)),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Filter Buttons
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildFilterButton('Tout'),
                      const SizedBox(width: 8),
                      _buildFilterButton('Confirmées'),
                      const SizedBox(width: 8),
                      _buildFilterButton('En attente'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Reservation Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredReservations.length,
              itemBuilder: (context, index) {
                final reservation = _filteredReservations[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildReservationCard(reservation),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6D56FF) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF6D56FF) : const Color(0xFFE5E7EB),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildReservationCard(Reservation reservation) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  reservation.restaurantName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: reservation.isConfirmed
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFFEF9C3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  reservation.status,
                  style: TextStyle(
                    fontSize: 12,
                    color: reservation.isConfirmed
                        ? const Color(0xFF166534)
                        : const Color(0xFF854D0E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${reservation.numberOfPeople} personnes • ${reservation.tableType}',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  reservation.formattedDate,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  reservation.address,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showModificationDialog(reservation),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF6D56FF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Modifier',
                    style: TextStyle(
                      color: Color(0xFF6D56FF),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: () => _shareReservation(reservation),
                  icon: const Icon(Icons.share, color: Color(0xFF6B7280)),
                  style: IconButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: () => _showPrintPreview(reservation),
                  icon: const Icon(Icons.print, color: Color(0xFF6B7280)),
                  style: IconButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

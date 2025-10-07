import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/place_provider.dart';
import '../providers/ticket_provider.dart';
import '../providers/auth_provider.dart';

class PlaceDetailScreen extends StatefulWidget {
  final String placeId;
  const PlaceDetailScreen({super.key, required this.placeId});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  DateTime? _selectedDate;
  bool _booking = false;

  Future<void> _book() async {
    final auth = context.read<AuthProvider>();
    if (auth.currentUser == null) return;
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select visit date')));
      return;
    }
    setState(() => _booking = true);
    await context.read<TicketProvider>().bookTicket(
          userId: auth.currentUser!.id,
          placeId: widget.placeId,
          visitDate: _selectedDate!,
        );
    setState(() => _booking = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ticket booked successfully')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final place = context.read<PlaceProvider>().getById(widget.placeId);
    return Scaffold(
      appBar: AppBar(title: Text(place?.name ?? 'Place')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (place?.imageUrl.isNotEmpty ?? false)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(place!.imageUrl, height: 220, width: double.infinity, fit: BoxFit.cover),
              ),
            const SizedBox(height: 12),
            Text(place?.name ?? '', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(place?.location ?? '', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            Text(place?.description ?? ''),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(_selectedDate == null ? 'Select visit date' : _selectedDate!.toLocal().toString().split(' ').first),
                    onPressed: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: now.add(const Duration(days: 1)),
                        firstDate: now,
                        lastDate: now.add(const Duration(days: 365)),
                      );
                      if (picked != null) setState(() => _selectedDate = picked);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.confirmation_num),
                    label: Text(_booking ? 'Booking...' : 'Book Ticket'),
                    onPressed: _booking ? null : _book,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
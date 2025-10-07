import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';
import '../providers/place_provider.dart';
import '../providers/auth_provider.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TicketProvider>().loadTickets());
  }

  @override
  Widget build(BuildContext context) {
    final tickets = context.watch<TicketProvider>().tickets;
    final places = context.watch<PlaceProvider>().places;
    final user = context.watch<AuthProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('My Tickets')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: tickets.length,
        itemBuilder: (context, i) {
          final t = tickets[i];
          final placeName = places.firstWhere((p) => p.id == t.placeId, orElse: () => places.first).name;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.confirmation_num_outlined),
              title: Text(placeName),
              subtitle: Text('Ticket: ${t.ticketNumber}\nDate: ${t.visitDate.toLocal().toString().split(' ').first}\nBooked by: ${user?.name ?? ''}'),
            ),
          );
        },
      ),
    );
  }
}
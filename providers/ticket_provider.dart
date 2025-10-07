import 'package:flutter/material.dart';
import '../models/ticket.dart';
import '../services/database_service.dart';

class TicketProvider extends ChangeNotifier {
  final _db = DatabaseService();
  List<Ticket> _tickets = [];

  List<Ticket> get tickets => _tickets;

  Future<void> loadTickets() async {
    final box = _db.ticketsBox;
    _tickets = box.values.map((e) => Ticket.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> bookTicket({required String userId, required String placeId, required DateTime visitDate}) async {
    final id = _db.generateId(prefix: 'tkt_');
    final ticket = Ticket(
      id: id,
      ticketNumber: _db.generateTicketNumber(),
      userId: userId,
      placeId: placeId,
      visitDate: visitDate,
      createdAt: DateTime.now(),
    );
    await _db.ticketsBox.put(id, ticket.toMap());
    await loadTickets();
  }
}
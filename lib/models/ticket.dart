class Ticket {
  final String id;
  final String ticketNumber;
  final String userId;
  final String placeId;
  final DateTime visitDate;
  final DateTime createdAt;

  Ticket({
    required this.id,
    required this.ticketNumber,
    required this.userId,
    required this.placeId,
    required this.visitDate,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'ticketNumber': ticketNumber,
        'userId': userId,
        'placeId': placeId,
        'visitDate': visitDate.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
      };

  factory Ticket.fromMap(Map data) => Ticket(
        id: data['id'] as String,
        ticketNumber: data['ticketNumber'] as String,
        userId: data['userId'] as String,
        placeId: data['placeId'] as String,
        visitDate: DateTime.parse(data['visitDate'] as String),
        createdAt: DateTime.parse(data['createdAt'] as String),
      );
}
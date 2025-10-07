import 'package:flutter/material.dart';
import '../models/place.dart';
import '../services/database_service.dart';

class PlaceProvider extends ChangeNotifier {
  final _db = DatabaseService();
  List<Place> _places = [];

  List<Place> get places => _places;

  Future<void> loadPlaces() async {
    final box = _db.placesBox;
    if (box.isEmpty) {
      // Seed curated Gujarat places
      final seed = [
        Place(
          id: _db.generateId(prefix: 'plc_'),
          name: 'Sabarmati Ashram',
          description: 'Historic residence of Mahatma Gandhi, serene riverside ashram.',
          imageUrl: 'https://en.wikipedia.org/wiki/Sabarmati_Ashram#/media/File:GANDHI_ASHRAM_03.jpg',
          location: 'Ahmedabad',
        ),
        Place(
          id: _db.generateId(prefix: 'plc_'),
          name: 'Gir National Park',
          description: 'Only habitat of the Asiatic lions, lush forest and wildlife safaris.',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/f/fb/A_desert_lion.jpg',
          location: 'Junagadh',
        ),
        Place(
          id: _db.generateId(prefix: 'plc_'),
          name: 'Statue of Unity',
          description: 'World’s tallest statue dedicated to Sardar Patel, with viewing gallery.',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/3/36/Statue_of_Unity_24-10-2018.jpg',
          location: 'Kevadia',
        ),
        Place(
          id: _db.generateId(prefix: 'plc_'),
          name: 'Rann of Kutch',
          description: 'Expansive white salt desert, spectacular sunsets and Rann Utsav.',
          imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/7/71/Great_Rann_of_Kutch.jpg',
          location: 'Kutch',
        ),
      ];
      for (final p in seed) {
        await box.put(p.id, p.toMap());
      }
    }
    _places = box.values.map((e) => Place.fromMap(e)).toList();
    notifyListeners();
  }

  Place? getById(String id) => _places.firstWhere((p) => p.id == id, orElse: () => Place(
        id: '', name: '', description: '', imageUrl: '', location: '',
      ));
}
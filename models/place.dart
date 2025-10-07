class Place {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String location;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'location': location,
      };

  factory Place.fromMap(Map data) => Place(
        id: data['id'] as String,
        name: data['name'] as String,
        description: data['description'] as String,
        imageUrl: data['imageUrl'] as String,
        location: data['location'] as String,
      );
}
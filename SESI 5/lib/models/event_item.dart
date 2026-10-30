class EventItem {
  final String id;
  final String title;
  final String category;
  final String date;
  final String time;
  final String location;
  final String description;
  final String speaker;
  final int price;
  final int capacity;
  final String colorHex;

  const EventItem({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.speaker,
    required this.price,
    required this.capacity,
    required this.colorHex,
  });
}
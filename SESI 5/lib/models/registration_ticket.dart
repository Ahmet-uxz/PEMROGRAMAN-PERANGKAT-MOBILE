import 'event_item.dart';

class RegistrationTicket {
  final String id;
  final EventItem event;
  final String name;
  final String nim;
  final String email;
  final String whatsapp;
  final String participantType;
  final DateTime attendanceDate;
  final String kitPackage;
  final bool donation;
  final DateTime registeredAt;

  const RegistrationTicket({
    required this.id,
    required this.event,
    required this.name,
    required this.nim,
    required this.email,
    required this.whatsapp,
    required this.participantType,
    required this.attendanceDate,
    required this.kitPackage,
    required this.donation,
    required this.registeredAt,
  });
}
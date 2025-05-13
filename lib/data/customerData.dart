import 'package:faker/faker.dart';

final List<String> titleData = ['Name', 'Status', 'Total'];

final faker = Faker();
final List<Map<String, String>> tableData = List.generate(100, (index) {
  final statuses = ['member', 'common'];
  final name = faker.person.name();
  // Convert name to email: lowercase, spaces to dots, append @gmail.com
  final email = '${name.toLowerCase().replaceAll(' ', '.')}@gmail.com';

  return {
    'name': name,
    'status': statuses[index % 2], // Fixed: Use modulo 2 for 2 statuses
    'email': email, // Name-based email instead of faker.internet.email()
  };
});
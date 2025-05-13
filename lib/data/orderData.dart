import 'package:faker/faker.dart';

final List<String> titleData = ['Name', 'Status', 'Total'];

final faker = Faker();
final List<Map<String, String>> tableData = List.generate(100, (index) {
  final statuses = ['New', 'Quotation', 'Invoice', 'Paid', 'Cancelled'];
  return {
    'name': faker.person.name(),
    'status': statuses[index % 5],
    'total': (faker.randomGenerator.integer(951, min: 50)).toString(),
  };
});

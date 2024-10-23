

final List<Contact> contacts = [
  Contact(name: 'Jon', phoneType: 'Mobile', date: 'Mon'),
  Contact(name: 'Dev', phoneType: 'Mobile', date: 'Mon', isHd: true),
  Contact(name: 'Monish', phoneType: 'Mobile', date: 'Wed', isHd: true),
  Contact(name: '+91 95374 22059', phoneType: 'India', date: 'Wed'),
  Contact(name: 'Joy', phoneType: 'Mobile', date: 'Wed'),
  Contact(name: 'Bob', phoneType: 'Mobile', date: 'Tues'),
  Contact(name: 'Roy', phoneType: 'Mobile', date: 'Tues'),
  Contact(name: 'Monica', phoneType: 'Mobile', date: 'Fri'),
  Contact(name: 'Alice', phoneType: 'Home', date: 'Tue'),
  Contact(name: 'Bob', phoneType: 'Work', date: 'Wed'),
  Contact(name: 'Emma', phoneType: 'Mobile', date: 'Thu'),
  Contact(name: 'Mike', phoneType: 'Home', date: 'Fri'),
  Contact(name: 'Sophia', phoneType: 'Work', date: 'Sat'),
  Contact(name: 'Chris', phoneType: 'Mobile', date: 'Sun'),
];
class Contact {
  final String name;
  final String phoneType;
  final String date;
  final bool isHd;

  Contact({
    required this.name,
    required this.phoneType,
    required this.date,
    this.isHd = false,
  });
}
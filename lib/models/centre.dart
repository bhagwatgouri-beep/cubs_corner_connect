class Centre {
  final String id;

  final String name;

  final String address;

  final String phoneNumber;

  final String email;

  final bool isActive;

  const Centre({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
    this.isActive = true,
  });
}
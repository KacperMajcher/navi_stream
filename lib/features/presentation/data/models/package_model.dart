class Package {
  Package({
    required this.id,
    this.purchased,
  });
  final int id;
  final String? purchased;

  // converter JSON to model
  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      purchased: json['purchased'],
    );
  }
}

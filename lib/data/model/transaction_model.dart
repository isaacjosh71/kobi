class Transaction {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final String category;
  final String status;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.category,
    required this.status,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      amount: json['amount'],
      category: json['category'],
      status: json['status'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'amount': amount,
      'category': category,
      'status': status,
      'date': date.toIso8601String(),
    };
  }
}

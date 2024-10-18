class FeesPayment {
  final int? id;
  final String studentName;
  final double amount;
  final int grade;
  final String term;

  FeesPayment({
    this.id,
    required this.studentName,
    required this.amount,
    required this.grade,
    required this.term,
  });

  // Convert a FeesPayment object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_name': studentName,
      'amount': amount,
      'grade': grade,
      'term': term,
    };
  }

  // Convert a Map into a FeesPayment object
  factory FeesPayment.fromMap(Map<String, dynamic> map) {
    return FeesPayment(
      id: map['id'],
      studentName: map['student_name'],
      amount: map['amount'],
      grade: map['grade'],
      term: map['term'],
    );
  }
}

import 'package:random_quote_generator/features/auth/domain/entities/quote.dart';

class QuoteModel extends Quote {
  const QuoteModel({required super.text, required super.author});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      text: (json['quote'] as String?) ?? '',
      author: (json['author'] as String?) ?? 'Unknown',
    );
  }
}

import 'package:random_quote_generator/features/auth/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<Quote> getRandomQuote();
}

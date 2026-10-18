import 'package:random_quote_generator/features/quote/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<Quote> getRandomQuote();
}

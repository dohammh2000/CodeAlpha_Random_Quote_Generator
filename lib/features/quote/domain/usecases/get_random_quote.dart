import 'package:random_quote_generator/features/auth/domain/entities/quote.dart';
import 'package:random_quote_generator/features/quote/data/repositories/quote_repository.dart';

class GetRandomQuote {
  final QuoteRepository repository;

  GetRandomQuote(this.repository);

  Future<Quote> call() => repository.getRandomQuote();
}

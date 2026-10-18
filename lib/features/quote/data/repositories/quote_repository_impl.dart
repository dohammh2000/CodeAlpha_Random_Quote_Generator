import 'package:random_quote_generator/features/auth/domain/entities/quote.dart';
import 'package:random_quote_generator/features/quote/data/datasources/quote_remote_data_source.dart';
import 'package:random_quote_generator/features/quote/data/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;

  QuoteRepositoryImpl(this.remoteDataSource);

  @override
  Future<Quote> getRandomQuote() => remoteDataSource.getRandomQuote();
}

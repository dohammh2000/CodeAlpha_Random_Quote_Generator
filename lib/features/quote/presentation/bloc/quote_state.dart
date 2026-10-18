import 'package:equatable/equatable.dart';
import 'package:random_quote_generator/features/auth/domain/entities/quote.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object?> get props => [];
}

class QuoteInitial extends QuoteState {
  const QuoteInitial();
}

class QuoteLoading extends QuoteState {
  const QuoteLoading();
}

class QuoteLoaded extends QuoteState {
  final Quote quote;
  const QuoteLoaded(this.quote);

  @override
  List<Object?> get props => [quote];
}

class QuoteError extends QuoteState {
  final String message;
  const QuoteError(this.message);

  @override
  List<Object?> get props => [message];
}

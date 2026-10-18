import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_generator/core/error/app_exception.dart';
import 'package:random_quote_generator/features/quote/domain/usecases/get_random_quote.dart';
import 'package:random_quote_generator/features/quote/presentation/bloc/quote_event.dart';
import 'package:random_quote_generator/features/quote/presentation/bloc/quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetRandomQuote getRandomQuote;

  QuoteBloc(this.getRandomQuote) : super(const QuoteInitial()) {
    on<QuoteRequested>(_onQuoteRequested);
  }

  Future<void> _onQuoteRequested(
    QuoteRequested event,
    Emitter<QuoteState> emit,
  ) async {
    emit(const QuoteLoading());
    try {
      final quote = await getRandomQuote();
      emit(QuoteLoaded(quote));
    } on AppException catch (e) {
      emit(QuoteError(e.message));
    }
  }
}

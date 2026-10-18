import 'package:equatable/equatable.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object?> get props => [];
}

class QuoteRequested extends QuoteEvent {
  const QuoteRequested();
}

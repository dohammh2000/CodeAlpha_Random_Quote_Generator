import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_generator/features/auth/domain/entities/quote.dart';
import 'package:random_quote_generator/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:random_quote_generator/features/auth/presentation/bloc/auth_event.dart';
import 'package:random_quote_generator/features/quote/data/repositories/quote_repository.dart';
import 'package:random_quote_generator/features/quote/domain/entities/quote.dart'
    hide Quote;
import 'package:random_quote_generator/features/quote/domain/repositories/quote_repository.dart'
    hide QuoteRepository;
import 'package:random_quote_generator/features/quote/domain/usecases/get_random_quote.dart';
import 'package:random_quote_generator/features/quote/presentation/bloc/quote_bloc.dart';
import 'package:random_quote_generator/features/quote/presentation/bloc/quote_event.dart';
import 'package:random_quote_generator/features/quote/presentation/bloc/quote_state.dart';

class QuotePage extends StatelessWidget {
  const QuotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // ..add(...) fires the first request, so a quote shows when the page opens
      create: (context) =>
          QuoteBloc(GetRandomQuote(context.read<QuoteRepository>()))
            ..add(const QuoteRequested()),
      child: const _QuoteView(),
    );
  }
}

class _QuoteView extends StatelessWidget {
  const _QuoteView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quote'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () =>
                context.read<AuthBloc>().add(const LogoutRequested()),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: BlocBuilder<QuoteBloc, QuoteState>(
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: _buildContent(state),
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<QuoteBloc, QuoteState>(
                builder: (context, state) {
                  final isLoading = state is QuoteLoading;
                  return SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: isLoading
                          ? null
                          : () => context.read<QuoteBloc>().add(
                              const QuoteRequested(),
                            ),
                      icon: const Icon(Icons.refresh),
                      label: const Text('New Quote'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(QuoteState state) {
    if (state is QuoteLoaded) {
      return _QuoteCard(key: ValueKey(state.quote.text), quote: state.quote);
    }
    if (state is QuoteError) {
      return Text(
        state.message,
        key: const ValueKey('error'),
        textAlign: TextAlign.center,
      );
    }
    return const CircularProgressIndicator(key: ValueKey('loading'));
  }
}

class _QuoteCard extends StatelessWidget {
  final Quote quote;

  const _QuoteCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.format_quote_rounded,
            size: 48,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            '“${quote.text}”',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '— ${quote.author}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

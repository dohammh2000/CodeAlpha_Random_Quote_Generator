import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:random_quote_generator/core/constants/api_constants.dart';
import 'package:random_quote_generator/core/error/app_exception.dart';
import 'package:random_quote_generator/features/quote/data/models/quote_model.dart';

class QuoteRemoteDataSource {
  final http.Client client;

  QuoteRemoteDataSource(this.client);

  Future<QuoteModel> getRandomQuote() async {
    try {
      final response = await client.get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.randomQuotesEndpoint}',
        ),
        headers: {'X-Api-Key': ApiConstants.apiKey},
      );

      if (response.statusCode != 200) {
        throw AppException('Server error (${response.statusCode}).');
      }

      // The API returns a LIST: [ { "quote": ..., "author": ... } ]
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isEmpty) throw const AppException('No quote found.');

      return QuoteModel.fromJson(data.first as Map<String, dynamic>);
    } on AppException {
      rethrow;
    } catch (_) {
      throw const AppException(
        'Could not load a quote. Check your internet connection.',
      );
    }
  }
}

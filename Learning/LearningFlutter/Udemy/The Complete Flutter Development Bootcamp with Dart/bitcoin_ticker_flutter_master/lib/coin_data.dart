import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<String> getCoinData(String base, String quote) async {
    final String url = 'https://rest.coinapi.io/v1/exchangerate/$base/$quote';

    Map<String, String> header = {
      HttpHeaders.authorizationHeader: "3FA5D57B-63B0-476D-B8BF-195FF7D8B6D0",
      HttpHeaders.contentTypeHeader: "application/json"
    };

    Uri uri = Uri.parse(url);

    final response = await http.get(
      uri,
      headers: header,
    );
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse['rate'].round().toString();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw 'Problem with the get request';
    }
  }
}

import 'package:flutter/material.dart';

import 'package:bitcoin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  bool isWaiting = false;
  List<String> coinValues = [];

  List<DropdownMenuItem<String>> getDropdownItems() {
    return currenciesList
        .map((e) => DropdownMenuItem(
              child: Text(e),
              value: e,
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    getRates();
  }

  void getRates() async {
    CoinData coinData = CoinData();
    isWaiting = true;
    coinValues.clear();
    try {
      for (String crypto in cryptoList) {
        String data = await coinData.getCoinData(crypto, selectedCurrency);
        coinValues.add(data);
      }
      setState(() {
        isWaiting = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(
                rate: isWaiting ? '?' : coinValues[0],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: cryptoList[0],
              ),
              CryptoCard(
                rate: isWaiting ? '?' : coinValues[1],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: cryptoList[1],
              ),
              CryptoCard(
                rate: isWaiting ? '?' : coinValues[2],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: cryptoList[2],
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectedCurrency,
              items: getDropdownItems(),
              onChanged: (String? value) {
                setState(() {
                  selectedCurrency = value ?? 'USD';
                  getRates();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key? key,
    required this.rate,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  }) : super(key: key);

  final String rate;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $rate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalData extends ChangeNotifier {
  late Map<String, dynamic> _data;

  GlobalData() {
    _data = {};
    fetchDataFromApi();
  }

  Map<String, dynamic> get data => _data;

  Future<void> fetchDataFromApi() async {
    final response = await http.get(Uri.parse(
        'https://api.hgbrasil.com/finance?key=f39bc6bc&format=json-cors'));

    if (response.statusCode == 200) {
      _data = json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar dados da API');
    }

    notifyListeners();
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalData>(
      create: (context) => GlobalData(),
      child: MaterialApp(
        title: 'Finanças',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const FinancePage(),
          '/acoes': (context) => const AcoesPage(),
          '/bitcoin': (context) => const BitcoinPage(),
        },
      ),
    );
  }
}

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    var globalData = Provider.of<GlobalData>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Finanças de Hoje'),
      ),
      body: Center(
        child: globalData.data.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'MOEDAS',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                _buildCurrencyColumn(
                                    'Dólar',
                                    globalData.data['results']['currencies']
                                        ['USD']['buy'],
                                    globalData.data['results']['currencies']
                                        ['USD']['variation']),
                                const SizedBox(height: 20),
                                _buildCurrencyColumn(
                                    'Peso',
                                    globalData.data['results']['currencies']
                                        ['ARS']['buy'],
                                    globalData.data['results']['currencies']
                                        ['ARS']['variation']),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buildCurrencyColumn(
                                    'Euro',
                                    globalData.data['results']['currencies']
                                        ['EUR']['buy'],
                                    globalData.data['results']['currencies']
                                        ['EUR']['variation']),
                                const SizedBox(height: 20),
                                _buildCurrencyColumn(
                                    'Yen',
                                    globalData.data['results']['currencies']
                                        ['JPY']['buy'],
                                    globalData.data['results']['currencies']
                                        ['JPY']['variation']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/acoes');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[900],
                        ),
                        child: const Text('Ir para Ações'),
                      ),
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildCurrencyColumn(String currency, double value, double variation) {
    Color variationColor = variation >= 0 ? Colors.blue : Colors.red;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          currency,
          style: const TextStyle(fontSize: 20),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              value.toStringAsFixed(4),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: variationColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                variation.toStringAsFixed(4),
                style: const TextStyle(fontSize: 11, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AcoesPage extends StatelessWidget {
  const AcoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var globalData = Provider.of<GlobalData>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Finanças de Hoje'),
      ),
      body: Center(
        child: globalData.data.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Ações',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                _buildCurrencyColumn(
                                    'IBOVESPA',
                                    globalData.data['results']['stocks']
                                        ['IBOVESPA']['points'],
                                    globalData.data['results']['stocks']
                                        ['IBOVESPA']['variation']),
                                const SizedBox(height: 20),
                                _buildCurrencyColumn(
                                    'NASDAQ',
                                    globalData.data['results']['stocks']
                                        ['NASDAQ']['points'],
                                    globalData.data['results']['stocks']
                                        ['NASDAQ']['variation']),
                                const SizedBox(height: 20),
                                _buildCurrencyColumn(
                                    'CAC',
                                    globalData.data['results']['stocks']['CAC']
                                        ['points'],
                                    globalData.data['results']['stocks']['CAC']
                                        ['variation']),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buildCurrencyColumn(
                                    'IFIX',
                                    globalData.data['results']['stocks']['IFIX']
                                        ['points'],
                                    globalData.data['results']['stocks']['IFIX']
                                        ['variation']),
                                const SizedBox(height: 20),
                                _buildCurrencyColumn(
                                    'DOWJONES',
                                    globalData.data['results']['stocks']
                                        ['DOWJONES']['points'],
                                    globalData.data['results']['stocks']
                                        ['DOWJONES']['variation']),
                                const SizedBox(height: 20),
                                _buildCurrencyColumn(
                                    'NIKKEI',
                                    globalData.data['results']['stocks']
                                        ['NIKKEI']['points'],
                                    globalData.data['results']['stocks']
                                        ['NIKKEI']['variation']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/bitcoin');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[900],
                        ),
                        child: const Text('Ir para Bitcoin'),
                      ),
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildCurrencyColumn(String currency, double value, double variation) {
    Color variationColor = variation >= 0 ? Colors.blue : Colors.red;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          currency,
          style: const TextStyle(fontSize: 20),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              value.toStringAsFixed(2),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: variationColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                variation.toStringAsFixed(2),
                style: const TextStyle(fontSize: 11, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BitcoinPage extends StatelessWidget {
  const BitcoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    var globalData = Provider.of<GlobalData>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Finanças de Hoje'),
      ),
      body: Center(
        child: globalData.data.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'BitCoin',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                _buildCurrencyColumn(
                                    globalData.data['results']['bitcoin']
                                        ['blockchain_info']['name'],
                                    globalData.data['results']['bitcoin']
                                        ['blockchain_info']['buy'],
                                    globalData.data['results']['bitcoin']
                                        ['blockchain_info']['variation']),
                                const SizedBox(height: 20),
                                _buildCurrencyColumn(
                                    globalData.data['results']['bitcoin']
                                        ['bitstamp']['name'],
                                    globalData.data['results']['bitcoin']
                                        ['bitstamp']['buy'],
                                    globalData.data['results']['bitcoin']
                                        ['bitstamp']['variation']),
                                const SizedBox(height: 20),
                                _buildCurrencyColumn(
                                    globalData.data['results']['bitcoin']
                                        ['mercadobitcoin']['name'],
                                    globalData.data['results']['bitcoin']
                                        ['mercadobitcoin']['buy'],
                                    globalData.data['results']['bitcoin']
                                        ['mercadobitcoin']['variation']),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buildCurrencyColumn(
                                    globalData.data['results']['bitcoin']
                                        ['coinbase']['name'],
                                    globalData.data['results']['bitcoin']
                                        ['coinbase']['last'],
                                    globalData.data['results']['bitcoin']
                                        ['coinbase']['variation']),
                                const SizedBox(height: 20),
                                _buildCurrencyColumn(
                                    globalData.data['results']['bitcoin']
                                        ['foxbit']['name'],
                                    globalData.data['results']['bitcoin']
                                        ['foxbit']['last'],
                                    globalData.data['results']['bitcoin']
                                        ['foxbit']['variation']),
                                const SizedBox(height: 66),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[900],
                        ),
                        child: const Text('Página Principal'),
                      ),
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildCurrencyColumn(String currency, double value, double variation) {
    Color variationColor = variation >= 0 ? Colors.blue : Colors.red;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          currency,
          style: const TextStyle(fontSize: 20),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              value.toStringAsFixed(2),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: variationColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                variation.toStringAsFixed(3),
                style: const TextStyle(fontSize: 11, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

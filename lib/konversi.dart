import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({Key? key}) : super(key: key);

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  late double _convertedAmount = 0.0; // Initialize with default value
  String _selectedCurrency = 'USD';
  final Set<String> _currencies = {'USD', 'EUR', 'GBP'};

  @override
  void initState() {
    super.initState();
    _fetchConversionRate();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _fetchConversionRate() async {
    final url = Uri.parse('https://api.exchangerate-api.com/v4/latest/IDR');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final rates = jsonResponse['rates'];

      setState(() {
        _currencies.addAll(rates.keys.toList());
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void _convertCurrency() {
    final double? amount = double.tryParse(_amountController.text);
    if (amount != null) {
      final url = Uri.parse('https://api.exchangerate-api.com/v4/latest/IDR');
      http.get(url).then((response) {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final rates = jsonResponse['rates'];
          final conversionRate = rates[_selectedCurrency];

          setState(() {
            _convertedAmount = amount * conversionRate;
          });
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter amount in IDR',
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedCurrency,
              onChanged: (newValue) {
                setState(() {
                  _selectedCurrency = newValue!;
                });
              },
              items: _currencies.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16.0),
            Text('Converted Amount: $_convertedAmount $_selectedCurrency',
                style: const TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}

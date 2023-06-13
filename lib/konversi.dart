import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const color1 = Color(0xff0b2545);
const color2 = Color(0xff8da9c4);
const color3 = Color(0xffeef4ed);

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
        centerTitle: true,
        backgroundColor: color1,
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(
                    255, 44, 66, 192), // Set the desired color for the button
              ),
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

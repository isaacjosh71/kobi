import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kobi/data/repository/url_configs.dart';
import '../model/transaction_model.dart';

class TransactionRepository {
  Future<List<Transaction>> fetchTransactions() async {
    final jsonString = await rootBundle.loadString(Config.baseUrl);
    final List<dynamic> data = json.decode(jsonString);
    return data.map((json) => Transaction.fromJson(json)).toList();
  }
}

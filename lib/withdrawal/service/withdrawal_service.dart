import "dart:convert";

import "package:http/http.dart" as http;
import "package:riverpass/balance/model/balance.dart";
import "package:riverpass/logger/logger.dart";

class WithdrawalService {
  Future<Balance> withdraw(String userId, String currency, int amount) async {
    try {
      logger.i('withdraw: $userId, $currency, $amount');
      final uri = Uri.parse('https://api-dev.riverbank.world/v1/withdrawalHistory');
      final newBalance = await http.post(uri, headers: {
        'Content-Type': 'application/json'
      }, body: jsonEncode({
        'user_id': userId,
        'currency': currency,
        'amount': amount,
      }));

      final jsonData = jsonDecode(newBalance.body);
      print(jsonData);
      return Balance(currency: jsonData['currency'], amount: jsonData['amount']);
    } catch (err) {
      logger.e('withdraw error: $err}');
      rethrow;
    }
  }
}
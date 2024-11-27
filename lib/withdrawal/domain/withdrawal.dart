import 'package:riverpass/balance/repository/balance_repository.dart';
import 'package:riverpass/logger/logger.dart';

class Withdrawal {
  Future<void> doWithdraw(BalanceRepository balanceRepository, String userId, String currency, int amount) async {
    try {
      AppLogger.i('Withdrawal', 'Withdrawal');
      await balanceRepository.withdraw(userId, 'KRW', amount);
    } catch (err) {
      AppLogger.e('Withdrawal', '$err');
      rethrow;
    }
  }
}
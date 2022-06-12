import 'package:delivery_app/ShoppingCartPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  group('Shopping cart calculate total test', () {
    test('the total should be 106', () {
      List<num> prices = [2.5, 4.5, 7.6, 9.1];
      List<int> cant = [3, 4, 7, 3];
      ShoppingCartPageState.calculate_total(prices, cant);
      expect(ShoppingCartPageState.total.ceil() == 106, true);
    });
  });
}

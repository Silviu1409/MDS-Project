import 'package:delivery_app/ProductPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  group('Increase/decrease number of products test', () {
    //test product number increase
    test('the number of products should be increased', () {
      var nr_prod = ProductPageState.nr_prod;
      ProductPageState.increase();
      expect(nr_prod + 1 == ProductPageState.nr_prod, true);
    });

    //test product number decrease
    test('the number of products should be decreased', () {
      var nr_prod = ProductPageState.nr_prod;
      ProductPageState.decrease();
      expect(nr_prod - 1 == ProductPageState.nr_prod, true);
    });
  });
}

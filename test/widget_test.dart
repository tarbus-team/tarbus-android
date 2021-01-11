// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:tarbus2021/src/utils/date_utils.dart';

void main() {
  test('Sprawdzam datę', () {
    var samlpeDate = DateTime(2021, 1, 15);
    var dayType = 1;
    expect(DateUtils.isToday(dayType, dateTest: samlpeDate), true);
    dayType = 2;
    expect(DateUtils.isToday(dayType, dateTest: samlpeDate), false);
    dayType = 3;
    expect(DateUtils.isToday(dayType, dateTest: samlpeDate), true);
    dayType = 4;
    expect(DateUtils.isToday(dayType, dateTest: samlpeDate), true);
    dayType = 5;
    expect(DateUtils.isToday(dayType, dateTest: samlpeDate), true);
    dayType = 6;
    expect(DateUtils.isToday(dayType, dateTest: samlpeDate), false);
    dayType = 7;
    expect(DateUtils.isToday(dayType, dateTest: samlpeDate), false);
    dayType = 8;
    expect(DateUtils.isToday(dayType, dateTest: samlpeDate), false);
  });
}

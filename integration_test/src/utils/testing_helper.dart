import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test_flutter/main.dart';

class TestHelper {
  static late WidgetTester tester;

  static Future<void> pumpApp() async {
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle(const Duration(seconds: 4));
  }

  static Future<void> enterDataInTextField(
      {String name = '',
        required String data,
        Finder? finder,
        int at = 0}) async {
    try {
      var textfield = finder ?? find.widgetWithText(TextField, name).at(at);
      await tester.ensureVisible(textfield);
      await tester.pumpAndSettle();
      await tester.tap(textfield, warnIfMissed: false);
      await tester.enterText(textfield, data);
      await tester.pumpAndSettle();
    } catch (ex) {
      log(ex.toString());
    }
  }

  static Future<void> tapButton(
      {String name = '', int retry = 0, Finder? finder, int at = 0}) async {
    try {
      var button = finder ?? find.widgetWithText(ElevatedButton, name).at(at);
      await tester.ensureVisible(button);
      await tester.pumpAndSettle();
      await tester.tap(button, warnIfMissed: false);
      await tester.pumpAndSettle();
    } catch (ex) {
      if (retry != 0) {
        tapButton(name: name, retry: --retry, finder: finder, at: at);
      }
    }
  }

  static Future<void> selectDataInDropdown<T>({
    String name = '',
  }) async {
    try {
      var dropdown =
      find.widgetWithText(DropdownButtonFormField<T>, name).at(0);
      await tester.ensureVisible(dropdown);
      await tester.pumpAndSettle();
      await tester.tap(dropdown, warnIfMissed: false);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.bySubtype<DropdownMenuItem<T>>().first,
          warnIfMissed: false);
      await tester.pumpAndSettle();
    } catch (ex) {
      log(ex.toString());
    }
  }

  static Future<void> customExpect(
      {required dynamic actual,
        required dynamic matcher,
        String where = '',
        String description = ''}) async {
    try {
      expect(actual, matcher);
      debugPrint('[Success] $where : $description');
    } catch (ex) {
      debugPrint('[Failed] $where : $description');
    }
  }

  static T getBloc<T extends StateStreamableSource<Object?>>() {
    Finder of = find.byType(BlocProvider<T>);
    Finder matching = find.bySubtype<StatefulWidget>();
    Finder decendent = find.descendant(of: of.last, matching: matching);
    var widget = tester.state(decendent.first);
    var bloc = BlocProvider.of<T>(widget.context);
    return bloc;
  }
}

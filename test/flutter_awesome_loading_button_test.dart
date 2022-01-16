import 'package:flutter/material.dart';
import 'package:flutter_awesome_loading_button/flutter_awesome_loading_button.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Loading Test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AwesomeLoadingButton(
              onPressed: () async {
                await Future.delayed(
                  const Duration(
                    seconds: 5,
                  ),
                );
              },
              text: 'Fetch',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final button = find.byType(MaterialButton);
      expect(button, findsOneWidget);

      await tester.tap(
        button,
      );
      await tester.pump();

      final loadingIndicator = find.byType(CircularProgressIndicator);
      expect(loadingIndicator, findsOneWidget);
      await Future.delayed(
        const Duration(seconds: 6),
      );
      await tester.pump();
      expect(
        button,
        find.byType(
          MaterialButton,
        ),
      );
    },
  );
}

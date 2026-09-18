import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rppay/app/app.dart';

void main() {
  testWidgets('o app inicia na Splash e navega para a navegação principal', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const App());

    // Splash screen exibida imediatamente.
    expect(find.text('RPPay'), findsOneWidget);

    // Aguarda o delay da SplashCubit e a navegação por FadeTransition.
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();

    // A navegação principal (bottom NavigationBar) deve estar visível.
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });
}

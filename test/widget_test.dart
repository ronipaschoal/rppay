import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rppay/app/app.dart';
import 'package:webview_page/testing.dart';
import 'package:webview_page/webview_page.dart';

void main() {
  testWidgets('o app inicia na Splash e navega para a navegação principal', (
    WidgetTester tester,
  ) async {
    FakeWebViewPlatform.install();
    await tester.pumpWidget(const App());

    // Splash screen exibida imediatamente.
    expect(find.text('RPPay'), findsOneWidget);

    // Aguarda o delay da SplashCubit e a navegação por FadeTransition.
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();

    // Aguarda os menus da API simulada e o carregamento das abas.
    await tester.pump(const Duration(milliseconds: 500));

    // A navegação principal (bottom NavigationBar) deve estar visível.
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    // O menu webview vindo da API abre a página web.
    await tester.tap(find.text('Card'));
    await tester.pump();
    expect(find.byType(WebViewPage).hitTestable(), findsOneWidget);
  });
}

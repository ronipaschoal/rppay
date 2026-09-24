import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/core/widgets/device_frame.dart';

void main() {
  Future<void> pumpFrame(WidgetTester tester, Size surfaceSize) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = surfaceSize;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => DeviceFrame(child: child!),
        home: Builder(
          builder: (context) {
            final mediaQuery = MediaQuery.of(context);
            return Text(
              '${mediaQuery.size.width.toInt()}x'
              '${mediaQuery.size.height.toInt()} '
              'top:${mediaQuery.padding.top.toInt()}',
            );
          },
        ),
      ),
    );
  }

  testWidgets('em telas mobile, renderiza o conteúdo sem moldura', (
    tester,
  ) async {
    await pumpFrame(tester, const Size(400, 800));

    expect(find.text('400x800 top:0'), findsOneWidget);
    expect(find.byType(ClipRRect), findsNothing);
  });

  testWidgets('em telas maiores, exibe o conteúdo no tamanho de celular', (
    tester,
  ) async {
    await pumpFrame(tester, const Size(1440, 1000));

    final size = DeviceFrame.screenSize;
    final top = DeviceFrame.screenPadding.top;
    expect(
      find.text(
        '${size.width.toInt()}x${size.height.toInt()} top:${top.toInt()}',
      ),
      findsOneWidget,
    );
    expect(find.byType(ClipRRect), findsOneWidget);
  });

  testWidgets('em janelas baixas, reduz a moldura para caber na tela', (
    tester,
  ) async {
    await pumpFrame(tester, const Size(1024, 600));

    final frame = tester.getSize(find.byType(ClipRRect));
    final rendered = tester.getRect(find.byType(ClipRRect));
    expect(frame, DeviceFrame.screenSize);
    expect(rendered.height, lessThanOrEqualTo(600));
    expect(tester.takeException(), isNull);
  });
}

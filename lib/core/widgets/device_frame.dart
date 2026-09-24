import 'package:flutter/material.dart';

/// Em telas maiores que mobile (tablet, desktop, web), exibe o app no
/// tamanho de um celular dentro de uma moldura que simula o aparelho.
/// Em telas mobile, renderiza o [child] sem alterações.
class DeviceFrame extends StatelessWidget {
  final Widget child;

  const DeviceFrame({super.key, required this.child});

  /// Largura a partir da qual a tela deixa de ser considerada mobile.
  static const double breakpoint = 600;

  /// Tamanho lógico da tela do celular simulado.
  static const Size screenSize = Size(390, 844);

  /// Área ocupada pela status bar (topo) e pelo home indicator (base).
  static const EdgeInsets screenPadding = EdgeInsets.only(top: 47, bottom: 34);

  static const double _bezel = 12;
  static const double _screenRadius = 44;
  static const double _outerMargin = 24;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) return child;

        final mediaQuery = MediaQuery.of(context);

        return ColoredBox(
          color: const Color(0xFFE3E7ED),
          child: Padding(
            padding: const EdgeInsets.all(_outerMargin),
            // Reduz a moldura proporcionalmente quando a janela é baixa.
            child: FittedBox(
              child: Container(
                padding: const EdgeInsets.all(_bezel),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(_screenRadius + _bezel),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 40,
                      offset: Offset(0, 16),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_screenRadius),
                  child: SizedBox.fromSize(
                    size: screenSize,
                    child: MediaQuery(
                      data: mediaQuery.copyWith(
                        size: screenSize,
                        padding: screenPadding,
                        viewPadding: screenPadding,
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(child: child),
                          const _Notch(),
                          const _HomeIndicator(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Notch extends StatelessWidget {
  const _Notch();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: IgnorePointer(
        child: Container(
          margin: const EdgeInsets.only(top: 11),
          width: 120,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: IgnorePointer(
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          width: 134,
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0x99000000),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}

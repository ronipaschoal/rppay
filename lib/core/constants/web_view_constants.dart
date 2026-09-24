class WebViewConstants {
  /// Hosts que as webviews do app podem abrir (`*.` = qualquer subdomínio).
  /// Segunda linha de defesa caso a API envie uma url inesperada.
  static const List<String> allowedHosts = ['webview.ronipaschoal.com.br'];
}

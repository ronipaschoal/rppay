enum NavigationMenuType {
  /// Página nativa do app, identificada por [NavigationMenuEntity.route].
  page,

  /// Página web carregada de [NavigationMenuEntity.url].
  webview,

  /// Abre o menu lateral em vez de trocar de aba.
  drawer,
}

class NavigationMenuEntity {
  final String label;

  /// Nome do ícone; o app traduz para um ícone conhecido.
  final String icon;
  final NavigationMenuType type;

  /// Preenchido quando [type] é [NavigationMenuType.page].
  final String? route;

  /// Preenchido quando [type] é [NavigationMenuType.webview].
  final String? url;

  const NavigationMenuEntity({
    required this.label,
    required this.icon,
    required this.type,
    this.route,
    this.url,
  });
}

import '../../domain/entities/navigation_menu_entity.dart';

class NavigationMenuModel extends NavigationMenuEntity {
  const NavigationMenuModel({
    required super.label,
    required super.icon,
    required super.type,
    super.route,
    super.url,
  });

  /// Retorna `null` quando o menu é inválido ou o `type` não é conhecido por
  /// esta versão do app, permitindo que o backend envie novos menus sem
  /// quebrar clientes antigos.
  static NavigationMenuModel? fromJson(Map<String, dynamic> json) {
    final type = NavigationMenuType.values.asNameMap()[json['type']];
    final label = json['label'];
    final icon = json['icon'];
    final route = json['route'];
    final url = json['url'];

    return switch ((type, label, icon)) {
      (NavigationMenuType.page, String label, String icon)
          when route is String =>
        NavigationMenuModel(
          label: label,
          icon: icon,
          type: type!,
          route: route,
        ),
      (NavigationMenuType.webview, String label, String icon)
          when url is String =>
        NavigationMenuModel(label: label, icon: icon, type: type!, url: url),
      (NavigationMenuType.drawer, String label, String icon) =>
        NavigationMenuModel(label: label, icon: icon, type: type!),
      _ => null,
    };
  }

  Map<String, dynamic> toJson() => {
    'label': label,
    'icon': icon,
    'type': type.name,
    'route': ?route,
    'url': ?url,
  };
}

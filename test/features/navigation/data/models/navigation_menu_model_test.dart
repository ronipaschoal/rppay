import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/navigation/data/models/navigation_menu_model.dart';
import 'package:rppay/features/navigation/domain/entities/navigation_menu_entity.dart';

void main() {
  group('NavigationMenuModel', () {
    test('fromJson converte um menu de página nativa', () {
      final model = NavigationMenuModel.fromJson({
        'type': 'page',
        'label': 'Pix',
        'icon': 'pix',
        'route': 'pix',
      });

      expect(model?.type, NavigationMenuType.page);
      expect(model?.label, 'Pix');
      expect(model?.icon, 'pix');
      expect(model?.route, 'pix');
      expect(model?.url, isNull);
    });

    test('fromJson converte um menu de webview', () {
      final model = NavigationMenuModel.fromJson({
        'type': 'webview',
        'label': 'Site',
        'icon': 'web',
        'url': 'https://flutter.dev',
      });

      expect(model?.type, NavigationMenuType.webview);
      expect(model?.url, 'https://flutter.dev');
      expect(model?.route, isNull);
    });

    test('fromJson retorna null para menus inválidos', () {
      final invalid = [
        {'type': 'cards', 'label': 'Cartões', 'icon': 'card'},
        {'type': 'page', 'label': 'Home', 'icon': 'home'},
        {'type': 'webview', 'label': 'Site', 'icon': 'web'},
        {'type': 'drawer', 'icon': 'menu'},
        {'type': 'drawer', 'label': 'Menu'},
      ];

      for (final json in invalid) {
        expect(NavigationMenuModel.fromJson(json), isNull, reason: '$json');
      }
    });

    test('toJson é o inverso de fromJson', () {
      final jsons = [
        {'label': 'Home', 'icon': 'home', 'type': 'page', 'route': 'home'},
        {
          'label': 'Site',
          'icon': 'web',
          'type': 'webview',
          'url': 'https://flutter.dev',
        },
        {'label': 'Menu', 'icon': 'menu', 'type': 'drawer'},
      ];

      for (final json in jsons) {
        expect(NavigationMenuModel.fromJson(json)?.toJson(), json);
      }
    });
  });
}

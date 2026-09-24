import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/navigation/data/repositories/navigation_repository_impl.dart';
import 'package:rppay/features/navigation/domain/entities/navigation_menu_entity.dart';

void main() {
  group('NavigationRepositoryImpl', () {
    test('getMenus retorna os menus simulados da API', () async {
      final menus = await NavigationRepositoryImpl().getMenus();

      expect(menus.map((m) => m.label), ['Home', 'Pix', 'Card', 'Menu']);
      expect(menus.map((m) => m.type), [
        NavigationMenuType.page,
        NavigationMenuType.page,
        NavigationMenuType.webview,
        NavigationMenuType.drawer,
      ]);
      expect(
        menus[2].url,
        'https://webview.ronipaschoal.com.br/rppay/card?name={user.firstName}',
      );
      expect(menus[2].icon, 'credit_card');
    });
  });
}

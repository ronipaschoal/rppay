import '../../domain/entities/navigation_menu_entity.dart';
import '../../domain/repositories/navigation_repository.dart';
import '../models/navigation_menu_model.dart';

class NavigationRepositoryImpl implements NavigationRepository {
  @override
  Future<List<NavigationMenuEntity>> getMenus() async {
    // Simula a chamada à API (ex.: GET /menus).
    await Future.delayed(const Duration(milliseconds: 300));
    const response = [
      {'type': 'page', 'label': 'Home', 'icon': 'home', 'route': 'home'},
      {'type': 'page', 'label': 'Pix', 'icon': 'pix', 'route': 'pix'},
      {
        'type': 'webview',
        'label': 'Card',
        'icon': 'credit_card',
        'url':
            'https://webview.ronipaschoal.com.br/rppay/card?name={user.name}',
      },
      {'type': 'drawer', 'label': 'Menu', 'icon': 'menu'},
    ];

    return response
        .map(NavigationMenuModel.fromJson)
        .whereType<NavigationMenuModel>()
        .toList();
  }
}

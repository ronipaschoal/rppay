import '../entities/navigation_menu_entity.dart';

abstract class NavigationRepository {
  Future<List<NavigationMenuEntity>> getMenus();
}

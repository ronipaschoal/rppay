import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../../user/domain/repositories/user_repository.dart';
import '../../domain/entities/navigation_menu_entity.dart';
import '../../domain/repositories/navigation_repository.dart';
import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final NavigationRepository repository;
  final UserRepository userRepository;

  /// Rotas de páginas nativas que o app sabe exibir; menus `page` com outras
  /// rotas são descartados.
  final Set<String> pageRoutes;

  NavigationCubit({
    required this.repository,
    required this.userRepository,
    required this.pageRoutes,
  }) : super(const NavigationInitialState());

  static final _placeholder = RegExp(r'\{([\w.]+)\}');

  Future<void> loadMenus() async {
    emit(const NavigationLoadingState());
    try {
      final (menus, user) = await (
        repository.getMenus(),
        userRepository.getUser(),
      ).wait;
      final visibleMenus = menus
          .where(
            (menu) =>
                menu.type != NavigationMenuType.page ||
                pageRoutes.contains(menu.route),
          )
          .map((menu) => _resolveUrl(menu, user))
          .nonNulls
          .toList();
      final firstPage = visibleMenus.indexWhere(
        (menu) => menu.type != NavigationMenuType.drawer,
      );
      // O NavigationBar exige ao menos 2 destinos e uma aba de conteúdo.
      if (visibleMenus.length < 2 || firstPage == -1) {
        emit(const NavigationErrorState('Nenhum menu disponível'));
        return;
      }
      emit(
        NavigationSuccessState(
          menus: visibleMenus,
          user: user,
          currentIndex: firstPage,
        ),
      );
    } on ParallelWaitError catch (e) {
      final (menusError, userError) = e.errors;
      final error = menusError ?? userError;
      emit(NavigationErrorState('Erro ao carregar menus: ${error?.error}'));
    } catch (e) {
      emit(NavigationErrorState('Erro ao carregar menus: ${e.toString()}'));
    }
  }

  /// Troca os marcadores `{user.<campo>}` da url pelos dados do usuário,
  /// codificados para url. Retorna `null` (menu descartado) se a url tiver um
  /// marcador desconhecido.
  NavigationMenuEntity? _resolveUrl(
    NavigationMenuEntity menu,
    UserEntity user,
  ) {
    final url = menu.url;
    if (url == null || !_placeholder.hasMatch(url)) return menu;

    final values = {
      'user.name': user.name,
      'user.firstName': user.firstName,
      'user.agency': user.agency,
      'user.account': user.account,
    };
    final placeholders = _placeholder.allMatches(url).map((m) => m[1]);
    if (!placeholders.every(values.containsKey)) return null;

    return NavigationMenuEntity(
      label: menu.label,
      icon: menu.icon,
      type: menu.type,
      route: menu.route,
      url: url.replaceAllMapped(
        _placeholder,
        (m) => Uri.encodeComponent(values[m[1]]!),
      ),
    );
  }

  void changeTab(int index) {
    final current = state;
    if (current is! NavigationSuccessState ||
        current.currentIndex == index ||
        index < 0 ||
        index >= current.menus.length ||
        current.menus[index].type == NavigationMenuType.drawer) {
      return;
    }
    emit(
      NavigationSuccessState(
        menus: current.menus,
        user: current.user,
        currentIndex: index,
      ),
    );
  }

  /// Seleciona a aba da página nativa [route], independente da posição
  /// definida pela API.
  void selectPage(String route) {
    final current = state;
    if (current is! NavigationSuccessState) return;
    changeTab(
      current.menus.indexWhere(
        (menu) => menu.type == NavigationMenuType.page && menu.route == route,
      ),
    );
  }
}

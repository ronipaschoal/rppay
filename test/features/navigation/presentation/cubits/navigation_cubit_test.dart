import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/navigation/domain/entities/navigation_menu_entity.dart';
import 'package:rppay/features/navigation/domain/repositories/navigation_repository.dart';
import 'package:rppay/features/navigation/presentation/cubits/navigation_cubit.dart';
import 'package:rppay/features/navigation/presentation/cubits/navigation_state.dart';
import 'package:rppay/features/user/domain/entities/user_entity.dart';
import 'package:rppay/features/user/domain/repositories/user_repository.dart';

class _FakeNavigationRepository implements NavigationRepository {
  _FakeNavigationRepository({this.menus, this.error});

  final List<NavigationMenuEntity>? menus;
  final Object? error;

  @override
  Future<List<NavigationMenuEntity>> getMenus() async {
    if (error != null) throw error!;
    return menus ?? const [];
  }
}

class _FakeUserRepository implements UserRepository {
  _FakeUserRepository({this.error});

  final Object? error;

  @override
  Future<UserEntity> getUser() async {
    if (error != null) throw error!;
    return user;
  }
}

const user = UserEntity(
  name: 'Maria da Silva',
  agency: '0001',
  account: '123456-7',
);

void main() {
  const home = NavigationMenuEntity(
    label: 'Home',
    icon: 'home',
    type: NavigationMenuType.page,
    route: 'home',
  );
  const pix = NavigationMenuEntity(
    label: 'Pix',
    icon: 'pix',
    type: NavigationMenuType.page,
    route: 'pix',
  );
  const site = NavigationMenuEntity(
    label: 'Site',
    icon: 'web',
    type: NavigationMenuType.webview,
    url: 'https://flutter.dev',
  );
  const drawer = NavigationMenuEntity(
    label: 'Menu',
    icon: 'menu',
    type: NavigationMenuType.drawer,
  );
  const menus = [home, pix, site, drawer];
  const pageRoutes = {'home', 'pix'};

  NavigationCubit buildCubit([List<NavigationMenuEntity> items = menus]) =>
      NavigationCubit(
        repository: _FakeNavigationRepository(menus: items),
        userRepository: _FakeUserRepository(),
        pageRoutes: pageRoutes,
      );

  group('NavigationCubit', () {
    test('estado inicial é NavigationInitialState', () {
      final cubit = buildCubit();
      expect(cubit.state, const NavigationInitialState());
      cubit.close();
    });

    blocTest<NavigationCubit, NavigationState>(
      'loadMenus emite [Loading, Success] com os menus da API',
      build: buildCubit,
      act: (cubit) => cubit.loadMenus(),
      expect: () => [
        const NavigationLoadingState(),
        const NavigationSuccessState(user: user, menus: menus, currentIndex: 0),
      ],
    );

    blocTest<NavigationCubit, NavigationState>(
      'loadMenus seleciona o primeiro menu que não é o drawer',
      build: () => buildCubit(const [drawer, pix, home]),
      act: (cubit) => cubit.loadMenus(),
      expect: () => [
        const NavigationLoadingState(),
        const NavigationSuccessState(
          user: user,
          menus: [drawer, pix, home],
          currentIndex: 1,
        ),
      ],
    );

    blocTest<NavigationCubit, NavigationState>(
      'loadMenus descarta páginas nativas que o app não conhece',
      build: () => buildCubit(const [
        home,
        NavigationMenuEntity(
          label: 'Cartões',
          icon: 'card',
          type: NavigationMenuType.page,
          route: 'cards',
        ),
        site,
      ]),
      act: (cubit) => cubit.loadMenus(),
      expect: () => [
        const NavigationLoadingState(),
        const NavigationSuccessState(
          user: user,
          menus: [home, site],
          currentIndex: 0,
        ),
      ],
    );

    blocTest<NavigationCubit, NavigationState>(
      'loadMenus emite erro quando a API retorna menos de 2 menus',
      build: () => buildCubit(const [home]),
      act: (cubit) => cubit.loadMenus(),
      expect: () => [
        const NavigationLoadingState(),
        const NavigationErrorState('Nenhum menu disponível'),
      ],
    );

    blocTest<NavigationCubit, NavigationState>(
      'loadMenus emite erro quando o repositório falha',
      build: () => NavigationCubit(
        repository: _FakeNavigationRepository(error: Exception('falha')),
        userRepository: _FakeUserRepository(),
        pageRoutes: pageRoutes,
      ),
      act: (cubit) => cubit.loadMenus(),
      expect: () => [
        const NavigationLoadingState(),
        isA<NavigationErrorState>(),
      ],
    );

    blocTest<NavigationCubit, NavigationState>(
      'loadMenus emite erro quando o usuário não carrega',
      build: () => NavigationCubit(
        repository: _FakeNavigationRepository(menus: menus),
        userRepository: _FakeUserRepository(error: Exception('falha')),
        pageRoutes: pageRoutes,
      ),
      act: (cubit) => cubit.loadMenus(),
      expect: () => [
        const NavigationLoadingState(),
        isA<NavigationErrorState>(),
      ],
    );

    group('url dinâmica', () {
      NavigationMenuEntity webview(String url) => NavigationMenuEntity(
        label: 'Card',
        icon: 'credit_card',
        type: NavigationMenuType.webview,
        url: url,
      );

      Future<List<NavigationMenuEntity>> loadWith(String url) async {
        final cubit = buildCubit([home, webview(url)]);
        await cubit.loadMenus();
        final state = cubit.state;
        await cubit.close();
        return state is NavigationSuccessState ? state.menus : const [];
      }

      test('troca os marcadores pelos dados do usuário', () async {
        final menus = await loadWith(
          'https://example.com/card?first={user.firstName}&name={user.name}'
          '&ag={user.agency}&conta={user.account}',
        );

        expect(
          menus.last.url,
          'https://example.com/card?first=Maria&name=Maria%20da%20Silva'
          '&ag=0001&conta=123456-7',
        );
        expect(menus.last.label, 'Card');
        expect(menus.last.icon, 'credit_card');
      });

      test('descarta o menu com marcador desconhecido', () async {
        final menus = await loadWith('https://example.com/?cpf={user.cpf}');

        expect(menus, isEmpty); // Sobra só 1 menu, então vira erro.
      });

      test('mantém o mesmo menu quando a url não tem marcadores', () async {
        final menus = await loadWith('https://example.com/');

        expect(menus.last.url, 'https://example.com/');
      });
    });

    blocTest<NavigationCubit, NavigationState>(
      'changeTab emite um novo estado quando o índice muda',
      build: buildCubit,
      seed: () => const NavigationSuccessState(
        user: user,
        menus: menus,
        currentIndex: 0,
      ),
      act: (cubit) => cubit.changeTab(1),
      expect: () => [
        const NavigationSuccessState(user: user, menus: menus, currentIndex: 1),
      ],
    );

    blocTest<NavigationCubit, NavigationState>(
      'changeTab ignora índice igual ao atual, inválido ou do drawer',
      build: buildCubit,
      seed: () => const NavigationSuccessState(
        user: user,
        menus: menus,
        currentIndex: 0,
      ),
      act: (cubit) => cubit
        ..changeTab(0)
        ..changeTab(3)
        ..changeTab(5),
      expect: () => <NavigationState>[],
    );

    blocTest<NavigationCubit, NavigationState>(
      'changeTab não faz nada antes dos menus carregarem',
      build: buildCubit,
      act: (cubit) => cubit.changeTab(1),
      expect: () => <NavigationState>[],
    );

    blocTest<NavigationCubit, NavigationState>(
      'selectPage seleciona a aba pela rota',
      build: buildCubit,
      seed: () => const NavigationSuccessState(
        user: user,
        menus: [pix, home],
        currentIndex: 0,
      ),
      act: (cubit) => cubit.selectPage('home'),
      expect: () => [
        const NavigationSuccessState(
          user: user,
          menus: [pix, home],
          currentIndex: 1,
        ),
      ],
    );
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_page/webview_page.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/web_view_constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../../../user/data/repositories/user_repository_impl.dart';
import '../../data/repositories/navigation_repository_impl.dart';
import '../../domain/entities/navigation_menu_entity.dart';
import '../cubits/navigation_cubit.dart';
import '../cubits/navigation_state.dart';
import 'navigation_registry.dart';

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(
        repository: NavigationRepositoryImpl(),
        userRepository: UserRepositoryImpl(),
        pageRoutes: navigationPages.keys.toSet(),
      )..loadMenus(),
      child: const MainNavigationView(),
    );
  }
}

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Rotas usadas pelo CustomDrawer (0 = Início, 1 = Área Pix).
  static const _drawerRoutes = ['home', 'pix'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        if (state is NavigationSuccessState) {
          return _buildNavigation(context, state);
        }

        if (state is NavigationErrorState) {
          return Scaffold(
            body: _ErrorMessage(
              message: state.message,
              onRetry: () => context.read<NavigationCubit>().loadMenus(),
            ),
          );
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _buildNavigation(BuildContext context, NavigationSuccessState state) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        userName: state.user.name,
        accountDescription:
            'Ag: ${state.user.agency} | Conta: ${state.user.account}',
        onSelectTab: (index) {
          context.read<NavigationCubit>().selectPage(_drawerRoutes[index]);
        },
      ),
      body: IndexedStack(
        index: state.currentIndex,
        children: [
          for (final (index, menu) in state.menus.indexed)
            _pageFor(menu, isSelected: index == state.currentIndex),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: state.currentIndex,
        onDestinationSelected: (int index) {
          if (state.menus[index].type == NavigationMenuType.drawer) {
            _scaffoldKey.currentState?.openDrawer();
          } else {
            context.read<NavigationCubit>().changeTab(index);
          }
        },
        destinations: state.menus.map(_destinationFor).toList(),
      ),
    );
  }
}

Widget _pageFor(NavigationMenuEntity menu, {required bool isSelected}) {
  return switch (menu) {
    NavigationMenuEntity(type: NavigationMenuType.page, :final route?) =>
      navigationPages[route] ?? const SizedBox.shrink(),
    NavigationMenuEntity(type: NavigationMenuType.webview, :final url?) =>
      WebViewPage(
        url: url,
        title: menu.label,
        allowedHosts: WebViewConstants.allowedHosts,
        // Abas escondidas no IndexedStack não devem capturar o botão voltar.
        handleBackNavigation: isSelected,
        errorBuilder: (context, error, retry) => _ErrorMessage(
          message: 'Não foi possível carregar a página',
          onRetry: retry,
        ),
      ),
    // O menu "drawer" apenas abre o CustomDrawer, não tem página própria.
    _ => const SizedBox.shrink(),
  };
}

NavigationDestination _destinationFor(NavigationMenuEntity menu) {
  final (icon, selectedIcon) =
      navigationIcons[menu.icon] ?? navigationFallbackIcon;
  return NavigationDestination(
    icon: Icon(icon),
    selectedIcon: Icon(selectedIcon, color: AppColors.primary),
    label: menu.label,
  );
}

class _ErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorMessage({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, style: const TextStyle(color: AppColors.error)),
            const SizedBox(height: 16),
            CustomButton(label: 'Tentar Novamente', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}

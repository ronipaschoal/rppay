import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int)? onSelectTab;
  final String userName;
  final String accountDescription;

  const CustomDrawer({
    super.key,
    this.onSelectTab,
    required this.userName,
    required this.accountDescription,
  });

  String get _initials => userName
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primary),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                _initials,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            accountName: Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: Text(accountDescription),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined, color: AppColors.primary),
            title: const Text('Início'),
            onTap: () {
              Navigator.pop(context);
              onSelectTab?.call(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.pix_outlined, color: AppColors.primary),
            title: const Text('Área Pix'),
            onTap: () {
              Navigator.pop(context);
              onSelectTab?.call(1);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.receipt_long_outlined,
              color: AppColors.primary,
            ),
            title: const Text('Extrato e Comprovantes'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sessão Extrato em desenvolvimento'),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.credit_card_outlined,
              color: AppColors.primary,
            ),
            title: const Text('Meus Cartões'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sessão Cartões em desenvolvimento'),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.settings_outlined,
              color: AppColors.textSecondary,
            ),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Configurações em breve')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text(
              'Sair da conta',
              style: TextStyle(color: AppColors.error),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

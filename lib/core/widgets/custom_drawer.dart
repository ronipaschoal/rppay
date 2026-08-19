import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int)? onSelectTab;

  const CustomDrawer({
    super.key,
    this.onSelectTab,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'RP',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            accountName: const Text(
              'Roni Paschoal',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: const Text('Ag: 0001 | Conta: 123456-7'),
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
            leading: const Icon(Icons.receipt_long_outlined, color: AppColors.primary),
            title: const Text('Extrato e Comprovantes'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sessão Extrato em desenvolvimento')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.credit_card_outlined, color: AppColors.primary),
            title: const Text('Meus Cartões'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sessão Cartões em desenvolvimento')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined, color: AppColors.textSecondary),
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

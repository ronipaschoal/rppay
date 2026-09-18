import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  static const _actions = [
    {'icon': Icons.pix, 'label': 'Pix'},
    {'icon': Icons.qr_code_scanner, 'label': 'Pagar'},
    {'icon': Icons.swap_horiz, 'label': 'Transferir'},
    {'icon': Icons.phone_android, 'label': 'Recarga'},
    {'icon': Icons.receipt_long, 'label': 'Cobrar'},
    {'icon': Icons.receipt_long, 'label': 'Cobrar'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _actions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final action = _actions[index];
          return Column(
            children: [
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ação: ${action['label']}')),
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Icon(
                    action['icon'] as IconData,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                action['label'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

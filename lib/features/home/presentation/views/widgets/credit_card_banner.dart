import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class CreditCardBanner extends StatelessWidget {
  final bool showBalance;

  const CreditCardBanner({super.key, required this.showBalance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.credit_card, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    'Cartão de Crédito',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Fatura atual',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            showBalance ? 'R\$ 1.240,50' : 'R\$ ••••••',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Limite disponível: R\$ 8.759,50',
            style: TextStyle(color: AppColors.success, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

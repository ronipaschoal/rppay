import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class BalanceCard extends StatelessWidget {
  final bool showBalance;

  const BalanceCard({super.key, required this.showBalance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saldo disponível',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Icon(
                Icons.account_balance_wallet_outlined,
                color: Colors.white70,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            showBalance ? 'R\$ 12.450,80' : 'R\$ ••••••',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: Colors.greenAccent,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '+12% este mês',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

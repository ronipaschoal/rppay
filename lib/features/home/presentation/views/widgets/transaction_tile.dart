import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../domain/entities/home_data_entity.dart';

class TransactionTile extends StatelessWidget {
  final HomeDataEntity item;

  const TransactionTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;

    switch (item.category) {
      case 'Salário':
        iconData = Icons.work_outline;
        iconColor = Colors.green;
        break;
      case 'Alimentação':
        iconData = Icons.restaurant;
        iconColor = Colors.orange;
        break;
      case 'Transporte':
        iconData = Icons.directions_car_outlined;
        iconColor = Colors.blue;
        break;
      case 'Entretenimento':
        iconData = Icons.movie_outlined;
        iconColor = Colors.purple;
        break;
      case 'Investimentos':
        iconData = Icons.trending_up;
        iconColor = Colors.teal;
        break;
      case 'Saúde':
        iconData = Icons.local_hospital_outlined;
        iconColor = Colors.red;
        break;
      default:
        iconData = item.isIncome ? Icons.arrow_downward : Icons.arrow_upward;
        iconColor = item.isIncome ? Colors.green : Colors.grey;
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.1),
          child: Icon(iconData, color: iconColor, size: 20),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          '${item.description} • ${item.date}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Text(
          '${item.isIncome ? '+' : '-'} R\$ ${item.amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: item.isIncome ? Colors.green : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

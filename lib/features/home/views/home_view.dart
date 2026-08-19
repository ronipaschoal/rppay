import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';
import '../data/repositories/home_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        repository: HomeRepositoryImpl(),
      )..loadData(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _showBalance = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(_showBalance ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _showBalance = !_showBalance;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nenhuma notificação nova')),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    label: 'Tentar Novamente',
                    onPressed: () => context.read<HomeCubit>().loadData(),
                  ),
                ],
              ),
            );
          }

          if (state is HomeSuccessState) {
            return RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().loadData(),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Card de Saldo
                  _buildBalanceCard(),
                  const SizedBox(height: 20),

                  // Ações Rápidas Horizontais
                  _buildQuickActions(context),
                  const SizedBox(height: 24),

                  // Card de Cartão de Crédito
                  _buildCreditCardBanner(context),
                  const SizedBox(height: 20),

                  // Banner de Investimentos
                  _buildInvestmentBanner(context),
                  const SizedBox(height: 24),

                  // Cabeçalho do Extrato
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Histórico de Transações',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Ver tudo'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Lista de Transações
                  ...state.items.map((item) => _buildTransactionTile(item)),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBalanceCard() {
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
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              Icon(Icons.account_balance_wallet_outlined, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _showBalance ? 'R\$ 12.450,80' : 'R\$ ••••••',
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.trending_up, color: Colors.greenAccent, size: 16),
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

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {'icon': Icons.pix, 'label': 'Pix'},
      {'icon': Icons.qr_code_scanner, 'label': 'Pagar'},
      {'icon': Icons.swap_horiz, 'label': 'Transferir'},
      {'icon': Icons.phone_android, 'label': 'Recarga'},
      {'icon': Icons.receipt_long, 'label': 'Cobrar'},
    ];

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final action = actions[index];
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
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCreditCardBanner(BuildContext context) {
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
            _showBalance ? 'R\$ 1.240,50' : 'R\$ ••••••',
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

  Widget _buildInvestmentBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withValues(alpha: 0.15),
            AppColors.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.show_chart, color: AppColors.accent, size: 28),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RP Invest',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 2),
                Text(
                  'Renda fixa rendendo 110% do CDI diariamente.',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(dynamic item) {
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

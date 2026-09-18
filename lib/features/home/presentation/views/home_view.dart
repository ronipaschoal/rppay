import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubits/home_cubit.dart';
import '../cubits/home_state.dart';
import '../../data/repositories/home_repository_impl.dart';
import 'widgets/balance_card.dart';
import 'widgets/credit_card_banner.dart';
import 'widgets/investment_banner.dart';
import 'widgets/quick_actions.dart';
import 'widgets/transaction_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(repository: HomeRepositoryImpl())..loadData(),
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
                  BalanceCard(showBalance: _showBalance),
                  const SizedBox(height: 20),

                  // Ações Rápidas Horizontais
                  const QuickActions(),
                  const SizedBox(height: 24),

                  // Card de Cartão de Crédito
                  CreditCardBanner(showBalance: _showBalance),
                  const SizedBox(height: 20),

                  // Banner de Investimentos
                  const InvestmentBanner(),
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
                  ...state.items.map((item) => TransactionTile(item: item)),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

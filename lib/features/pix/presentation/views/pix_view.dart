import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../cubits/pix_cubit.dart';
import '../cubits/pix_state.dart';
import '../../data/repositories/pix_repository_impl.dart';
import '../../domain/entities/pix_action_entity.dart';

class PixPage extends StatelessWidget {
  const PixPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PixCubit(repository: PixRepositoryImpl())..loadPixActions(),
      child: const PixView(),
    );
  }
}

class PixView extends StatelessWidget {
  const PixView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Área Pix')),
      body: BlocBuilder<PixCubit, PixState>(
        builder: (context, state) {
          if (state is PixLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PixLoadedState) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.pix, size: 40, color: AppColors.primary),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Envie e receba Pix',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Transferências 24h por dia, 7 dias por semana.',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Ações Rápidas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...state.actions.map(
                  (action) => Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.1,
                        ),
                        child: Icon(
                          _iconFor(action.type),
                          color: AppColors.primary,
                        ),
                      ),
                      title: Text(
                        action.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(action.subtitle),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Ação Pix: ${action.title}')),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

IconData _iconFor(PixActionType type) {
  return switch (type) {
    PixActionType.transfer => Icons.send_rounded,
    PixActionType.copyAndPaste => Icons.content_copy_rounded,
    PixActionType.scanQrCode => Icons.qr_code_scanner_rounded,
    PixActionType.charge => Icons.call_received_rounded,
  };
}

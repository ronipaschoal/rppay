import 'package:flutter/material.dart';
import '../models/pix_action_model.dart';

abstract class PixRepository {
  Future<List<PixActionModel>> getPixActions();
}

class PixRepositoryImpl implements PixRepository {
  @override
  Future<List<PixActionModel>> getPixActions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      PixActionModel(
        title: 'Transferir',
        subtitle: 'Pague com chave Pix',
        icon: Icons.send_rounded,
      ),
      PixActionModel(
        title: 'Pix Copia e Cola',
        subtitle: 'Cole o código de pagamento',
        icon: Icons.content_copy_rounded,
      ),
      PixActionModel(
        title: 'Ler QR Code',
        subtitle: 'Escaneie um código Pix',
        icon: Icons.qr_code_scanner_rounded,
      ),
      PixActionModel(
        title: 'Cobrar / Receber',
        subtitle: 'Crie uma cobrança Pix',
        icon: Icons.call_received_rounded,
      ),
    ];
  }
}

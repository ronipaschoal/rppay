import '../../domain/entities/pix_action_entity.dart';
import '../../domain/repositories/pix_repository.dart';
import '../models/pix_action_model.dart';

class PixRepositoryImpl implements PixRepository {
  @override
  Future<List<PixActionEntity>> getPixActions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      PixActionModel(
        title: 'Transferir',
        subtitle: 'Pague com chave Pix',
        type: PixActionType.transfer,
      ),
      PixActionModel(
        title: 'Pix Copia e Cola',
        subtitle: 'Cole o código de pagamento',
        type: PixActionType.copyAndPaste,
      ),
      PixActionModel(
        title: 'Ler QR Code',
        subtitle: 'Escaneie um código Pix',
        type: PixActionType.scanQrCode,
      ),
      PixActionModel(
        title: 'Cobrar / Receber',
        subtitle: 'Crie uma cobrança Pix',
        type: PixActionType.charge,
      ),
    ];
  }
}

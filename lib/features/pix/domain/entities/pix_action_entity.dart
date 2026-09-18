enum PixActionType { transfer, copyAndPaste, scanQrCode, charge }

class PixActionEntity {
  final String title;
  final String subtitle;
  final PixActionType type;

  const PixActionEntity({
    required this.title,
    required this.subtitle,
    required this.type,
  });
}

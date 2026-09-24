import 'package:flutter/material.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../pix/presentation/views/pix_view.dart';

/// Páginas nativas que a API pode referenciar pela `route` de um menu `page`.
/// Para disponibilizar uma nova página, basta registrá-la aqui.
const navigationPages = <String, Widget>{'home': HomePage(), 'pix': PixPage()};

/// Ícones (normal, selecionado) que a API pode referenciar pelo `icon`.
const navigationIcons = <String, (IconData, IconData)>{
  'home': (Icons.home_outlined, Icons.home),
  'pix': (Icons.pix_outlined, Icons.pix),
  'web': (Icons.public_outlined, Icons.public),
  'credit_card': (Icons.credit_card_outlined, Icons.credit_card),
  'menu': (Icons.menu, Icons.menu),
};

/// Usado quando a API envia um ícone desconhecido.
const navigationFallbackIcon = (Icons.apps_outlined, Icons.apps);

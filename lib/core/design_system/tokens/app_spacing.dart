import 'package:flutter/material.dart';

abstract class AppSpacing {
  static const double xxs = 2.0; // 2px
  static const double xs = 4.0; // 4px
  static const double sm = 8.0; // 8px
  static const double md = 16.0; // 16px
  static const double lg = 24.0; // 24px
  static const double xl = 32.0; // 32px
  static const double xxl = 48.0; // 48px
  static const double xxxl = 64.0; // 64px

  // TODO: Créer une widget et fournir une valeur pour créer dynamiquement le spacing
  // K : pour définir les constantes
  // Définir le design system dans le Readme
  static Widget get h2xs => const SizedBox(height: xxs);
  static Widget get hXs => const SizedBox(height: xs);
  static Widget get hSm => const SizedBox(height: sm);
  static Widget get hMd => const SizedBox(height: md);
  static Widget get hLg => const SizedBox(height: lg);
  static Widget get hXl => const SizedBox(height: xl);
  static Widget get h2xl => const SizedBox(height: xxl);

  static Widget get horizontalXxs => const SizedBox(width: xxs);
  static Widget get horizontalXs => const SizedBox(width: xs);
  static Widget get horizontalSm => const SizedBox(width: sm);
  static Widget get horizontalMd => const SizedBox(width: md);
  static Widget get horizontalLg => const SizedBox(width: lg);
  static Widget get horizontalXl => const SizedBox(width: xl);
  static Widget get horizontalXxl => const SizedBox(width: xxl);
}

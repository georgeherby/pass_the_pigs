import 'package:flutter/widgets.dart';
import 'package:pass_the_pigs/l10n/app_localizations.dart';

export 'package:pass_the_pigs/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

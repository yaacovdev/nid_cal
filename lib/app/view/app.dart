import 'package:flutter/material.dart';
import 'package:nidcal/hebrew_calendar.dart';
import 'package:nidcal/l10n/l10n.dart';
import 'package:sizer/sizer.dart';
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HebrewCalendar(),
        );
      },
    );
  }
}

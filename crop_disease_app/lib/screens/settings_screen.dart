import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_provider.dart';
import 'auth/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appProvider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // Language selector
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            subtitle: Text(_languageName(appProvider.locale.languageCode)),
            onTap: () => _showLanguagePicker(context, appProvider),
          ),
          const Divider(),

          // Account
          if (appProvider.isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(l10n.logout, style: const TextStyle(color: Colors.red)),
              onTap: () async {
                await appProvider.logout();
                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (_) => false,
                );
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.login),
              title: Text(l10n.login),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
            ),
        ],
      ),
    );
  }

  String _languageName(String code) {
    switch (code) {
      case 'sw':
        return 'Kiswahili';
      case 'am':
        return 'አማርኛ (Amharic)';
      default:
        return 'English';
    }
  }

  void _showLanguagePicker(BuildContext context, AppProvider appProvider) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LangTile('English', 'en', appProvider),
          _LangTile('Kiswahili', 'sw', appProvider),
          _LangTile('አማርኛ (Amharic)', 'am', appProvider),
        ],
      ),
    );
  }
}

class _LangTile extends StatelessWidget {
  final String label;
  final String code;
  final AppProvider appProvider;

  const _LangTile(this.label, this.code, this.appProvider);

  @override
  Widget build(BuildContext context) {
    final isSelected = appProvider.locale.languageCode == code;
    return ListTile(
      title: Text(label),
      trailing: isSelected ? const Icon(Icons.check, color: Color(0xFF2E7D32)) : null,
      onTap: () {
        appProvider.setLocale(code);
        Navigator.pop(context);
      },
    );
  }
}

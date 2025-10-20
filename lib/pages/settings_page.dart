import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Podešavanja')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Tamna tema'),
            value: theme.isDark,
            onChanged: (_) => theme.toggle(),
            secondary: const Icon(Icons.dark_mode),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Verzija aplikacije'),
            subtitle: Text('0.1.0'),
          ),
        ],
      ),
    );
  }
}
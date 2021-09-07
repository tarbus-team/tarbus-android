import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/config/app_config.dart';

class ThemeModeSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThemeModeSheet();
}

class _ThemeModeSheet extends State<ThemeModeSheet> {
  ThemeMode _selectedTheme = ThemeMode.dark;

  Widget _buildDarkMode(String asset, ThemeMode value, String title) {
    return InkWell(
      onTap: () => setTheme(value),
      child: Container(
        child: Column(
          children: [
            Image(
              width: 80,
              image: AssetImage(asset),
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: AppColors.of(context).fontColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Radio<ThemeMode>(
              value: value,
              groupValue: _selectedTheme,
              onChanged: (ThemeMode? value) => setTheme(value!),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setTheme(ThemeMode mode) async {
    context.read<GetAppConfigUseCaseImpl>().updateTheme(mode);
    setState(() {
      _selectedTheme = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: BoxDecoration(
        color: AppColors.of(context).backgroundDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDarkMode('assets/images/smartphone_black.png', ThemeMode.dark,
                'Tryb ciemny'),
            _buildDarkMode('assets/images/smartphone_white.png',
                ThemeMode.light, 'Tryb jasny'),
            _buildDarkMode(
                'assets/images/smartphone_mix.png', ThemeMode.system, 'System'),
          ],
        ),
      ),
    );
  }
}

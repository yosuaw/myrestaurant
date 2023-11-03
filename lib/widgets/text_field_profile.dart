import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myrestaurant/provider/preferences_provider.dart';
import 'package:provider/provider.dart';

class TextFieldProfile extends StatelessWidget {
  final TextEditingController profileController;
  final String hintText;
  final PreferencesProvider provider;
  final IconData icon;

  const TextFieldProfile(
      {super.key,
      required this.profileController,
      required this.hintText,
      required this.provider,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: profileController,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[800],
              ),
          filled: true,
          fillColor: Colors.grey[300],
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          prefixIcon: Icon(icon)),
      textAlignVertical: TextAlignVertical.center,
    );
  }
}

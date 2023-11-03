import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myrestaurant/common/navigation.dart';
import 'package:myrestaurant/provider/preferences_provider.dart';
import 'package:myrestaurant/provider/scheduling_provider.dart';
import 'package:myrestaurant/widgets/text_field_profile.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return _settingSection(context, provider);
        },
      ),
    );
  }

  Widget _settingSection(
      BuildContext buildContext, PreferencesProvider provider) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Dark Theme',
            style: Theme.of(buildContext).textTheme.labelMedium,
          ),
          trailing: Switch(
            value: false,
            onChanged: (value) {
              showDialog(
                context: buildContext,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Coming Soon!',
                      style: Theme.of(buildContext).textTheme.labelLarge,
                    ),
                    content: Text(
                      'This feature will be coming soon!',
                      style: Theme.of(buildContext).textTheme.labelMedium,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigation.back();
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        ListTile(
          title: Text(
            'Daily Restaurant Recommendation',
            style: Theme.of(buildContext).textTheme.labelMedium,
          ),
          trailing: Consumer<SchedulingProvider>(
            builder: (context, scheduled, child) {
              return Switch(
                value: provider.isDailyReminderActive,
                onChanged: (value) {
                  scheduled.scheduledRestaurant(value);
                  provider.enableDailyReminder(value);

                  value
                      ? Fluttertoast.showToast(
                          msg: "Daily Recommendation: On",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.grey[600],
                          timeInSecForIosWeb: 1,
                        )
                      : Fluttertoast.showToast(
                          msg: "Daily Recommendation: Off",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.grey[600],
                          timeInSecForIosWeb: 1,
                        );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myrestaurant/common/navigation.dart';
import 'package:myrestaurant/common/styles.dart';
import 'package:myrestaurant/provider/preferences_provider.dart';
import 'package:myrestaurant/provider/scheduling_provider.dart';
import 'package:myrestaurant/widgets/text_field_profile.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, child) {
            nameController.text = provider.profileName;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFieldProfile(
                    profileController: nameController,
                    hintText: "Name",
                    provider: provider,
                    icon: Icons.person,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'Save',
                      style:
                          Theme.of(context).textTheme.labelMedium?.copyWith(),
                    ),
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        provider.setProfileName(nameController.text);

                        Fluttertoast.showToast(
                          msg: "Profile updated!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.grey[600],
                          timeInSecForIosWeb: 1,
                        );
                      }
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: Text(
                    'More profile settings coming soon...',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

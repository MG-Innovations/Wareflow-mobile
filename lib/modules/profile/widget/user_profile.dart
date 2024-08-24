import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/profile_api.dart';
import '../model/model_profile.dart';

class UserProfile extends StatefulWidget {
  final String userId;

  const UserProfile({super.key, required this.userId});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ModelProfile? profile;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    ApiProfile apiProfile = ApiProfile();
    final profileData = await apiProfile.fetchUserProfile(widget.userId);

    if (profileData != null) {
      setState(() {
        profile = profileData;
        isLoading = false;
      });
    } else {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  void logoutPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('auth_token');
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? const Center(child: Text('Error loading profile'))
              : Card(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 10),
                      _buildListItem(Icons.business, profile?.name ?? 'N/A'),
                      // _buildListItem(Icons.location_on, 'Location Placeholder'),
                      // _buildListItem(Icons.group, 'Group Placeholder'),
                      _buildListItem(Icons.email, profile?.email ?? 'N/A'),
                      const Divider(),
                      // _listActionButton(
                      // context, 'Change password', Icons.lock_open),
                      // _listActionButton(context, 'Add User', Icons.person_add),
                      const Spacer(),
                      _listActionButton(context, 'Logout', Icons.logout,
                          onTap: () async {
                        logoutPopup();
                      }),
                    ],
                  ),
                ),
    );
  }

  Widget _buildListItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(text),
    );
  }

  Widget _listActionButton(BuildContext context, String text, IconData icon,
      {Function? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(text),
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
    );
  }
}

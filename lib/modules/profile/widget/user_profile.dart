// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:wareflow_mobile/modules/profile/model/model_profile.dart';

// class UserProfile extends StatefulWidget {
//   final String userId;

//   const UserProfile({super.key, required this.userId});

//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }

// class _UserProfileState extends State<UserProfile> {
//   ModelProfile? profile;
//   bool isLoading = true;
//   bool hasError = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'http://13.233.100.211:8000/api/v1/user/29928374-3496-4a30-a619-fc442faf7661'));

//       if (response.statusCode == 200) {
//         final profileJson = jsonDecode(response.body);
//         setState(() {
//           profile = ModelProfile.fromJson(profileJson);
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           hasError = true;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Profile',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : hasError
//               ? const Center(child: Text('Error loading profile'))
//               : Card(
//                   color: Colors.white,
//                   child: ListView(
//                     children: [
//                       const SizedBox(height: 20),
//                       CircleAvatar(
//                         radius: 50,
//                         backgroundColor: Colors.grey.shade300,
//                       ),
//                       const SizedBox(height: 10),
//                       _buildListItem(Icons.business, profile?.name ?? 'N/A'),
//                       _buildListItem(Icons.location_on, 'Location Placeholder'),
//                       _buildListItem(Icons.group, 'Group Placeholder'),
//                       _buildListItem(Icons.email, profile?.email ?? 'N/A'),
//                       const Divider(),
//                       _listActionButton(
//                           context, 'Change password', Icons.lock_open),
//                       _listActionButton(context, 'Add User', Icons.person_add),
//                       _listActionButton(context, 'Logout', Icons.logout),
//                     ],
//                   ),
//                 ),
//     );
//   }

//   Widget _buildListItem(IconData icon, String text) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.grey),
//       title: Text(text),
//     );
//   }

//   Widget _listActionButton(BuildContext context, String text, IconData icon) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.grey),
//       title: Text(text),
//       onTap: () {},
//     );
//   }
// }

// user_profile.dart

import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/profile/api/profile_api.dart';
import 'package:wareflow_mobile/modules/profile/model/model_profile.dart';

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
                      _buildListItem(Icons.location_on, 'Location Placeholder'),
                      _buildListItem(Icons.group, 'Group Placeholder'),
                      _buildListItem(Icons.email, profile?.email ?? 'N/A'),
                      const Divider(),
                      _listActionButton(
                          context, 'Change password', Icons.lock_open),
                      _listActionButton(context, 'Add User', Icons.person_add),
                      _listActionButton(context, 'Logout', Icons.logout),
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

  Widget _listActionButton(BuildContext context, String text, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(text),
      onTap: () {},
    );
  }
}

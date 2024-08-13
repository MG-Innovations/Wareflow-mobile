import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Card(
        color: Colors.white,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 10),
            _buildListItem(Icons.business, 'DELUX AUTO WORKS'),
            _buildListItem(Icons.location_on,
                'Delux auto Garag near indira nagar jogging track'),
            _buildListItem(Icons.group, '10 Users live'),
            _buildListItem(Icons.email, 'delux@auto.com'),
            const Divider(),
            _listActionButton(context, 'Change password', Icons.lock_open),
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

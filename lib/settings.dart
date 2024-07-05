import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SettingsTile(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {
              // Handle Edit Profile action
            },
          ),
          SettingsTile(
            icon: Icons.lock_outline,
            title: 'Manage Passwords',
            onTap: () {
              // Handle Manage Passwords action
            },
          ),
           SettingsTile(
            icon: Icons.money,
            title: 'Manage Bank Details',
            onTap: () {
              // Handle Manage Passwords action
            },
          ),
          SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications & Reminders',
            onTap: () {
              // Handle Notifications & Reminders action
            },
          ),
          SettingsTile(
            icon: Icons.feedback_outlined,
            title: 'Feedback',
            onTap: () {
              // Handle Feedback action
            },
          ),
          SettingsTile(
            icon: Icons.support_agent_outlined,
            title: 'Support',
            onTap: () {
              // Handle Support action
            },
          ),
          SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {
              // Handle Privacy Policy action
            },
          ),
          SettingsTile(
            icon: Icons.article_outlined,
            title: 'Terms & Conditions',
            onTap: () {
              // Handle Terms & Conditions action
            },
          ),
          SizedBox(height: 20.0),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.black),
            title: Text('LogOut'),
            onTap: () {
              // Handle Logout action
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_outline, color: Colors.red),
            title: Text('Delete Account', style: TextStyle(color: Colors.red)),
            onTap: () {
              // Handle Delete Account action
            },
          ),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  SettingsTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

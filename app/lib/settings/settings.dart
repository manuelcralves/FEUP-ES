import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../HomePage/HomePage.dart';

class Settings extends StatelessWidget {
  Future<void> deleteAccount() async {
    try {
      // Delete the user account from Firebase
      await FirebaseAuth.instance.currentUser?.delete();
    } catch (e) {
      // Handle any errors that occur during account deletion
      print('Error deleting account: $e');
    }
  }

  void showDeleteAccountConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () async {
                // User clicked "Yes"
                await deleteAccount();
                // Navigate to the homepage after deleting the account
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // User clicked "No"
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void editEmail(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newEmail = '';

        return AlertDialog(
          title: Text('Edit Email'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'New Email',
                ),
                onChanged: (value) {
                  newEmail = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Change the user's email in Firebase
                try {
                  await FirebaseAuth.instance.currentUser?.updateEmail(newEmail);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Email changed successfully.'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error changing email: $e'),
                    ),
                  );
                }

                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void changePassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newPassword = '';

        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
                onChanged: (value) {
                  newPassword = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Change the user's password in Firebase
                try {
                  await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Password changed successfully.'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error changing password: $e'),
                    ),
                  );
                }

                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
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
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'General Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Edit Email'),
                onTap: () {
                  editEmail(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
                onTap: () {
                  changePassword(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete Account'),
                onTap: () {
                  showDeleteAccountConfirmationDialog(context);
                },
              ),
              SizedBox(height: 24),
              Text(
                'About',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('App Version'),
                subtitle: Text('1.0.0'),
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('FAQs'),
                onTap: () {
                  // Handle FAQs
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_support),
                title: Text('Contact Us'),
                onTap: () {
                  // Handle contact us
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

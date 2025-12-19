import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/gradient_background.dart';
import '../widgets/app_logo.dart';
import '../theme.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Calculate generic stats
    int completed = userProvider.completedCoursesCount;
    // Assuming 3 total courses for now as per MockData, but could be dynamic
    int total = 3; 
    double overallProgress = total > 0 ? (completed / total) : 0;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('My Profile'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: AppTheme.accentRed),
              onPressed: () async {
                await userProvider.logout();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              // Avatar Section
              Center(
                child: Column(
                  children: [
                    AppLogo(size: 100, showText: false),
                    SizedBox(height: 16),
                    Text(
                      userProvider.userName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      userProvider.userEmail,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Stats Cards
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                     BoxShadow(color: Colors.black26, blurRadius: 10),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                       "Learning Progress",
                       style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$completed / $total Courses",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          "${(overallProgress * 100).toInt()}%",
                          style: TextStyle(
                             color: AppTheme.secondaryColor, 
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: overallProgress,
                        minHeight: 8,
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation(AppTheme.secondaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              
              // Settings / Info List
              _buildSettingsTile(context, Icons.person_outline, "Account Details"),
              _buildSettingsTile(context, Icons.notifications_outlined, "Notifications"),
              _buildSettingsTile(context, Icons.shield_outlined, "Privacy & Security"),
              _buildSettingsTile(context, Icons.help_outline, "Help & Support"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryColor),
        title: Text(title, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          // Placeholder
        },
      ),
    );
  }
}

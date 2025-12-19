import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../models/course.dart';
import '../providers/user_provider.dart';
import '../widgets/course_card.dart';
import '../widgets/gradient_background.dart';
import '../widgets/app_logo.dart';
import '../theme.dart';

class LearningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get static course definitions
    final staticCourses = MockData.courses;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            children: [
              AppLogo(size: 32, showText: false),
              SizedBox(width: 12),
              Text('Learning Hub'),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text(
                          'Your Progress',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                           '${userProvider.completedCoursesCount} of ${staticCourses.length} courses completed',
                           style: TextStyle(color: Colors.grey),
                        ),
                     ]
                  );
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    return ListView.builder(
                      itemCount: staticCourses.length,
                      itemBuilder: (context, index) {
                        // Create a new Course object with the updated progress from provider
                        Course original = staticCourses[index];
                        double realProgress = userProvider.getProgress(original.id);
                        
                        Course displayCourse = Course(
                          id: original.id,
                          title: original.title,
                          shortDescription: original.shortDescription,
                          fullContent: original.fullContent,
                          progress: realProgress,
                        );

                        return CourseCard(course: displayCourse);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hackathon_app_rubix/util/get_top_students.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/drawer.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.teal, // Adjust background color
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adding padding to body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top students header
            Text(
              'Top Students',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal, // Header color
              ),
            ),
            SizedBox(height: 16), // Spacing between title and list

            // FutureBuilder for fetching top students
            FutureBuilder(
              future: getTopStudents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching data.'));
                } else if (snapshot.data == null || snapshot.data?.isEmpty == true) {
                  return Center(child: Text('No top students available.'));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        var student = snapshot.data?[index];
                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Icon(Icons.star, color: Colors.teal), // Add an icon for each student
                            title: Text(
                              student?.name ?? 'Unknown',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              'Rank: ${index + 1}',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

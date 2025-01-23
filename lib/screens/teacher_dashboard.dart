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
        // backgroundColor: Color(0xFFE0CDA1),
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Text('Top students',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          FutureBuilder(
              future: getTopStudents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data?[index].name ?? ''),
                        subtitle: Text('Rank: ${index + 1}'),
                      );
                    },
                  );
                }
              }),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final docRef = FirebaseFirestore.instance.collection('tasks').doc(taskId);

    return Scaffold(
      appBar: AppBar(title: const Text('Task Detail')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: docRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || !snapshot.data!.exists) return const Center(child: Text('Task not found'));

          final data = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['title'] ?? '', style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 8),
                Text(data['description'] ?? ''),
                const SizedBox(height: 16),
                Text('Completed: ${data['isCompleted'] == true ? 'Yes' : 'No'}'),
                const SizedBox(height: 8),
                if (data['createdAt'] != null)
                  Text('Created: ${data['createdAt'].toDate()}'),
                if (data['updatedAt'] != null) ...[
                  const SizedBox(height: 8),
                  Text('Updated: ${data['updatedAt'].toDate()}'),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

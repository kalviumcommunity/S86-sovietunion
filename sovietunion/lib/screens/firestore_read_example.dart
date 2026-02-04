import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreReadExample extends StatelessWidget {
  const FirestoreReadExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firestore Read Example')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('tasks')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No tasks available'));
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>?;
                    return ListTile(
                      title: Text(data?['title'] ?? 'No title'),
                      subtitle: Text(data?['description'] ?? ''),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          SizedBox(
            height: 160,
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc('sampleUserId')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('No user document'));
                }

                final data = snapshot.data!.data() as Map<String, dynamic>?;
                if (data == null) return const Center(child: Text('No data'));

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('User (one-time read)', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Name: ${data['name'] ?? 'N/A'}'),
                      Text('Email: ${data['email'] ?? 'N/A'}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

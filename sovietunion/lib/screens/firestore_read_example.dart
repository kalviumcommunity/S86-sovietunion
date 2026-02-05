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
                  import 'package:flutter/material.dart';
                  import 'package:cloud_firestore/cloud_firestore.dart';

                  class FirestoreReadExample extends StatefulWidget {
                    const FirestoreReadExample({super.key});

                    @override
                    State<FirestoreReadExample> createState() => _FirestoreReadExampleState();
                  }

                  class _FirestoreReadExampleState extends State<FirestoreReadExample> {
                    bool showIncompleteOnly = true;
                    bool orderByPriorityDesc = true;
                    int limitResults = 10;
                    String tagFilter = '';

                    Query buildQuery() {
                      Query query = FirebaseFirestore.instance.collection('tasks');

                      if (showIncompleteOnly) {
                        query = query.where('isCompleted', isEqualTo: false);
                      }

                      if (tagFilter.isNotEmpty) {
                        query = query.where('tags', arrayContains: tagFilter);
                      }

                      // Ensure an orderBy exists when using where + orderBy in some cases.
                      query = query.orderBy('priority', descending: orderByPriorityDesc);

                      if (limitResults > 0) query = query.limit(limitResults);

                      return query;
                    }

                    @override
                    Widget build(BuildContext context) {
                      final query = buildQuery();

                      return Scaffold(
                        appBar: AppBar(title: const Text('Firestore Query Examples')),
                        body: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(labelText: 'Tag filter (arrayContains)'),
                                      onChanged: (v) => setState(() => tagFilter = v.trim()),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    children: [
                                      Row(children: [
                                        const Text('Incomplete only'),
                                        Switch(
                                          value: showIncompleteOnly,
                                          onChanged: (v) => setState(() => showIncompleteOnly = v),
                                        )
                                      ]),
                                      Row(children: [
                                        const Text('Priority desc'),
                                        Switch(
                                          value: orderByPriorityDesc,
                                          onChanged: (v) => setState(() => orderByPriorityDesc = v),
                                        )
                                      ]),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  const Text('Limit:'),
                                  const SizedBox(width: 8),
                                  DropdownButton<int>(
                                    value: limitResults,
                                    items: const [5, 10, 20, 50]
                                        .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                                        .toList(),
                                    onChanged: (v) => setState(() => limitResults = v ?? 10),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: query.snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  }

                                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                    return const Center(child: Text('No tasks match the current query'));
                                  }

                                  final docs = snapshot.data!.docs;

                                  return ListView.builder(
                                    itemCount: docs.length,
                                    itemBuilder: (context, index) {
                                      final data = docs[index].data() as Map<String, dynamic>?;
                                      final title = data?['title'] ?? 'No title';
                                      final pr = data?['priority']?.toString() ?? 'N/A';
                                      final completed = data?['isCompleted'] == true;

                                      return ListTile(
                                        leading: CircleAvatar(child: Text(pr)),
                                        title: Text(title),
                                        subtitle: Text('Completed: $completed'),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }

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
      query = query.where('completed', isEqualTo: false);
    }

    if (tagFilter.isNotEmpty) {
      query = query.where('tags', arrayContains: tagFilter);
    }

    if (orderByPriorityDesc) {
      query = query.orderBy('priority', descending: true);
    } else {
      query = query.orderBy('createdAt', descending: true);
    }

    return query.limit(limitResults);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Read Example'),
        actions: [
          IconButton(
            onPressed: () => _showOptionsDialog(context),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: buildQuery().snapshots(),
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
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;
              final title = data['title'] ?? 'No title';
              final content = data['content'] ?? '';
              final priority = data['priority'] ?? 1;
              final completed = data['completed'] ?? false;
              final tags = List<String>.from(data['tags'] ?? []);

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getPriorityColor(priority),
                    child: Text('$priority'),
                  ),
                  title: Text(
                    title,
                    style: TextStyle(
                      decoration: completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (content.isNotEmpty) Text(content),
                      if (tags.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Wrap(
                            spacing: 4.0,
                            children: tags
                                .map(
                                  (tag) => Chip(
                                    label: Text(
                                      tag,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    backgroundColor: Colors.grey[200],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                    ],
                  ),
                  trailing: completed
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.radio_button_unchecked),
                  isThreeLine: tags.isNotEmpty || content.isNotEmpty,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      case 5:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Options'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  title: const Text('Show incomplete only'),
                  value: showIncompleteOnly,
                  onChanged: (value) {
                    setState(() {
                      showIncompleteOnly = value ?? true;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Order by priority (desc)'),
                  value: orderByPriorityDesc,
                  onChanged: (value) {
                    setState(() {
                      orderByPriorityDesc = value ?? true;
                    });
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Filter by tag',
                    hintText: 'Enter tag name',
                  ),
                  onChanged: (value) {
                    tagFilter = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Limit results',
                    hintText: 'Enter number',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    limitResults = int.tryParse(value) ?? 10;
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Apply'),
          ),
        ],
      ),
    ).then((_) {
      setState(() {});
    });
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sovietunion/screens/task_detail.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final CollectionReference _tasksCol = FirebaseFirestore.instance.collection('tasks');
  StreamSubscription<QuerySnapshot>? _colSub;
  bool _listening = false;

  Future<void> _addTask() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    if (!_formKey.currentState!.validate()) return;

    try {
      await _tasksCol.add({
        'title': title,
        'description': desc,
        'isCompleted': false,
        'createdAt': Timestamp.now(),
      });
      _titleController.clear();
      _descController.clear();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task added')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Add failed: $e')));
    }
  }

  Future<void> _updateTask(String id, Map<String, dynamic> data) async {
    final title = data['title'] as String? ?? '';
    final desc = data['description'] as String? ?? '';

    final _editTitle = TextEditingController(text: title);
    final _editDesc = TextEditingController(text: desc);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _editTitle, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: _editDesc, decoration: const InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final newTitle = _editTitle.text.trim();
              final newDesc = _editDesc.text.trim();
              if (newTitle.isEmpty || newDesc.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
                return;
              }
              try {
                await _tasksCol.doc(id).update({
                  'title': newTitle,
                  'description': newDesc,
                  'updatedAt': Timestamp.now(),
                });
                if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task updated')));
                Navigator.of(context).pop();
              } catch (e) {
                if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update failed: $e')));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _colSub?.cancel();
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(_listening ? Icons.notifications_active : Icons.notifications_none),
            tooltip: _listening ? 'Disable live notifications' : 'Enable live notifications',
            onPressed: () => _toggleListening(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _addTask,
                          child: const Text('Add Task'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _tasksCol.orderBy('createdAt', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
                  if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                  final docs = snapshot.data?.docs ?? [];
                  if (docs.isEmpty) return const Center(child: Text('No tasks'));
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      return Card(
                        child: ListTile(
                          title: Text(data['title'] ?? ''),
                          subtitle: Text(data['description'] ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _updateTask(doc.id, data),
                              ),
                              IconButton(
                                icon: const Icon(Icons.open_in_new),
                                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TaskDetailScreen(taskId: doc.id))),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleListening() {
    if (_listening) {
      _colSub?.cancel();
      _colSub = null;
      setState(() => _listening = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Live notifications disabled')));
      return;
    }

    _colSub = _tasksCol.snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        final data = change.doc.data() as Map<String, dynamic>?;
        final title = data?['title'] ?? '(no title)';
        final type = change.type;
        String msg;
        if (type == DocumentChangeType.added) msg = 'Task added: $title';
        else if (type == DocumentChangeType.modified) msg = 'Task updated: $title';
        else if (type == DocumentChangeType.removed) msg = 'Task removed: $title';
        else msg = 'Task changed: $title';
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      }
    }, onError: (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Listener error: $e')));
    });

    setState(() => _listening = true);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Live notifications enabled')));
  }
}

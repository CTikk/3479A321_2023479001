import 'package:flutter/material.dart';
import 'package:application_laboratorio/entity/activity.dart';
import 'package:application_laboratorio/services/database_helper.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Activity> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final activities = await _dbHelper.getActivities();
    setState(() {
      _activities = activities;
    });
  }

  Future<void> _addActivity() async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva actividad'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Descripción'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final description = controller.text.trim();
              if (description.isNotEmpty) {
                final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
                final newActivity = Activity(
                  date: now,
                  description: description,
                );
                await _dbHelper.insertActivity(newActivity);
                _loadActivities();
                if (mounted) Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Future<void> _editActivity(Activity activity) async {
    final controller = TextEditingController(text: activity.description);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar actividad'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Descripción'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newDescription = controller.text.trim();
              if (newDescription.isNotEmpty) {
                final updated = Activity(
                  id: activity.id,
                  date: activity.date,
                  description: newDescription,
                );
                await _dbHelper.updateActivity(updated);
                _loadActivities();
                if (mounted) Navigator.pop(context);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteActivity(int id) async {
    await _dbHelper.deleteActivity(id);
    _loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Actividades')),
      body: ListView.builder(
        itemCount: _activities.length,
        itemBuilder: (context, index) {
          final activity = _activities[index];
          return ListTile(
            title: Text(activity.description),
            subtitle: Text(activity.date),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editActivity(activity),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteActivity(activity.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addActivity,
        child: const Icon(Icons.add),
      ),
    );
  }
}
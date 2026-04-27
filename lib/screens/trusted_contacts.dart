import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrustedContactsPage extends StatefulWidget {
  const TrustedContactsPage({super.key});

  @override
  State<TrustedContactsPage> createState() => _TrustedContactsPageState();
}

class _TrustedContactsPageState extends State<TrustedContactsPage> {
  List<Map<String, String>> contacts = [];
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> names = prefs.getStringList('contact_names') ?? [];
    final List<String> phones = prefs.getStringList('contact_phones') ?? [];
    setState(() {
      contacts = List.generate(
          names.length, (i) => {'name': names[i], 'phone': phones[i]});
    });
  }

  Future<void> _saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'contact_names', contacts.map((c) => c['name']!).toList());
    await prefs.setStringList(
        'contact_phones', contacts.map((c) => c['phone']!).toList());
  }

  void _addContact() {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) return;
    setState(() {
      contacts.add({
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
      });
    });
    _saveContacts();
    _nameController.clear();
    _phoneController.clear();
    Navigator.pop(context);
  }

  void _deleteContact(int index) {
    setState(() => contacts.removeAt(index));
    _saveContacts();
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('Add Trusted Contact',
            style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Name (e.g. Mummy)',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '+91XXXXXXXXXX',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _nameController.clear();
              _phoneController.clear();
              Navigator.pop(ctx);
            },
            child: const Text('Cancel',
                style: TextStyle(color: Colors.white38)),
          ),
          ElevatedButton(
            onPressed: _addContact,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FF94)),
            child: const Text('Add',
                style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      appBar: AppBar(
        title: const Text('TRUSTED CONTACTS'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: _showAddDialog,
            icon: const Icon(Icons.add, color: Color(0xFF00FF94)),
          )
        ],
      ),
      body: contacts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.people_outline,
                      color: Colors.white24, size: 64),
                  const SizedBox(height: 16),
                  const Text('No trusted contacts yet',
                      style: TextStyle(color: Colors.white38)),
                  const SizedBox(height: 8),
                  const Text('Add contacts who will receive your SOS',
                      style: TextStyle(color: Colors.white24, fontSize: 12)),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _showAddDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Contact'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00FF94),
                        foregroundColor: Colors.black),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  color: const Color(0xFF1A1A1A),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF00FF94),
                      child: Text(
                        contact['name']![0].toUpperCase(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(contact['name']!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(contact['phone']!,
                        style: const TextStyle(color: Colors.white54)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.redAccent),
                      onPressed: () => _deleteContact(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: contacts.isNotEmpty
          ? FloatingActionButton(
              onPressed: _showAddDialog,
              backgroundColor: const Color(0xFF00FF94),
              child: const Icon(Icons.add, color: Colors.black),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

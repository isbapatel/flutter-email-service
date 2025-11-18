import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../theme/app_colors.dart';
import '../widgets/skill_chip.dart';
import '../widgets/input_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController _collegeOrCompany = TextEditingController();
  final TextEditingController _skillInput = TextEditingController();
  final TextEditingController _aspiredSkillInput = TextEditingController();
  final TextEditingController _linkedin = TextEditingController();
  final TextEditingController _leetcode = TextEditingController();
  final TextEditingController _github = TextEditingController();

  // popup email controller
  final TextEditingController _popupEmailCtrl = TextEditingController();

  List<String> currentSkills = [];
  List<String> aspiredSkills = [];

  String status = 'Student';

  final List<String> availableCategories = [
    'SDE',
    'UI/UX designer',
    'Product Manager',
    'Domain Expert'
  ];

  final List<String> selectedCategories = [];

  final List<String> skillSuggestions = [
    'Python', 'Java', 'C++', 'HTML', 'CSS', 'JavaScript',
    'React', 'Node.js', 'Flutter', 'Dart', 'SQL'
  ];

  void addSkill(String skill, List<String> list) {
    final s = skill.trim();
    if (s.isEmpty) return;
    if (!list.contains(s)) {
      setState(() => list.add(s));
    }
  }

  void removeSkill(String skill, List<String> list) {
    setState(() => list.remove(skill));
  }

  Future<void> _openCategoryPicker() async {
    final temp = List<String>.from(selectedCategories);

    await showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select up to 2 categories",
                  style: TextStyle(fontWeight: FontWeight.w700)),
              ...availableCategories.map((c) {
                final checked = temp.contains(c);
                return CheckboxListTile(
                  value: checked,
                  title: Text(c),
                  onChanged: (v) {
                    setState(() {
                      if (v == true && temp.length < 2) {
                        temp.add(c);
                      } else {
                        temp.remove(c);
                      }
                    });
                  },
                );
              }),
              ElevatedButton(
                onPressed: () {
                  selectedCategories
                    ..clear()
                    ..addAll(temp);
                  Navigator.pop(ctx);
                },
                child: const Text("Done"),
              )
            ],
          ),
        );
      },
    );
  }

  // -----------------------------------------------------------
  // POPUP FOR EMAIL INPUT
  // -----------------------------------------------------------
  Future<void> _showEmailPopup() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Enter your email"),
          content: TextField(
            controller: _popupEmailCtrl,
            decoration: const InputDecoration(
              hintText: "email@example.com",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_popupEmailCtrl.text.isEmpty) return;

                await _sendToBackend();

                if (!mounted) return;

                Navigator.pop(ctx); // close popup

                Navigator.pushNamed(
                  context,
                  '/profile',
                  arguments: {
                    'name': "Nikhil Ahuja",
                    'email': _popupEmailCtrl.text.trim(),
                    'phone': "+91 9999999999",
                    'category': selectedCategories.join(", "),
                    'status': status,
                    'company': _collegeOrCompany.text,
                    'currentSkills': currentSkills,
                    'aspiredSkills': aspiredSkills,
                    'linkedin': _linkedin.text,
                    'leetcode': _leetcode.text,
                    'github': _github.text,
                  },
                );
              },
              child: const Text("Submit"),
            )
          ],
        );
      },
    );
  }

  // -----------------------------------------------------------
  // BACKEND CALL
  // -----------------------------------------------------------
  Future<void> _sendToBackend() async {
    final url = Uri.parse("http://127.0.0.1:8000/save_user");

    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": "Nikhil Ahuja",
        "email": _popupEmailCtrl.text.trim(),
        "phone": "+91 9999999999",
        "category": selectedCategories.join(", "),
        "status": status,
        "company": _collegeOrCompany.text,
        "linkedin": _linkedin.text,
        "leetcode": _leetcode.text,
        "github": _github.text,
        "currentSkills": currentSkills,
        "aspiredSkills": aspiredSkills,
      }),
    );
  }

  // -----------------------------------------------------------
  // UI RESTORED
  // -----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  const Text("Category", style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: _openCategoryPicker,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.inputBorder),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: selectedCategories.isEmpty
                          ? Text("Select up to 2 categories",
                              style: TextStyle(color: AppColors.mutedText))
                          : Wrap(
                              spacing: 8,
                              children: selectedCategories
                                  .map((c) => Chip(label: Text(c)))
                                  .toList(),
                            ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Status
                  const Text("Status", style: TextStyle(fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      Radio(
                        value: "Student",
                        groupValue: status,
                        onChanged: (v) => setState(() => status = v.toString()),
                      ),
                      const Text("Student"),
                      Radio(
                        value: "Working Professional",
                        groupValue: status,
                        onChanged: (v) => setState(() => status = v.toString()),
                      ),
                      const Text("Professional"),
                    ],
                  ),

                  const SizedBox(height: 12),

                  InputField(
                    label: status == "Student" ? "College" : "Company",
                    hint: "Enter name",
                    controller: _collegeOrCompany,
                  ),

                  const SizedBox(height: 18),

                  // Skills
                  const Text("Current Skills", style: TextStyle(fontWeight: FontWeight.w600)),
                  Wrap(
                    children: currentSkills
                        .map((s) => SkillChip(label: s, onRemove: () => removeSkill(s, currentSkills)))
                        .toList(),
                  ),
                  TextField(
                    controller: _skillInput,
                    onSubmitted: (v) {
                      addSkill(v, currentSkills);
                      _skillInput.clear();
                    },
                    decoration: const InputDecoration(hintText: "Add skill..."),
                  ),

                  const SizedBox(height: 18),

                  const Text("Aspired Skills", style: TextStyle(fontWeight: FontWeight.w600)),
                  Wrap(
                    children: aspiredSkills
                        .map((s) => SkillChip(label: s, onRemove: () => removeSkill(s, aspiredSkills)))
                        .toList(),
                  ),
                  TextField(
                    controller: _aspiredSkillInput,
                    onSubmitted: (v) {
                      addSkill(v, aspiredSkills);
                      _aspiredSkillInput.clear();
                    },
                    decoration: const InputDecoration(hintText: "Add skill..."),
                  ),

                  const SizedBox(height: 18),

                  InputField(
                    label: "LinkedIn",
                    hint: "LinkedIn URL",
                    controller: _linkedin,
                  ),

                  const SizedBox(height: 12),

                  InputField(
                    label: "Leetcode",
                    hint: "Leetcode URL",
                    controller: _leetcode,
                  ),

                  const SizedBox(height: 12),

                  InputField(
                    label: "Github",
                    hint: "Github URL",
                    controller: _github,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showEmailPopup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

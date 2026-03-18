import 'package:apu_assignment/features/users/report/model/report_model.dart';
import 'package:apu_assignment/features/users/report/presentation/viewmodel/report_incident_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/users/report/presentation/widgets/incident_type_chip.dart';
import 'package:apu_assignment/features/users/report/presentation/widgets/section_label.dart';
import 'package:flutter/material.dart';

class ReportIncidentScreen extends ConsumerStatefulWidget {
  const ReportIncidentScreen({super.key});

  @override
  ConsumerState<ReportIncidentScreen> createState() =>
      _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends ConsumerState<ReportIncidentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  String _selectedIncidentType = 'Physical';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<Map<String, dynamic>> _incidentTypes = [
    {'label': "Physical", 'icon': Icons.back_hand_outlined},
    {'label': "Verbal", 'icon': Icons.chat_bubble_outline_outlined},
    {'label': "Cyber", 'icon': Icons.laptop_mac_outlined},
    {'label': "Social", 'icon': Icons.people_alt_outlined},
  ];

  @override void initState() {
    final now = DateTime.now();

    // Assign to State Variables
    _selectedDate = now;
    _selectedTime = TimeOfDay.fromDateTime(now);

    // Assign to Controller
    _dateController.text = DateFormat('MM/dd/yyyy').format(now);
    _timeController.text = DateFormat.jm().format(now);
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  Future<void> pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        // This formats it nicely based on the phone's settings (e.g. 10:30 AM)
        _timeController.text = picked.format(context);
      });
    }
  }

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      if (_selectedIncidentType.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select an incident type")),
        );
        return;
      }

      ReportType selectedType = ReportType.values.firstWhere(
        (e) => e.name.toLowerCase() == _selectedIncidentType.toLowerCase(),
        orElse: () => ReportType.unknown,
      );

      final DateTime finalIncidentDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      ref
          .read(reportIncidentViewModelProvider.notifier)
          .submitReport(
            location: _locationController.text,
            description: _descriptionController.text,
            reportType: selectedType,
            incidentDate: finalIncidentDateTime,
          );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Report Incident",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionLabel(sectionText: "Type of Incident"),
              kGap8,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 50,
                ),
                itemCount: _incidentTypes.length,
                itemBuilder: (context, index) {
                  final items = _incidentTypes[index];
                  return IncidentTypeChip(
                    label: items['label'],
                    icon: items['icon'],
                    isSelected: _selectedIncidentType == items['label'],
                    onTap: () {
                      setState(() {
                        _selectedIncidentType = items['label'];
                      });
                    },
                  );
                },
              ),
              kGap16,
              SectionLabel(sectionText: "When did it Happen?"),
              kGap8,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: pickDate,
                      decoration: InputDecoration(
                        hintText: "mm/dd/yyyy",
                        prefixIcon: const Icon(Icons.calendar_today_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(kDefaultRadius),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Required"
                          : null,
                    ),
                  ),
                  kGap8,
                  Expanded(
                    child: TextFormField(
                      controller: _timeController,
                      onTap: pickTime,
                      decoration: InputDecoration(
                        hintText: "--:-- --",
                        prefixIcon: const Icon(Icons.timelapse_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(kDefaultRadius),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                            ? "Required"
                            : null,
                    ),
                  ),
                ],
              ),

              kGap16,
              SectionLabel(sectionText: "Where did it Happen?"),
              kGap8,
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: "eg. APU",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Please select a location"
                    : null,
              ),
              kGap16,
              SectionLabel(sectionText: "Description"),
              kGap8,
              TextFormField(
                controller: _descriptionController,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "Describe the incident in detail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Please provide a description"
                    : null,
              ),
            ],
          ),
        ),
      ),
      // Submit Button
      bottomNavigationBar: BottomAppBar(
        child: FilledButton(
          onPressed: _submitReport,
          child: Text("Submit Report"),
        ),
      ),
    );
  }
}

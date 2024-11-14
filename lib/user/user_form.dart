import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';
import '../provider/user_provider.dart';
import '../route/route.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? _dob;

  Future<void> _submitForm() async {
   if (_formKey.currentState?.validate() ?? false) {
      if (_dob == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please select a date of birth'),
        ));
        return;
      }

      User user = User(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        dob: _dob!,
        mobileNumber: _mobileNumberController.text,
      );

      await context.read<UserProvider>().addUser(user);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User added successfully!'),
      ));

      Navigator.pushReplacementNamed(context, Routes.userListScreen); 
    }
  }

   Future<void> _selectDOB(BuildContext context)async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dob) {
     
      _dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      context.read<UserProvider>().updateDob(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
      _dob = context.watch<UserProvider>().dob;

    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
                    children: [
                      Text(
                        'Enter Your Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          
                        ),
                      ),
                      SizedBox(height: 20),

                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.person, ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 2) {
                            return 'First name must be at least 2 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.person_outline, ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 2) {
                            return 'Last name must be at least 2 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      TextFormField(
                        controller: _dobController,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.calendar_today, ),
                        ),
                        readOnly: true,
                        onTap: () => _selectDOB(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date of birth';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      TextFormField(
                        controller: _mobileNumberController,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.phone, ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length != 10) {
                            return 'Please enter a valid 10-digit mobile number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),

                      Center(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    
                    ],
                  )
        ),
      ),
      
    );
  }
}
import 'package:flutter/material.dart';
import 'package:loading_btn/loading_btn.dart';

class OpenBottomSheet {
  void openBottomSheet(BuildContext context, String msg) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0), // Only top corners are rounded
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40.0),
            ),
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 231, 231, 231),
                width: 1.0,
              ),
              left: BorderSide(
                color: Color.fromARGB(255, 231, 231, 231),
                width: 1.0,
              ),
              right: BorderSide(
                color: Color.fromARGB(255, 231, 231, 231),
                width: 1.0,
              ),
              bottom: BorderSide.none,
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                msg,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  void openBottomSheetChoice(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String topicName = '';
    String complexity = 'Beginner'; // Default value
    String endGoals = '';

    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: 20,
              top: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40.0),
              ),
              border: Border(
                top: BorderSide(
                  color: Color.fromARGB(255, 231, 231, 231),
                  width: 1.0,
                ),
                left: BorderSide(
                  color: Color.fromARGB(255, 231, 231, 231),
                  width: 1.0,
                ),
                right: BorderSide(
                  color: Color.fromARGB(255, 231, 231, 231),
                  width: 1.0,
                ),
                bottom: BorderSide.none,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Topic Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a topic name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      topicName = value;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: complexity,
                    decoration: InputDecoration(labelText: 'Complexity'),
                    items: ['Beginner', 'Advanced', 'Expert']
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (newValue) {
                      complexity = newValue!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'End Goals'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter end goals';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      endGoals = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 20),
                    child: LoadingBtn(
                      height: 60,
                      borderRadius: 20,
                      animate: true,
                      color: const Color.fromARGB(255, 236, 240, 243),
                      width: MediaQuery.of(context).size.width,
                      loader: Container(
                        padding: const EdgeInsets.all(10),
                        width: 40,
                        height: 40,
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (btnState == ButtonState.idle) {
                          if (_formKey.currentState!.validate()) {
                            startLoading();
                            print('Topic Name: $topicName');
                            print('Complexity: $complexity');
                            print('End Goals: $endGoals');

                          
                            stopLoading();
                            Navigator.pop(
                                context);  
                          }
                        }
                      },
                      child: const Text(
                        'Submit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

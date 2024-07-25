// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const List<Color> colors = [
  Color.fromARGB(255, 255, 197, 36),
  Color.fromARGB(255, 138, 193, 134),
  Color(0xFF00FFFF),
  Color.fromARGB(255, 255, 212, 127),
  Color.fromARGB(255, 120, 104, 216),
];

// Query

const String SECTION_NAMES_GENERATOR1 = 'Given the topic';
//
const String SECTION_NAMES_GENERATOR2 =
    '''Return a JSON array containing a list of section names relevant to the given topic. The response should include only the list of section names, with a maximum of 10 sections. If the topic is related to explicit content (e.g., weapon making, sex, pornography) or if the input is invalid or inappropriate or   if some topic names on which sections couldnt be generated as its not suitable for course generation, return `null`. Ensure that the response strictly adheres to these guidelines and does not include any additional text or information. The section names should be relevant for educational and to excel at realms like .
''';
const String SECTION_NAMES_GENERATOR3 =
    '''The end goal of this is to gain knowledge in realm like ''';
//
//
const String SECTION_NAMES_GENERATOR4 = '';
const String SECTION_NAMES_GENERATOR5 = '';
const String SECTION_NAMES_GENERATOR6 = '';
const String SECTION_NAMES_GENERATOR7 = '';

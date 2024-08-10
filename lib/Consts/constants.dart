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
const String SUMMARIZE_PROMPT =
    '"Summarize the content of the text or image if recieved, If Not suitable for summarizing the image or the text, simply return a message saying its not suitable for Summarizing ';
const String SIMPLIFY_PROMPT =
    'Simplify the given input text or the contents image using simple words, so that even a kid would get it, or break down things if possible, points by points or para or any suitable forms.';
const String CORRECTOR =
    'Transform the given text or image found in text with the proper grammer, tenses and spellings, and if simply an image or text which can not be corrected, simply return an error message saying this input is not suitable and if the text is perefect without any mistakes then say No changes are needed as its perfect in Gramatical Norms';

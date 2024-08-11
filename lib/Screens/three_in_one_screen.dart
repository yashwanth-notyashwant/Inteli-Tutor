import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intellitutor/Prompts.dart';
import 'package:intellitutor/Widgets/the_curved_header.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:mime/mime.dart';

import '../Consts/constants.dart';

class SummarizeOrSimplifyScreen extends StatefulWidget {
  final int whereFrom;
  const SummarizeOrSimplifyScreen({required this.whereFrom});

  @override
  State<SummarizeOrSimplifyScreen> createState() =>
      _SummarizeOrSimplifyScreenState();
}

class _SummarizeOrSimplifyScreenState extends State<SummarizeOrSimplifyScreen> {
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String _responseText = '';
  final TextEditingController _textController = TextEditingController();

  Future<void> _pickImage(String? promptPart2) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // await _analyzeImage(image, promptPart2);
        setState(() {
          _imageFile = image;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _analyzeImageWithPrompt(XFile? image, String promptPart2) async {
    await dotenv.load(fileName: ".env");
    String apiKey = dotenv.env['API_KEY']!;

    if (promptPart2 != "" && image == null) {
      Prompts instance = Prompts();
      String initialQuery = widget.whereFrom == 0
          ? SUMMARIZE_PROMPT
          : widget.whereFrom == 1
              ? SIMPLIFY_PROMPT
              : CORRECTOR;

      var results = await instance.prompt(initialQuery + promptPart2);
      if (results == null) {
        // toast
        return;
      } else {
        setState(() {
          print("working good af with text only ");

          _responseText = results.toString();
        });
      }
      return;
    }
    // ignore: unnecessary_null_comparison
    if (apiKey == null) {
      throw Exception("API Key not found in environment variables.");
    }
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final imageData = await File(image!.path).readAsBytes();
    final mimeType = lookupMimeType(image.path) ?? 'application/octet-stream';

    final prompt = widget.whereFrom == 0
        ? TextPart(SUMMARIZE_PROMPT + promptPart2)
        : widget.whereFrom == 1
            ? TextPart(SIMPLIFY_PROMPT + promptPart2)
            : TextPart(CORRECTOR + promptPart2);

    final imagePart = DataPart(mimeType, imageData);

    final response = await model.generateContent([
      Content.multi([prompt, imagePart])
    ]);

    setState(() {
      print("working good af ");
      _imageFile = image;
      _responseText = response.text ?? 'No response received';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: _responseText == "" ? TheBTN(false) : TheBTN(true),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 160,
              child: TheHeaderWidget(
                title: widget.whereFrom == 0
                    ? "  Summarize"
                    : widget.whereFrom == 1
                        ? "  Simplify !"
                        : "  Correct em",
              ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height -
              //     160, // here Im talking about
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Color.fromRGBO(18, 19, 24, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Container(
                  padding:
                      EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _responseText == ""
                        ? [
                            isLoading == false
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: _imageFile == null
                                            ? LoadingBtn(
                                                height: 120,
                                                borderRadius: 20,
                                                animate: true,
                                                color: Color.fromARGB(
                                                    255, 236, 240, 243),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                loader: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  width: 40,
                                                  height: 40,
                                                  child:
                                                      const CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.black),
                                                  ),
                                                ),
                                                onTap: ((startLoading,
                                                    stopLoading,
                                                    btnState) async {
                                                  if (btnState ==
                                                      ButtonState.idle) {
                                                    startLoading();
                                                    await _pickImage(
                                                        _textController.text
                                                            .toString());
                                                    stopLoading();
                                                  }
                                                }),
                                                child: const Text(
                                                  'Pick an Image',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black),
                                                ), //add some styles
                                              )
                                            : Stack(
                                                children: [
                                                  Container(
                                                    height: 120,
                                                    child: Image.file(
                                                      File(_imageFile!.path),
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _imageFile = null;
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: const Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: TextField(
                                          controller: _textController,
                                          maxLines:
                                              20, // Makes the text field expand vertically
                                          decoration: InputDecoration(
                                            hintText: "Enter the text ...",
                                            filled: true,
                                            // fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.18,
                                      )
                                    ],
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height -
                                        200,
                                    child: Center(
                                      child: LoadingAnimationWidget
                                          .staggeredDotsWave(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        size: 150,
                                      ),
                                    ),
                                  ),

                            // The Sec child from here will have a  space between effect

                            // TheBTN(false),
                          ]
                        : [
                            Text(
                                _responseText), // this text is causing the overflow
                            // TheBTN(true),
                          ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TheBTN(bool another) {
    return LoadingBtn(
      height: 60,
      borderRadius: 20,
      animate: true,
      color: Color.fromARGB(255, 236, 240, 243),
      width: MediaQuery.of(context).size.width,
      loader: Container(
        padding: const EdgeInsets.all(10),
        width: 40,
        height: 40,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
      onTap: ((startLoading, stopLoading, btnState) async {
        if (btnState == ButtonState.idle) {
          if (another) {
            // call dispose
            setState(() {
              _responseText = "";
              _imageFile = null;
              _textController.text = '';
            });
            return;
          }
          if (_textController.text.toString() == "" && _imageFile == null) {
            print("aint nothing in here");
            return;
          }
          startLoading();
          setState(() {
            isLoading = true;
          });
          if (_imageFile != null || (_textController.text.toString() != "")) {
            await _analyzeImageWithPrompt(
                _imageFile, _textController.text.toString());
            setState(() {
              isLoading = false;
            });
            stopLoading();
          } else {
            print("aint nothing in here");
            setState(() {
              isLoading = false;
            });
// add a toaster here
            stopLoading();
          }
          setState(() {
            isLoading = false;
          });

          stopLoading();
        }
      }),
      child: Text(
        another ? "Another one? " : 'Go >>',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w300, color: Colors.black),
      ), //add some styles
    );
  }
}

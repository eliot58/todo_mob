import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageFormField extends StatefulWidget {
  const CustomImageFormField({
    Key? key,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);
  final String? Function(List<PlatformFile>?) validator;
  final Function(List<PlatformFile>?) onChanged;

  @override
  State<CustomImageFormField> createState() => _CustomImageFormFieldState();
}

class _CustomImageFormFieldState extends State<CustomImageFormField> {
  List<PlatformFile>? _paths;
  String filename = '';

  @override
  Widget build(BuildContext context) {
    return FormField<List<PlatformFile>?>(
        validator: widget.validator,
        builder: (formFieldState) {
          return Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      try {
                        _paths = (await FilePicker.platform.pickFiles(
                          withData: true,
                          type: FileType.custom,
                          allowMultiple: false,
                          onFileLoading: (FilePickerStatus status) => print(status),
                          allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf', 'doc', 'docx'],
                        ))
                            ?.files;
                      } on PlatformException catch (e) {
                        log('Unsupported operation$e');
                      } catch (e) {
                        log(e.toString());
                      }
                      if (_paths != null) {
                        if (_paths != null) {
                          setState(() {
                            filename = _paths!.first.name;
                          });
                          widget.onChanged.call(_paths!);
                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff707070).withOpacity(0.1),
                      ),
                      child: Column(
                        children: const [
                          Icon(Icons.upload_file),
                          Text('Прикрепите файл')
                        ],
                      ),
                    ),
                  ),
                  if (formFieldState.hasError)
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 10),
                      child: Text(
                        formFieldState.errorText!,
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 13.sp,
                            color: Colors.red[700],
                            height: 0.5),
                      ),
                    )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(filename, style: TextStyle(color: const Color(0xff080696), fontSize: 16.sp, fontWeight: FontWeight.w400)),
                ),
              )
            ],
          );
        });
  }
}
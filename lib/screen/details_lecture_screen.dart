// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panelafer/Compoands/widget.dart';
import 'package:panelafer/cuibt/states.dart';
import 'package:panelafer/screen/showScreens/show_exam.dart';

import '../cuibt/cuibt.dart';

class DetailsLectureScreen extends StatefulWidget {
  String nameSubject = "";
  String nameLecture = "";

  DetailsLectureScreen({
    Key? key,
    required this.nameSubject,
    required this.nameLecture,
  }) : super(key: key);

  @override
  State<DetailsLectureScreen> createState() => _DetailsLectureScreenState(
      nameSubject: nameSubject, nameLecture: nameLecture);
}

class _DetailsLectureScreenState extends State<DetailsLectureScreen> {
  _DetailsLectureScreenState({this.nameSubject, this.nameLecture});
  String? nameSubject;
  String? nameLecture;
  bool isAdd = true;
  var titleController = TextEditingController();
  var nodesController = TextEditingController();
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AfeerCuibt, AfeerState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cuibt = AfeerCuibt.get(context);
        return Material(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                        size: 30,
                      )),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Lecture',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isAdd = true;
                              isEdit = false;
                            });
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isAdd = false;
                              isEdit = true;
                            });
                          },
                          child: const Text(
                            'Show And Edit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: isAdd
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      margin: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                        child: TextButton(
                                          onPressed: () =>
                                              cuibt.uploadNewVideoStorage(
                                            academicYear: cuibt.selectedYear,
                                            semester: cuibt.selectedSemester,
                                            subjectName: nameSubject!,
                                            description: titleController.text,
                                            nameLecture: nameLecture!,
                                            context: context,
                                          ),
                                          child: const Text('UpdateVideo',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      margin: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                        child: TextButton(
                                          onPressed: () =>
                                              cuibt.uploadNewPhotoStorage(
                                            academicYear: cuibt.selectedYear,
                                            semester: cuibt.selectedSemester,
                                            subjectName: nameSubject!,
                                            description: titleController.text,
                                            nameLecture: nameLecture!,
                                            context: context,
                                          ),
                                          child: const Text('Update photo',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      margin: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                        child: TextButton(
                                          onPressed: () {
                                            navigator(
                                                context: context,
                                                returnPage: true,
                                                page: ExamScreen(
                                                  nameLecture: nameLecture!,
                                                  nameSubject: nameSubject!,
                                                ));
                                          },
                                          child: const Text('UpdateExam',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      margin: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                        child: TextButton(
                                          onPressed: () =>
                                              cuibt.uploadNewPdfStorage(
                                            academicYear: cuibt.selectedYear,
                                            semester: cuibt.selectedSemester,
                                            subjectName: nameSubject!,
                                            description: titleController.text,
                                            nameLecture: nameLecture!,
                                            context: context,
                                          ),
                                          child: const Text('UpdatePdf',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              CheckboxListTile(
                                  value: cuibt.isPaid,
                                  onChanged: (value) => cuibt.togglePaid(value),
                                  title: const Text(
                                    'Paid',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                              if (cuibt.isPaid)
                                TextFormField(
                                  controller: cuibt.priceController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Price',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the price';
                                    }
                                    return null;
                                  },
                                ),
                              TextFormField(
                                controller: titleController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    labelText: 'Title ',
                                    border: OutlineInputBorder(),
                                    hintText: "enter tittle of object "),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the title';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10,),
                              TextFormField(
                                controller: nodesController,
                                keyboardType: TextInputType.text,
                                maxLines: 6,
                                decoration: const InputDecoration(
                                    labelText: 'Alerts',
                                    border: OutlineInputBorder(),
                                    hintText: "enter Alerts "),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Alerts';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )
                        : Wrap(
                            children: [
                              lectureModel(
                                context: context,
                                category: "Video",
                                cuibt: cuibt,
                                nameSubject: nameSubject!,
                                nameLecture: nameLecture!,
                                onTap: () {
                                  cuibt.getVideo(
                                      academicYear: cuibt.selectedYear,
                                      semester: cuibt.selectedSemester,
                                      subjectName: nameSubject!,
                                      nameLecture: nameLecture!,
                                      context: context);
                                },
                              ),
                              lectureModel(
                                context: context,
                                category: "Photo",
                                cuibt: cuibt,
                                nameSubject: nameSubject!,
                                nameLecture: nameLecture!,
                                onTap: () {
                                  cuibt.getPhoto(
                                      academicYear: cuibt.selectedYear,
                                      semester: cuibt.selectedSemester,
                                      subjectName: nameSubject!,
                                      nameLecture: nameLecture!,
                                      context: context);
                                },
                              ),
                              lectureModel(
                                context: context,
                                category: "pdf",
                                cuibt: cuibt,
                                nameSubject: nameSubject!,
                                nameLecture: nameLecture!,
                                onTap: () {
                                  cuibt.getPdf(
                                      academicYear: cuibt.selectedYear,
                                      semester: cuibt.selectedSemester,
                                      subjectName: nameSubject!,
                                      nameLecture: nameLecture!,
                                      context: context);
                                },
                              ),
                              lectureModel(
                                context: context,
                                category: "Exam",
                                cuibt: cuibt,
                                nameSubject: nameSubject!,
                                nameLecture: nameLecture!,
                                onTap: () {
                                  cuibt.getQuestion(
                                    academicYear: cuibt.selectedYear,
                                    semester: cuibt.selectedSemester,
                                    subjectName: nameSubject!,
                                    nameLecture: nameLecture!,
                                    context: context,
                                  );
                                },
                              )
                            ],
                          )),

              ],
            ),
          ),
        );
      },
    );
  }
}

Widget lectureModel(
    {required String category,
    required BuildContext context,
    required AfeerCuibt cuibt,
    required String nameSubject,
    required String nameLecture,
    required GestureTapCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            child: Text(
              category,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            category,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    ),
  );
}


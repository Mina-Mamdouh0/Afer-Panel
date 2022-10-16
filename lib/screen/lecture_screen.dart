// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panelafer/Compoands/widget.dart';
import 'package:panelafer/cuibt/cuibt.dart';
import 'package:panelafer/cuibt/states.dart';
import 'package:panelafer/screen/showScreens/details_lecture_screen.dart';

class LectureScreen extends StatefulWidget {
  String nameSubject = "";

  LectureScreen({Key? key, required this.nameSubject}) : super(key: key);

  @override
  State<LectureScreen> createState() =>
      _LectureScreenState(nameSubject: nameSubject);
}

class _LectureScreenState extends State<LectureScreen> {
  _LectureScreenState({this.nameSubject});
  String? nameSubject;

  bool isAdd = true;
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
                    'lecture',
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
                            cuibt.getAllLecture(
                                academicYear: cuibt.selectedYear,
                                semester: cuibt.selectedSemester,
                                subjectName: nameSubject!);
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
                            myTextField(
                                controller: cuibt.lectureNameController,
                                hint: 'name of lecture',
                                onTap: () {},
                                keyboardType: TextInputType.text),
                            const SizedBox(
                              height: 20,
                            ),
                            myTextField(
                              controller: cuibt.lectureDescriptionController,
                              hint: 'description of lecture',
                              onTap: () {},
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            myButton(
                                text: 'add',
                                width: 300.0,
                                height: 50.0,
                                onPressed: () => cuibt.addNewLecture(
                                      academicYear: cuibt.selectedYear,
                                      semester: cuibt.selectedSemester,
                                      subjectName: nameSubject!,
                                    ))
                          ],
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 200,
                          ),
                          itemCount: cuibt.listLecture.length,
                          itemBuilder: (context, index) {
                            return lectureModel(
                              context: context,
                              nameSubject: nameSubject!,
                              descLecture:
                                  cuibt.listLecture[index].lectureDescription!,
                              nameLecture:
                                  cuibt.listLecture[index].lectureName!,
                            );
                          }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget lectureModel(
    {required String nameLecture,
    required String descLecture,
    required String nameSubject,
    required BuildContext context}) {
  return InkWell(
    onTap: () => navigator(
        returnPage: true,
        context: context,
        page: DetailsLectureScreen(
          nameSubject: nameSubject,
          nameLecture: nameLecture,
        )),
    child: Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 300,
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
                  nameSubject,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                nameLecture,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                descLecture,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[700],
            child: IconButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Delete',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.blue,
                          ),
                        ),
                        elevation: 10,
                        content: const Text(
                          'Im Sure Delete Item',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                AfeerCuibt.get(context).deleteLecture(
                                    subjectName: nameSubject,
                                    academicYear:
                                        AfeerCuibt.get(context).selectedYear,
                                    nameLecture: nameLecture);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Ok',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              )),
                        ],
                      );
                    }),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )))
      ],
    ),
  );
}

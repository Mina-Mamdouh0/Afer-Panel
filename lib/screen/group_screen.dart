import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panelafer/Compoands/widget.dart';
import 'package:panelafer/cuibt/cuibt.dart';
import 'package:panelafer/cuibt/states.dart';
import 'package:panelafer/screen/lecture_screen.dart';

class GroupScreen extends StatefulWidget {
  final String groupName;
  const GroupScreen({Key? key, required this.groupName}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  bool isAdd = true;
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AfeerCuibt, AfeerState>(listener: (context, state) {
      if (state is UploadVideoLoading) {
        const CircularProgressIndicator();
      }
    }, builder: (context, state) {
      var cuibt = AfeerCuibt.get(context);
      return Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.groupName,
                  style: const TextStyle(
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
                          cuibt.getAllSubject(
                            academicYear: cuibt.selectedYear,
                            semester: cuibt.selectedSubjectSemester,
                          );
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
              isAdd
                  ? Column(
                      children: [
                        myTextField(
                            controller: cuibt.subjectNameController,
                            hint: 'Add Subject',
                            onTap: () {},
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        myTextField(
                            controller: cuibt.teacherNameController,
                            hint: 'Add Teacher name',
                            onTap: () {},
                            keyboardType: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          onTap: () => cuibt.uploadPhotoTeacher(
                            nameTeacher: cuibt.teacherNameController.text,
                            context: context,
                          ),
                          title: const Text('Upload Photo Teacher'),
                          leading: const Icon(Icons.photo_library_rounded),
                          subtitle: const Text(
                              "please be sure you write the teacher name correctly first"),
                          selectedColor: Colors.teal,
                          selected: cuibt.photoUrl.isNotEmpty,
                          trailing: cuibt.photoUrl.isNotEmpty
                              ? const Icon(Icons.done)
                              : const Icon(Icons.close),
                          tileColor: Colors.red[300],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        myButton(
                            text: 'add subject',
                            width: 600.0,
                            height: 50.0,
                            onPressed: () {
                              cuibt.addNewSubject(
                                academicYear: cuibt.selectedYear,
                                semester: cuibt.selectedSubjectSemester,
                                subjectName: cuibt.subjectNameController.text,
                                teacherName: cuibt.teacherNameController.text,
                                photoUrl: cuibt.photoUrl,
                              );
                            })
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (cuibt.subjects.isNotEmpty)
                          Wrap(
                            spacing: 100,
                            runSpacing: 20,
                            children: List.generate(
                                cuibt.subjects.length,
                                (i) => subjectModel(
                                      nameSubject: cuibt.subjects[i].name!,
                                      nameTeacher:
                                          cuibt.subjects[i].teacherName!,
                                      urlPhoto:
                                          cuibt.subjects[i].urlPhotoTeacher!,
                                      context: context,
                                    )),
                          ),
                        if (cuibt.subjects.isEmpty)
                          const Align(
                            heightFactor: 6,
                            alignment: Alignment.center,
                            child: Text(
                              'No Subject Yet',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        if (cuibt.subjects.isEmpty)
                          const Align(
                            heightFactor: 5,
                            alignment: Alignment.center,
                            child: Text(
                              'return and add Subject',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          )
                      ],
                    )
            ],
          ),
        ),
      );
    });
  }

  Widget subjectModel(
      {required String nameSubject,
      required String nameTeacher,
      required String urlPhoto,
      required BuildContext context
      }) {
    return InkWell(
      onTap: ()  {
        if(AfeerCuibt.get(context).checkAccess(nameSubject)||AfeerCuibt.get(context).userModule!.isAdmin!) {
          navigator(
              returnPage: true,
              context: context,
              page: LectureScreen(
                nameSubject: nameSubject,
              ));
        }
      },
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
              backgroundImage: NetworkImage(urlPhoto),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              nameSubject,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              nameTeacher,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

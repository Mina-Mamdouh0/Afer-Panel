// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panelafer/Compoands/widget.dart';
import 'package:panelafer/Module/exam.dart';
import 'package:panelafer/cuibt/states.dart';

import '../../cuibt/cuibt.dart';

enum Answer { one, two, three, four }

class ExamScreen extends StatefulWidget {
  String nameSubject = "";
  String nameLecture = "";

  ExamScreen({Key? key, required this.nameSubject, required this.nameLecture})
      : super(key: key);
  @override
  State<ExamScreen> createState() =>
      _ExamScreenState(nameSubject: nameSubject, nameLecture: nameLecture);
}

class _ExamScreenState extends State<ExamScreen> {
  _ExamScreenState({this.nameSubject, this.nameLecture});

  String? nameSubject;
  String? nameLecture;
  late final TextEditingController questionController =
      TextEditingController(text: '');

  late final TextEditingController answerQuestionOneController =
      TextEditingController(text: '');
  late final TextEditingController answerQuestionTwoController =
      TextEditingController(text: '');
  late final TextEditingController answerQuestionThreeController =
      TextEditingController(text: '');
  late final TextEditingController answerQuestionFourController =
      TextEditingController(text: '');

  late final TextEditingController editQuestionController =
      TextEditingController(text: '');

  late final TextEditingController editAnswerQuestionOneController =
      TextEditingController(text: '');
  late final TextEditingController editAnswerQuestionTwoController =
      TextEditingController(text: '');
  late final TextEditingController editAnswerQuestionThreeController =
      TextEditingController(text: '');
  late final TextEditingController editAnswerQuestionFourController =
      TextEditingController(text: '');

  var formKey = GlobalKey<FormState>();
  var editFormKey = GlobalKey<FormState>();

  bool isAdd = false;
  bool isShow = true;

  void changeAdd() {
    setState(() {
      isAdd = true;
      isShow = false;
    });
  }

  void changeEdit() {
    setState(() {
      isAdd = false;
      isShow = true;
    });
    AfeerCuibt.get(context).getQuestion(
      academicYear: AfeerCuibt.get(context).selectedYear,
      semester: AfeerCuibt.get(context).selectedSemester,
      subjectName: nameSubject!,
      nameLecture: nameLecture!,
      context: context,
    );
  }

  bool isCorrectAnswer({required String text, required String correct}) {
    if (correct == text) {
      return true;
    } else {
      return false;
    }
  }

  Answer answer = Answer.one;
  String? answerQuestion;
  Future<void> getAnswer(Answer value) async {
    if (value == Answer.one) {
      answerQuestion = answerQuestionOneController.text;
    }
    if (value == Answer.two) {
      answerQuestion = answerQuestionTwoController.text;
    }
    if (value == Answer.three) {
      answerQuestion = answerQuestionThreeController.text;
    }
    if (value == Answer.four) {
      answerQuestion = answerQuestionFourController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocConsumer<AfeerCuibt, AfeerState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AfeerCuibt.get(context);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
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
                const Center(
                  child: Text(
                    'Exam',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: changeAdd,
                        child: const Text('Add'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: changeEdit,
                        child: const Text('Show'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: isAdd
                          ? Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    myTextField(
                                      controller: questionController,
                                      hint: 'Question',
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: myTextField(
                                            controller:
                                                answerQuestionOneController,
                                            hint: 'Question One',
                                          ),
                                        ),
                                        Expanded(
                                          child: Radio(
                                            value: Answer.one,
                                            groupValue: answer,
                                            onChanged: (Answer? ans) {
                                              setState(() {
                                                answer = ans!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: myTextField(
                                            controller:
                                                answerQuestionTwoController,
                                            hint: 'Question Two',
                                          ),
                                        ),
                                        Expanded(
                                          child: Radio(
                                            value: Answer.two,
                                            groupValue: answer,
                                            onChanged: (Answer? ans) {
                                              setState(() {
                                                answer = ans!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: myTextField(
                                            controller:
                                                answerQuestionThreeController,
                                            hint: 'Question Three',
                                          ),
                                        ),
                                        Expanded(
                                          child: Radio(
                                            value: Answer.three,
                                            groupValue: answer,
                                            onChanged: (Answer? ans) {
                                              setState(() {
                                                answer = ans!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: myTextField(
                                            controller:
                                                answerQuestionFourController,
                                            hint: 'Question Four',
                                          ),
                                        ),
                                        Expanded(
                                          child: Radio(
                                            value: Answer.four,
                                            groupValue: answer,
                                            onChanged: (Answer? ans) {
                                              setState(() {
                                                answer = ans!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: myButton(
                                            text: ' Save',
                                            onPressed: () {
                                              getAnswer(answer).then((value) {
                                                cubit.uploadNewQuestion(
                                                    academicYear:
                                                        cubit.selectedYear,
                                                    semester:
                                                        cubit.selectedSemester,
                                                    subjectName: nameSubject!,
                                                    nameLecture: nameLecture!,
                                                    question:
                                                        questionController.text,
                                                    correctAnswer:
                                                        answerQuestion!,
                                                    answer1:
                                                        answerQuestionOneController
                                                            .text,
                                                    answer2:
                                                        answerQuestionTwoController
                                                            .text,
                                                    answer3:
                                                        answerQuestionThreeController
                                                            .text,
                                                    answer4:
                                                        answerQuestionFourController
                                                            .text);

                                                questionController.clear();
                                                answerQuestionOneController
                                                    .clear();
                                                answerQuestionTwoController
                                                    .clear();
                                                answerQuestionThreeController
                                                    .clear();
                                                answerQuestionFourController
                                                    .clear();
                                              });
                                            },
                                            width: 20.0,
                                            height: 40.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: myButton(
                                            text: 'Not Save',
                                            onPressed: () {},
                                            width: 20.0,
                                            height: 40.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: cubit.questions.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(20),
                                            margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.white38,
                                              border: Border.all(
                                                  color: Colors.green,
                                                  width: 2),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cubit.questions[index]
                                                      .question!,
                                                  style: const TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  cubit.questions[index]
                                                      .answer1!,
                                                  style: TextStyle(
                                                    color: isCorrectAnswer(
                                                            text: cubit
                                                                .questions[
                                                                    index]
                                                                .answer1!,
                                                            correct: cubit
                                                                .questions[
                                                                    index]
                                                                .correctAnswer!)
                                                        ? Colors.teal
                                                        : Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  cubit.questions[index]
                                                      .answer2!,
                                                  style: TextStyle(
                                                    color: isCorrectAnswer(
                                                            text: cubit
                                                                .questions[
                                                                    index]
                                                                .answer2!,
                                                            correct: cubit
                                                                .questions[
                                                                    index]
                                                                .correctAnswer!)
                                                        ? Colors.teal
                                                        : Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  cubit.questions[index]
                                                      .answer3!,
                                                  style: TextStyle(
                                                    color: isCorrectAnswer(
                                                            text: cubit
                                                                .questions[
                                                                    index]
                                                                .answer3!,
                                                            correct: cubit
                                                                .questions[
                                                                    index]
                                                                .correctAnswer!)
                                                        ? Colors.teal
                                                        : Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  cubit.questions[index]
                                                      .answer4!,
                                                  style: TextStyle(
                                                    color: isCorrectAnswer(
                                                            text: cubit
                                                                .questions[
                                                                    index]
                                                                .answer4!,
                                                            correct: cubit
                                                                .questions[
                                                                    index]
                                                                .correctAnswer!)
                                                        ? Colors.teal
                                                        : Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    5.0),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        'Edit',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.blue)),
                                                                    content:
                                                                        SizedBox(
                                                                      width:
                                                                          500,
                                                                      child:
                                                                          Form(
                                                                        key:
                                                                            editFormKey,
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            myTextField(
                                                                              controller: editQuestionController,
                                                                              hint: cubit.questions[index].question!,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: myTextField(
                                                                                    controller: editAnswerQuestionOneController,
                                                                                    hint: cubit.questions[index].answer1!,
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Radio(
                                                                                    value: Answer.one,
                                                                                    groupValue: answer,
                                                                                    onChanged: (Answer? ans) {
                                                                                      setState(() {
                                                                                        answer = ans!;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: myTextField(
                                                                                    controller: editAnswerQuestionTwoController,
                                                                                    hint: cubit.questions[index].answer2!,
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Radio(
                                                                                    value: Answer.two,
                                                                                    groupValue: answer,
                                                                                    onChanged: (Answer? ans) {
                                                                                      setState(() {
                                                                                        answer = ans!;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: myTextField(
                                                                                    controller: editAnswerQuestionThreeController,
                                                                                    hint: cubit.questions[index].answer3!,
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Radio(
                                                                                    value: Answer.three,
                                                                                    groupValue: answer,
                                                                                    onChanged: (Answer? ans) {
                                                                                      setState(() {
                                                                                        answer = ans!;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: myTextField(
                                                                                    controller: editAnswerQuestionFourController,
                                                                                    hint: cubit.questions[index].answer4!,
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Radio(
                                                                                    value: Answer.four,
                                                                                    groupValue: answer,
                                                                                    onChanged: (Answer? ans) {
                                                                                      setState(() {
                                                                                        answer = ans!;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'Cancel',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                          )),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            getAnswer(answer).then((value) =>
                                                                                {
                                                                                  cubit.updateNewQuestion(academicYear: cubit.selectedYear, semester: cubit.selectedSemester, subjectName: nameSubject!, question: Question(id: cubit.questions[index].id, question: editQuestionController.text, answer1: editAnswerQuestionOneController.text, answer2: editAnswerQuestionTwoController.text, answer3: editAnswerQuestionThreeController.text, answer4: editAnswerQuestionFourController.text, correctAnswer: answerQuestion!), nameLecture: nameLecture!)
                                                                                });

                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'Ok',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                          child: const Text(
                                                              'Edit'),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    5.0),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title:
                                                                        const Text(
                                                                      'Delete',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            25,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                    elevation:
                                                                        10,
                                                                    content:
                                                                        const Text(
                                                                      'Im Sure Delete Item',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'Cancel',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.blue,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                          )),
                                                                      TextButton(
                                                                          onPressed: () {cubit.deleteQuestion(
                                                                      academicYear: cubit.selectedYear,
                                                                      semester: cubit.selectedSemester,
                                                                      subjectName: nameSubject!,
                                                                      nameLecture: nameLecture!,
                                                                      context: context,
                                                                      id: cubit.questions[index].id!
                                                                      );
                                                                         Navigator.pop(context);
                                                                          },
                                                                          child: const Text(
                                                                            'Ok',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  );
                                                                }
                                                                );
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .red),
                                                          ),
                                                          child: const Text(
                                                              'Delete'),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ));
                                      }),
                                ),
                              ],
                            )),
                )
              ],
            );
          }),
    );
  }
}

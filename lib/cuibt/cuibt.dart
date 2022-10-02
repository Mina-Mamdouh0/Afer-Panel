import 'dart:math';
import 'dart:typed_data';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_file/internet_file.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:panelafer/Compoands/widget.dart';
import 'package:panelafer/Module/video.dart';
import 'package:panelafer/Module/photo_moudle.dart';
import 'package:panelafer/cuibt/states.dart';
import 'package:panelafer/screen/home_screen.dart';
import '../Module/exam.dart';
import '../Module/pdf.dart';
import '../Module/subject_Info.dart';
import '../Module/user_module.dart';
import 'package:firebase_dart/storage.dart';

import '../Module/lecture_model.dart';
import '../screen/showScreens/show_pdf.dart';
import '../screen/showScreens/show_photo.dart';
import '../screen/showScreens/show_videos.dart';
import '../screen/showScreens/show_exam.dart';

class AfeerCuibt extends Cubit<AfeerState> {
  AfeerCuibt() : super(InitState());

  static AfeerCuibt get(context) => BlocProvider.of(context);
  Photo? photoInfo;
  Video? videoInfo;
  Pdf? pdfInfo;
  List<Question> questions = [];
  Uint8List? bytes;
  List<ModelLecture> listLecture = [];
//Login Var
  var emailControllerLogin = TextEditingController();
  var passwordControllerLogin = TextEditingController();
  var loginFormKey = GlobalKey<FormState>();
  bool isObscure = true;
  UserModule? userModule;
  //Signup Var
  var emailControllerSignUp = TextEditingController();
  var passwordControllerSignUp = TextEditingController();
  var nameControllerSignUp = TextEditingController();
  var signUpFormKey = GlobalKey<FormState>();
  List<bool> access = [false, false, false, false, false];
  Map<String, bool> accessSubject = {};
  // variable for add subject screen
  var subjectNameController = TextEditingController();
  var teacherNameController = TextEditingController();
  String photoUrl = '';
  String selectedYear = "First Year";
  String selectedSemester = "First semester";
  String selectedSubjectSemester = "First semester";
  List<SubjectInfo> subjects = [];
  // variable for add lecture screen
  var lectureNameController = TextEditingController();
  var lectureDescriptionController = TextEditingController();
  // variable for add video screen
  bool isPaid = false;
  var priceController = TextEditingController();
  bool uploadLoading = false;
//set the access of subject to account
  void setAccess(int index, bool value, String subject) {
    if (value == false) {
      accessSubject.addEntries([MapEntry(subject, !value)]);
    }
    if (value == true) {
      accessSubject.remove(subject);
    }
    emit(ChangeAccess());
  }

// to sure that user have access to subject
  bool checkAccess(String subject) {
    return accessSubject.containsKey(subject);
  }

//Firebase auth
  void createUserProfile({
    required String name,
    required String email,
    required String pass,
    required String uid,
    required Map<String, bool> access,
  }) {
    UserModule? user = UserModule(
      name: name,
      email: email,
      access: access,
      uid: uid,
    );
    Firestore.instance
        .collection("Admin Users")
        .document(uid)
        .set(user.toJson())
        .then((value) {
      emit(CreateUserSuccessfully());
    }).catchError((onError) {
      emit(CreateUserFailed());
    });
  }

  //create user field
  void createNewUser(context) {
    FirebaseAuth.instance
        .signUp(emailControllerSignUp.text, passwordControllerSignUp.text)
        .then((value) {
      Navigator.pop(context);
      createUserProfile(
        email: emailControllerSignUp.text,
        name: nameControllerSignUp.text,
        uid: value.id,
        pass: passwordControllerSignUp.text,
        access: accessSubject,
      );
    }).catchError((onError) {
      emit(CreateUserFailed());
    });
  }

  void getUserInfo(String uid, context) {
    Firestore.instance
        .collection("Admin Users")
        .document(uid)
        .get()
        .then((value) {
      userModule = UserModule.fromJson(value.map);
      userModule!.access!.forEach((key, value) {
        if (value == true) {
          accessSubject.addEntries([MapEntry(key, value)]);
        }
      });
      navigator(context: context, returnPage: false, page: const HomeScreen());
    });
  }

  //login user
  void loginUser(context) {
    FirebaseAuth.instance
        .signIn(emailControllerLogin.text, passwordControllerLogin.text)
        .then((value) {
      getUserInfo(value.id, context);
      emit(LoginUserSuccessfully());
    }).catchError((onError) {
      MotionToast.error(
              title: const Text("Error"), description: Text(onError.toString()))
          .show(context);
      emit(LoginUserFailed());
    });
  }

  //Login methods
  void togglePasswordVisibility() {
    isObscure = !isObscure;
    emit(TogglePasswordVisibility());
  }

// change password
  void changePassword(String email) {
    FirebaseAuth.instance.resetPassword(email).then((value) {
      emit(ChangePasswordSuccessfully());
    }).catchError((onError) {
      emit(ChangePasswordFailed());
    });
  }

// create subject
  void addNewSubject({
    required String academicYear,
    required String semester,
    required String subjectName,
    required String teacherName,
    required String photoUrl,
  }) {
    Random random2 = Random.secure();
    var randomNumber2 = random2.nextInt(200);
    SubjectInfo? subject = SubjectInfo(
      name: subjectName,
      id: "$academicYear$semester$subjectName$randomNumber2",
      teacherName: teacherNameController.text,
      urlPhotoTeacher: photoUrl,
    );
    Firestore.instance
        .collection("Academic year")
        .document(academicYear)
        .collection(semester)
        .document(subjectName)
        .set(subject.toJson())
        .then((value) {
      subjectNameController.clear();
      teacherNameController.clear();
      photoUrl = '';
      emit(CreateSubjectSuccessfully());
    }).catchError((onError) {
      emit(CreateSubjectFailed());
    });
  }

  void addNewLecture({
    required String academicYear,
    required String semester,
    required String subjectName,
  }) {
    ModelLecture? lecture = ModelLecture(
      lectureName: lectureNameController.text,
      lectureDescription: lectureDescriptionController.text,
    );
    Firestore.instance
        .collection("Academic year")
        .document(academicYear)
        .collection(semester)
        .document(subjectName)
        .collection("Lecture")
        .document(lectureNameController.text)
        .set(lecture.toJson())
        .then((value) {
      lectureNameController.clear();
      lectureDescriptionController.clear();
      emit(CreateLectureSuccessfully());
    }).catchError((onError) {
      emit(CreateLectureFailed());
    });
  }

  void getAllLecture({
    required String academicYear,
    required String semester,
    required String subjectName,
  }) {
    Firestore.instance
        .collection("Academic year")
        .document(academicYear)
        .collection(semester)
        .document(subjectName)
        .collection("Lecture")
        .get()
        .then((value) {
      listLecture.clear();
      for (var element in value) {
        listLecture.add(ModelLecture.fromJson(element.map));
      }
      emit(CreateLectureSuccessfully());
    }).catchError((onError) {
      emit(CreateLectureFailed());
    });
  }

// get subject
  void getAllSubject({
    required String academicYear,
    required String semester,
  }) {
    Firestore.instance
        .collection("Academic year")
        .document(academicYear)
        .collection(semester)
        .get()
        .then((value) {
      subjects.clear();
      for (var element in value) {
        subjects.add(SubjectInfo.fromJson(element.map));
      }
      emit(CreateSubjectSuccessfully());
    }).catchError((onError) {
      emit(CreateSubjectFailed());
    });
  }

  void uploadNewVideo(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String linkVideo,
      required String description,
      required String nameLecture}) {
    var video = Video(
      description: description,
      linkVideo: linkVideo,
      isPaid: isPaid,
      point: priceController.text,
      id: "$academicYear$subjectName$nameLecture${linkVideo.substring(70, 80)}",
    );
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            nameLecture: nameLecture,
            type: "videos")
        .document(video.id!)
        .set(video.toJson())
        .then((value) {
      if (video.isPaid) {
        secureDataVideo(videoId: video.id);
      }
      emit(UploadVideoSuccessfully());
    }).catchError((onError) {
      emit(UploadVideoFailed());
    });
  }

  void uploadNewPdf(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String linkPdf,
      required String description,
      required String nameLecture}) {
    var pdf = Pdf(
      isPaid: isPaid,
      description: description,
      linkPdf: linkPdf,
      point: priceController.text,
      id: "$academicYear$semester$subjectName$nameLecture${linkPdf.substring(15, 20)}",
    );
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            nameLecture: nameLecture,
            type: "pdf")
        .document(pdf.id!)
        .set(pdf.toJson())
        .then((value) {
      if (pdf.isPaid) {
        secureDataPdf(pdfId: pdf.id);
      }
      emit(UploadPdfSuccessfully());
    }).catchError((onError) {
      emit(UploadPdfFailed());
    });
  }

  void uploadNewPhoto(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String linkPhoto,
      required String description,
      required String nameLecture}) {
    var photo = Photo(
      isPaid: isPaid,
      description: description,
      linkPhoto: linkPhoto,
      point: priceController.text,
      id: "$academicYear$semester$subjectName$nameLecture${linkPhoto.substring(15, 20)}",
    );
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            nameLecture: nameLecture,
            type: "photo")
        .document(photo.id!)
        .set(photo.toJson())
        .then((value) {
      if (photo.isPaid) {
        secureDataPhoto(photoId: photo.id);
      }
      emit(UploadPhotoSuccessfully());
    }).catchError((onError) {
      emit(UploadPhotoFailed());
    });
  }

  void uploadNewQuestion(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String question,
      required String answer1,
      required String answer2,
      required String answer3,
      required String answer4,
      required String correctAnswer,
      required String nameLecture}) {
    var questions = Question(
      question: question,
      answer1: answer1,
      answer2: answer2,
      answer3: answer3,
      answer4: answer4,
      correctAnswer: correctAnswer,
      id: "$academicYear$semester$subjectName$nameLecture${question.length * 22}",
    );
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            nameLecture: nameLecture,
            type: "Question")
        .document(questions.id!)
        .set(questions.toJson())
        .then((value) {
      emit(UploadPhotoSuccessfully());
    }).catchError((onError) {
      emit(UploadPhotoFailed());
    });
  }

  void updateNewQuestion(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required Question question,
      required String nameLecture}) {
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            nameLecture: nameLecture,
            type: "Question")
        .document(question.id!)
        .update(question.toJson())
        .then((value) {
      emit(UploadPhotoSuccessfully());
    }).catchError((onError) {
      emit(UploadPhotoFailed());
    });
  }

//upload video into storage
  void uploadNewVideoStorage({
    required String academicYear,
    required String semester,
    required String subjectName,
    required String description,
    required String nameLecture,
    required BuildContext context,
  }) async {
    {
      // method to pick file and upload it to storage
      OpenFilePicker()
        ..filterSpecification = {
          'Video': '*.mp4',
        }
        ..defaultFilterIndex = 0
        ..defaultExtension = 'mp4'
        ..title = 'Select a video'
        ..getFile()!.readAsBytes().then((value) {
          showLoaderDialog(context);
          FirebaseStorage.instance
              .ref()
              .child(
                  "videos/$subjectName/$nameLecture/${Uri.file(value.toString().substring(0, 26)).pathSegments.last}")
              .putData(value)
              .then((value) {
            //upload video link to firebase
            if (value.state == TaskState.success) {
              value.ref.getDownloadURL().then((value) {
                Navigator.pop(context);
                uploadNewVideo(
                    academicYear: academicYear,
                    semester: semester,
                    subjectName: subjectName,
                    linkVideo: value,
                    description: description,
                    nameLecture: nameLecture);
              });
            } else {
              Navigator.pop(context);
              MotionToast.error(
                description: const Text(
                  "Upload Failed",
                  style: TextStyle(color: Colors.white),
                ),
                title: const Text(
                  "Error",
                  style: TextStyle(color: Colors.white),
                ),
              ).show(context);
              emit(UploadVideoFailed());
            }
          }).catchError((onError) {
            Navigator.pop(context);
            MotionToast.error(
              description: const Text(
                "Upload Failed",
                style: TextStyle(color: Colors.white),
              ),
              title: const Text(
                "Error",
                style: TextStyle(color: Colors.white),
              ),
            ).show(context);

            emit(UploadVideoFailed());
          });
        });
    }
  }

  void uploadNewPdfStorage({
    required String academicYear,
    required String semester,
    required String subjectName,
    required String description,
    required String nameLecture,
    required BuildContext context,
  }) async {
    {
      // method to pick file and upload it to storage
      OpenFilePicker()
        ..filterSpecification = {
          'Pdf': '*.pdf',
        }
        ..defaultFilterIndex = 0
        ..defaultExtension = 'pdf'
        ..title = 'Select a pdf'
        ..getFile()!.readAsBytes().then((pdf) {
          showLoaderDialog(context);

          FirebaseStorage.instance
              .ref()
              .child("pdf/$subjectName/$nameLecture/$description")
              .putData(pdf)
              .then((value) {
                if(value.state == TaskState.success) {
                  value.ref.getDownloadURL().then((value) {
                    Navigator.pop(context);
                    uploadNewPdf(
                        academicYear: academicYear,
                        semester: semester,
                        subjectName: subjectName,
                        linkPdf: value,
                        description: description,
                        nameLecture: nameLecture);
                  });
                } else {
                  Navigator.pop(context);
                  MotionToast.error(
                    description: const Text(
                      "Upload Failed",
                      style: TextStyle(color: Colors.white),
                    ),
                    title: const Text(
                      "Error",
                      style: TextStyle(color: Colors.white),
                    ),
                  ).show(context);
                  emit(UploadPdfFailed());
                }
            //upload video link to firebase
          }).catchError((onError) {
            Navigator.pop(context);
            MotionToast.error(
              description: const Text(
                "Upload Failed",
                style: TextStyle(color: Colors.white),
              ),
              title: const Text(
                "Error",
                style: TextStyle(color: Colors.white),
              ),
            ).show(context);
            emit(UploadPdfFailed());
          });
        });
    }
  }

  void uploadNewPhotoStorage({
    required String academicYear,
    required String semester,
    required String subjectName,
    required String description,
    required String nameLecture,
    required BuildContext context,
  }) async {
    {
      // method to pick file and upload it to storage
      OpenFilePicker()
        ..filterSpecification = {
          'jpg': '*.jpg',
          'png': '*.png',
          "WebP": "*.webp",
        }
        ..defaultFilterIndex = 0
        ..defaultExtension = 'jpg'
        ..title = 'Select a photo'
        ..getFile()!.readAsBytes().then((photo) {
          showLoaderDialog(context);
          FirebaseStorage.instance
              .ref()
              .child("photo/$subjectName/$nameLecture/$description")
              .putData(photo)
              .then((value) {
            //upload video link to firebase
            if(value.state==TaskState.success){
                  Navigator.pop(context);
                  value.ref.getDownloadURL().then((value) {
                    uploadNewPhoto(
                      academicYear: academicYear,
                      semester: semester,
                      subjectName: subjectName,
                      linkPhoto: value,
                      description: description,
                      nameLecture: nameLecture,
                    );
                  }).catchError((onError) {
                    emit(UploadPhotoFailed());
                  });

                }
          }).catchError((onError) {
Navigator.pop(context);
MotionToast.error(
  description: const Text(
    "Upload Failed",
    style: TextStyle(color: Colors.white),
  ),
  title: const Text(
    "Error",
    style: TextStyle(color: Colors.white),
  ),
).show(context);
emit(UploadPhotoFailed());
          });
        }).catchError((onError) {
          emit(UploadPhotoFailed());
        });
    }
  }

  void uploadPhotoTeacher({required String nameTeacher,required BuildContext context}) async {
    OpenFilePicker()
      ..filterSpecification = {
        'jpg': '*.jpg',
        'png': '*.png',
        "WebP": "*.webp",
      }
      ..defaultFilterIndex = 0
      ..defaultExtension = 'jpg'
      ..title = 'Select a photo'
      ..getFile()!.readAsBytes().then((photo) {
        showLoaderDialog(context);

        FirebaseStorage.instance
          .ref()
          .child("photoTeacher/$nameTeacher")
          .putData(photo)
          .then((value) {
          value.ref
              .getDownloadURL()
              .then((url) {
            photoUrl = url;
            emit(UploadTeacherPhotoSuccessfully());
            }).catchError((onError) {
        emit(UploadTeacherPhotoFailed());
      });});
    } );
  }

  void getPhoto(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String nameLecture,
      required BuildContext context}) {
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            nameLecture: nameLecture,
            type: "photo")
        .get()
        .then((value) {
      photoInfo = Photo.fromJson(value.last.map);
      navigator(
          returnPage: true,
          context: context,
          page: ShowPhoto(
            url: photoInfo!.linkPhoto!,
          ));
      emit(GetPhotoSuccessfully());
    }).catchError((onError) {
      emit(GetPhotoFailed());
    });
  }

  void getVideo({
    required String academicYear,
    required String semester,
    required String subjectName,
    required String nameLecture,
    required BuildContext context,
  }) {
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            nameLecture: nameLecture,
            type: "videos")
        .get()
        .then((value) {
      videoInfo = Video.fromJson(value.last.map);
      navigator(
          returnPage: true,
          context: context,
          page: VideoShow(
            url: videoInfo!.linkVideo!,
          ));
      emit(GetVideoSuccessfully());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(GetVideoFailed());
    });
  }

  void getPdf({
    required String academicYear,
    required String semester,
    required String subjectName,
    required String nameLecture,
    required BuildContext context,
  }) {
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            nameLecture: nameLecture,
            type: "pdf")
        .get()
        .then((value) async {
      pdfInfo = Pdf.fromJson(value.last.map);
      bytes = await InternetFile.get(
        pdfInfo!.linkPdf!,
        progress: (receivedLength, contentLength) {
          final percentage = receivedLength / contentLength * 100;
          showLoaderDialog(context, );
          if(percentage == 100){
            Navigator.pop(context);
            navigator(returnPage: true, context: context, page: const ShowPdf());
          }

        },

      );
      emit(GetPdfSuccessfully());
    }).catchError((onError) {
      emit(GetPdfFailed());
    });
  }

  void getQuestion({
    required String academicYear,
    required String semester,
    required String subjectName,
    required String nameLecture,
    required BuildContext context,
  }) {
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            nameLecture: nameLecture,
            type: "Question")
        .get()
        .then((value) {
      questions.clear();
      for (var element in value) {
        questions.add(Question.fromJson(element.map));
      }
      navigator(
          returnPage: true,
          context: context,
          page: ExamScreen(
            nameSubject: subjectName,
            nameLecture: nameLecture,
          ));
      emit(GetPdfSuccessfully());
    }).catchError((onError) {
      emit(GetPdfFailed());
    });
  }

  void deleteQuestion({
    required String academicYear,
    required String semester,
    required String subjectName,
    required String nameLecture,
    required String id,
    required BuildContext context,
  }) {
    _dataReference(
            academicYear: academicYear,
            semester: semester,
            subjectName: subjectName,
            nameLecture: nameLecture,
            type: "Question")
        .document(id)
        .delete()
        .then((value) => getQuestion(
            academicYear: academicYear,
            semester: semester,
            context: context,
            nameLecture: nameLecture,
            subjectName: subjectName));
  }

//data path reference
  CollectionReference _dataReference(
      {required String academicYear,
      required String semester,
      required String subjectName,
      required String nameLecture,
      required String type}) {
    return Firestore.instance
        .collection("Academic year")
        .document(academicYear)
        .collection(semester)
        .document(subjectName)
        .collection("Lecture")
        .document(nameLecture)
        .collection(type);
  }

  void secureDataVideo({videoId}) {
    Firestore.instance
        .collection("secure")
        .document("video")
        .collection(videoId)
        .document(userModule!.uid!)
        .set({"uid": userModule!.uid, "videoId": videoId})
        .then((value) => emit(SecureDataSuccessfully()))
        .catchError((onError) => emit(SecureDataFailed()));
  }

  void secureDataPdf({pdfId}) {
    Firestore.instance
        .collection("secure")
        .document("Pdf")
        .collection(pdfId)
        .document(userModule!.uid!)
        .set({"uid": userModule!.uid, "pdfId": pdfId})
        .then((value) => emit(SecureDataSuccessfully()))
        .catchError((onError) => emit(SecureDataFailed()));
  }

  void secureDataPhoto({photoId}) {
    Firestore.instance
        .collection("secure")
        .document("photo")
        .collection(photoId)
        .document(userModule!.uid!)
        .set({"uid": userModule!.uid, "photoId": photoId})
        .then((value) => emit(SecureDataSuccessfully()))
        .catchError((onError) => emit(SecureDataFailed()));
  }

  void secureDataExam({examId}) {
    Firestore.instance
        .collection("secure")
        .document("video")
        .collection(examId)
        .document(userModule!.uid!)
        .set({"uid": userModule!.uid, "examId": examId})
        .then((value) => emit(SecureDataSuccessfully()))
        .catchError((onError) => emit(SecureDataFailed()));
  }

  void togglePaid(value) {
    isPaid = value;
    emit(TogglePaidSuccessfully());
  }

  void forgetPassword({required String email, context}) {
    FirebaseAuth.instance.resetPassword(email).then((value) {
      Navigator.pop(context);
      emit(ForgetPasswordSuccessfully());
    }).catchError((onError) {
      emit(ForgetPasswordFailed());
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: SizedBox(
        height: 100,
        width: 100,
        child: Column(children: const [
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text(
            "Loading...",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w700, color: Colors.blue),
          )
        ]),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

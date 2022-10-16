class SubjectInfo {
  String? name;
  String? id;
  String? teacherName;
  String? urlPhotoTeacher;
  String? academicYear;

  SubjectInfo(
      {
        this.name,
        this.id,
        this.teacherName,
        this.urlPhotoTeacher,
        this.academicYear,
       });
  SubjectInfo.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    id = json['id'];
    teacherName = json['teacherName'];
    urlPhotoTeacher = json['urlPhotoTeacher'];
    academicYear = json['AcademicYear'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'name': name,
      'id': id,
      'teacherName': teacherName,
      'urlPhotoTeacher': urlPhotoTeacher,
      'AcademicYear': academicYear,

    };
  }
}

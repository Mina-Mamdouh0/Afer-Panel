class SubjectInfo {
  String? name;
  String? id;
  String? teacherName;
  String? urlPhotoTeacher;

  SubjectInfo(
      {
        this.name,
        this.id,
        this.teacherName,
        this.urlPhotoTeacher,
       });
  SubjectInfo.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    id = json['id'];
    teacherName = json['teacherName'];
    urlPhotoTeacher = json['urlPhotoTeacher'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'name': name,
      'id': id,
      'teacherName': teacherName,
      'urlPhotoTeacher': urlPhotoTeacher,

    };
  }
}

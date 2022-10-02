class ModelLecture{
  String ?lectureName;
  String ?lectureDescription;
  ModelLecture({this.lectureName, this.lectureDescription});
  ModelLecture.fromJson(Map<String, dynamic> json) {
    lectureName = json['Name'];
    lectureDescription = json['Description'];
  }
  Map<String, dynamic> toJson() {
   return {
      'Name': lectureName,
      'Description': lectureDescription,
    };

  }
}
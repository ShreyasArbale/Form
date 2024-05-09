class TaskList {
  String? subject;
  String? status;
  String? name;
  String? priority;
  String? expEndDate;

  TaskList(
      {this.subject, this.status, this.name,
        this.priority, this.expEndDate
      });

  TaskList.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    status = json['status'];
    name = json['name'];
    priority = json['priority'];
    expEndDate = json['exp_end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['status'] = this.status;
    data['name'] = this.name;
    data['priority'] = this.priority;
    data['exp_end_date'] = this.expEndDate;
    return data;
  }
}
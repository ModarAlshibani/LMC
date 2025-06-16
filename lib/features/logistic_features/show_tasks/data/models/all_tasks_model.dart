import 'package:lmc_app/features/for_all/login/data/models/login_response.dart';

class AllTasksModel {
  User? user;
  List<CreatedTasks>? createdTasks;
  List<AssignedTasks>? assignedTasks;

  AllTasksModel({this.user, this.createdTasks, this.assignedTasks});

  AllTasksModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['created_tasks'] != null) {
      createdTasks = <CreatedTasks>[];
      json['created_tasks'].forEach((v) {
        createdTasks!.add(new CreatedTasks.fromJson(v));
      });
    }
    if (json['assigned_tasks'] != null) {
      assignedTasks = <AssignedTasks>[];
      json['assigned_tasks'].forEach((v) {
        assignedTasks!.add(new AssignedTasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.createdTasks != null) {
      data['created_tasks'] =
          this.createdTasks!.map((v) => v.toJson()).toList();
    }
    if (this.assignedTasks != null) {
      data['assigned_tasks'] =
          this.assignedTasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class AssignedTasks {
  int? id;
  int? creatorId;
  String? description;
  String? status;
  String? deadline;
  int? requiresInvoice;
  String? completedAt;
  String? createdAt;
  String? updatedAt;
  List<Users>? users;

  AssignedTasks({
    this.id,
    this.creatorId,
    this.description,
    this.status,
    this.deadline,
    this.requiresInvoice,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
    this.users,
  });

  AssignedTasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['CreatorId'];
    description = json['Description'];
    status = json['Status'];
    deadline = json['Deadline'];
    requiresInvoice = json['RequiresInvoice'];
    completedAt = json['Completed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CreatorId'] = this.creatorId;
    data['Description'] = this.description;
    data['Status'] = this.status;
    data['Deadline'] = this.deadline;
    data['RequiresInvoice'] = this.requiresInvoice;
    data['Completed_at'] = this.completedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreatedTasks {
  int? id;
  int? creatorId;
  String? description;
  String? status;
  String? deadline;
  String? completedAt;
  String? createdAt;
  String? updatedAt;
  List<Users>? users;

  CreatedTasks({
    this.id,
    this.creatorId,
    this.description,
    this.status,
    this.deadline,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
    this.users,
  });

  CreatedTasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['CreatorId'];
    description = json['Description'];
    status = json['Status'];
    deadline = json['Deadline'];
    completedAt = json['Completed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CreatorId'] = this.creatorId;
    data['Description'] = this.description;
    data['Status'] = this.status;
    data['Deadline'] = this.deadline;
    data['Completed_at'] = this.completedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? email;
  Pivot? pivot;

  Users({this.id, this.name, this.email, this.pivot});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? taskId;
  int? userId;
  int? completed;
  String? createdAt;
  String? updatedAt;

  Pivot({
    this.taskId,
    this.userId,
    this.completed,
    this.createdAt,
    this.updatedAt,
  });

  Pivot.fromJson(Map<String, dynamic> json) {
    taskId = json['TaskId'];
    userId = json['UserId'];
    completed = json['Completed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TaskId'] = this.taskId;
    data['UserId'] = this.userId;
    data['Completed'] = this.completed;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

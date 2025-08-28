

import 'dart:convert';

List<BranchResponseModel> branchResponseModelFromJson(String str) => List<BranchResponseModel>.from(json.decode(str).map((x) => BranchResponseModel.fromJson(x)));


class BranchResponseModel {
    final int? id;
    final String? name;
    final bool? status;
    final int? createdBy;
    final String? createdByName;
    final dynamic createdAt;

    BranchResponseModel({
        this.id,
        this.name,
        this.status,
        this.createdBy,
        this.createdByName,
        this.createdAt,
    });

    factory BranchResponseModel.fromJson(Map<String, dynamic> json) => BranchResponseModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createdBy: json["created_by"],
        createdByName: json["created_by_name"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_by": createdBy,
        "created_by_name": createdByName,
        "created_at": createdAt,
    };
}
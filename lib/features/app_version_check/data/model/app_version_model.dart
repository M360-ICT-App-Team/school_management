import 'dart:convert';
AppVersionModel appVersionModelFromJson(String str) => AppVersionModel.fromJson(json.decode(str));

class AppVersionModel {
    final String? appName;
    final String? packageName;
    final String? playStoreVersion;
    final String? appStoreVersion;
    final String? microsoftStoreVersion;
    final bool? forceUpdate;
    final bool? isPause;
    final String? appIcon;
    final String? playStoreLink;
    final String? appStoreLink;
    final dynamic microsoftStoreLink;
    final int? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? createdBy;
    final dynamic updatedBy;

    AppVersionModel({
        this.appName,
        this.packageName,
        this.playStoreVersion,
        this.appStoreVersion,
        this.microsoftStoreVersion,
        this.forceUpdate,
        this.isPause,
        this.appIcon,
        this.playStoreLink,
        this.appStoreLink,
        this.microsoftStoreLink,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
    });

    factory AppVersionModel.fromJson(Map<String, dynamic> json) => AppVersionModel(
        appName: json["app_name"],
        packageName: json["package_name"],
        playStoreVersion: json["play_store_version"],
        appStoreVersion: json["app_store_version"],
        microsoftStoreVersion: json["microsoft_store_version"],
        forceUpdate: json["force_update"],
        isPause: json["is_pause"],
        appIcon: json["app_icon"],
        playStoreLink: json["play_store_link"],
        appStoreLink: json["app_store_link"],
        microsoftStoreLink: json["microsoft_store_link"],
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
    );

    Map<String, dynamic> toJson() => {
        "app_name": appName,
        "package_name": packageName,
        "play_store_version": playStoreVersion,
        "app_store_version": appStoreVersion,
        "microsoft_store_version": microsoftStoreVersion,
        "force_update": forceUpdate,
        "is_pause": isPause,
        "app_icon": appIcon,
        "play_store_link": playStoreLink,
        "app_store_link": appStoreLink,
        "microsoft_store_link": microsoftStoreLink,
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
    };
}

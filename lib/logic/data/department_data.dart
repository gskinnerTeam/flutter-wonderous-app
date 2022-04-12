import 'package:json_annotation/json_annotation.dart';

part 'department_data.g.dart';

@JsonSerializable()
class DepartmentData {
  DepartmentData({required this.departmentId, required this.displayName});
  final int departmentId;
  final String displayName;

  factory DepartmentData.fromJson(Map<String, dynamic> json) => _$DepartmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentDataToJson(this);
}

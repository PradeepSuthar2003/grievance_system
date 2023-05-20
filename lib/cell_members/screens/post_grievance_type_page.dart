import 'package:flutter/material.dart';
import 'package:lj_grievance/cell_members/forms/post_grievance_type_form.dart';

class PostGrievanceType{
  bool isSelected = false;
  Widget postGrievanceType({BuildContext? context}){
    return PostGrievanceTypeForm().postGrievanceForm();
  }
}
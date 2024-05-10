import 'package:family_tree/model/child_model.dart';
import 'package:family_tree/model/grand_parent_model.dart';
import 'package:family_tree/model/parent_model.dart';

class ParentChildCombineModel{
  final List<ParentModel> parentModel;
  final List<ChildModel> childModel;

  ParentChildCombineModel(this.parentModel, this.childModel);
}
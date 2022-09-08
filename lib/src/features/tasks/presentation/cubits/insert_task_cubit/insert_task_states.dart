abstract class InsertTaskStates {}

class InitialInsertTaskState extends InsertTaskStates {}

class LoadingInsertTaskState extends InsertTaskStates {}

class InsertTaskSuccessState extends InsertTaskStates {}

class InsertTaskErrorState extends InsertTaskStates {
  final String error;

  InsertTaskErrorState({required this.error});
}

class ChangeCategoryValueState extends InsertTaskStates {}

class ChangeRemindValueState extends InsertTaskStates {}

class ChangeRepeatValueState extends InsertTaskStates {}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/src/core/app_cubit/app_states.dart';
import 'package:simple_todo_app/src/core/helpers/local/cache_helper.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/widgets/loading_widget.dart';
import '../../features/tasks/presentation/widgets/all_tasks.dart';
import '../../features/tasks/presentation/widgets/complete_tasks.dart';
import '../../features/tasks/presentation/widgets/incomplete_tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  changeTheme() {
    isDark = !isDark;
    CacheHelper.saveData(key: 'isDarkTheme', value: isDark).then((value) {
      emit(ChangeThemeState());
    });
  }

  cachedTheme(bool? isDark) {
    if (isDark != null) {
      this.isDark = isDark;
    } else {
      this.isDark = this.isDark;
    }
  }

  List<Widget> screens = [
    AllTasksScreen(),
    const CompleteTasks(),
    const IncompleteTasks(),
  ];

  List<BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'All',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.check_circle_outline),
      label: 'Complete',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.circle_outlined),
      label: 'Incomplete',
    ),
  ];

  int currentIndex = 0;

  void changeNavBarIndex(int index) {
    currentIndex = index;
    emit(ChangeTodoNavBarState());
  }
}

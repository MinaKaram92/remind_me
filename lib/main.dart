import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/src/config/routes/route_manager.dart';
import 'package:simple_todo_app/src/core/app_cubit/app_cubit.dart';
import 'package:simple_todo_app/src/core/app_cubit/app_states.dart';
import 'package:simple_todo_app/src/core/bloc_observer.dart';
import 'package:simple_todo_app/src/core/helpers/local/local_notifications_helper/notification_service.dart';
import 'package:simple_todo_app/src/core/injection_container.dart' as di;
import 'package:simple_todo_app/src/core/resources/constants_manager.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/get_tasks_cubit/get_tasks_cubit.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/tasks_operation_cubit/tasks_operations_cubit.dart';
import 'src/config/themes/theme_manager.dart';
import 'src/core/helpers/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await CacheHelper.init();
  await NotificationService().init();

  bool? isDark = CacheHelper.getData(key: 'isDarkTheme');
  AppConstants.boardingFinished = CacheHelper.getData(key: 'islastOnboarding');

  CacheHelper.deleteData(key: 'islastOnboarding');
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        isDark: isDark,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp({required this.isDark});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => di.sl<AppCubit>()..cachedTheme(isDark)),
        BlocProvider(
            create: (context) => di.sl<GetTasksCubit>()..getAllTasks()),
        BlocProvider(create: (context) => di.sl<TasksOperationsCubit>()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}

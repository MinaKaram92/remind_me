import 'package:get_it/get_it.dart';
import 'package:simple_todo_app/src/core/app_cubit/app_cubit.dart';
import 'package:simple_todo_app/src/features/tasks/data/data_source/local_data_source/database/database_repository.dart';
import 'package:simple_todo_app/src/features/tasks/data/data_source/local_data_source/database/database_repository_impl.dart';
import 'package:simple_todo_app/src/features/tasks/data/repository/task_repository_impl.dart';
import 'package:simple_todo_app/src/features/tasks/domain/repository/todo_repository.dart';
import 'package:simple_todo_app/src/features/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:simple_todo_app/src/features/tasks/domain/usecases/get_all_tasks_usecase.dart';
import 'package:simple_todo_app/src/features/tasks/domain/usecases/insert_task_usecase.dart';
import 'package:simple_todo_app/src/features/tasks/domain/usecases/update_task_usecase.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/get_tasks_cubit/get_tasks_cubit.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/tasks_operation_cubit/tasks_operations_cubit.dart';

import '../features/tasks/presentation/cubits/insert_task_cubit/insert_task_cubit.dart';

final sl = GetIt.instance;

void init() {
  sl.registerFactory(() => GetTasksCubit(
        getAllTasksUsecase: sl(),
      ));

  sl.registerFactory(() => TasksOperationsCubit(
        deleteTaskUsecase: sl(),
        updateTaskUsecase: sl(),
      ));

  sl.registerFactory(() => InsertTaskCubit(insertTaskUsecase: sl()));

  sl.registerFactory(() => AppCubit());

  sl.registerLazySingleton(() => GetAllTasksUsecase(todoRepository: sl()));

  sl.registerLazySingleton(() => UpdateTaskUsecase(todoRepository: sl()));

  sl.registerLazySingleton(() => DeleteTaskUsecase(todoRepository: sl()));

  sl.registerLazySingleton(() => InsertTaskUsecase(todoRepository: sl()));

  sl.registerLazySingleton<TodoRepository>(
      () => TaskRepositoryImpl(databaseRepository: sl()));

  sl.registerLazySingleton<DatabaseRepository>(() => DatabaseRepositoryImpl());
}

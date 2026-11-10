import 'package:shoply_clone/core/model/admin/admin_stats.dart';

abstract class AdminState {}

class AdminInitState extends AdminState {}

class AdminLoadingState extends AdminState {}

class AdminNoAccessState extends AdminState {}

class AdminLoadedState extends AdminState {
  AdminLoadedState({required this.stats});

  final AdminStats stats;
}

class AdminErrorState extends AdminState {
  AdminErrorState({required this.message});

  final String message;
}

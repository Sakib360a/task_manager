class Urls{
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String registrationUrl = '$_baseUrl/Registration';
  static const String loginUrl = '$_baseUrl/Login';
  static const String createTask = '$_baseUrl/createTask';
  static const String taskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static const String newTasksUrl = '$_baseUrl/listTaskByStatus/New';
  static const String inProgressTaskUrl = '$_baseUrl/listTaskByStatus/InProgress';
  static const String completedTaskUrl = '$_baseUrl/listTaskByStatus/Completed';
  static const String cancelledTaskUrl = '$_baseUrl/listTaskByStatus/Cancelled';
  static const String deleteTaskUrl = '$_baseUrl/deleteTask';
  static const String updateTaskUrl = '$_baseUrl/updateTaskStatus';
  static const String profileUpdateUrl = '$_baseUrl/ProfileUpdate';
}
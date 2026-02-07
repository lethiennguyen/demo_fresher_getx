class ApiUrl {
  static const baseUrl = 'http://192.168.1.115:8080/api/v1/';

  /// Login
  static const login = 'login';

  /// Fetch Data User Info
  static const products = 'products';

  ///Lấy danh sách phân trang/lọc công việc thuộc dự án/thường xuyên
  static const workTaskList = 'WorkTask/page';

  /// Thêm công việc mới
  static const addTask = 'WorkTask/add';

  /// Lấy Danh sách dự án theo nhân viên
  static const getAllProjectByStaff = 'WorkTaskProject/get-all-by-staff';

  ///Lấy danh sách toàn bộ thành viên
  static const getAppStaffPage = 'StaffProfile/basic-page';

  /// Fetch List Project
  static const workProjectList = 'WorkTaskProject/get-all-by-staff';

  /// Fetch List Project Page
  static const workProjectPageList = 'WorkTaskProject/page';

  /// Fetch Projdect Detail By Id
  static const workProjectDetailById = 'WorkTaskProject/detail';

  /// Fetch List Due
  static const workTaskByDue = 'WorkTask/list-by-due-type';

  /// Fetch List Task Group
  static const workTaskGroups = 'WorkTaskProject/work-task-groups';

  /// Fetch List Admin
  static const managers = 'WorkTaskProject/managers';

  /// Fetch List Participants
  static const participants = 'WorkTaskProject/participants';

  /// Danh sách API.
  static const apiMap = 'https://app.easyhrm.vn/ApiMap.json';

  /// Get Detail Task
  static const getDetailTask = 'WorkTask/detail';

  /// Get is Manager
  static const isManager = 'WorkTask/is-manager';

  /// Update progress
  static const updateProgress = 'WorkTask/update-progress';

  /// Update task
  static const updateTask = 'WorkTask/update';

  /// Delete task
  static const deleteTask = 'WorkTask/delete';

  /// Statistic task
  static const statisticTask = 'WorkTaskProject/statistic';

  /// Statistic task
  static const addReminderTask = 'WorkTask/add-reminder';

  /// detail reminder task
  static const detailReminderTask = 'WorkTask/reminder';

  /// notification
  static const notificationTask = 'Notification/page';

  /// read notification
  static const readNotificationTask = 'Notification/read';

  /// read all notification
  static const readAllNotificationTask = 'Notification/read-all';

  /// notification
  static const addRecurringTask = 'WorkTask/add-repeat';

  /// notification
  static const detailRecurringTask = 'WorkTask/repeat';
}

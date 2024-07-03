class ApiEndpoints {
  static const String baseUrl = "https://agro.cpf-phil.com/edmrs_approver/api/";
  // static const String baseUrl = "https://agro.cpf-phil.com/edmrs_approver/test/";
  static AuthEndPoints authEndPoints = AuthEndPoints();
}

class AuthEndPoints {
  final String login = 'login';
  final String balance = 'getNurseBalance';
  final String employee = 'getEmployee';
  final String empInfo = 'getEmpInfo';
  final String medicalInfo = 'getMedicalInfo';
  final String medicalRecord = 'submitMedicalRecord';
  final String billMaster = 'getBillMaster';
  final String getInbox = 'getNurseApproval';
  final String requestData = 'getNurseRequestDetails';
  final String approve = 'approveRequest';
  final String reject = 'rejectRequest';
}

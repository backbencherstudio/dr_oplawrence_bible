class ApiEndpoints {
  // ================== Base Url ========================
  static const String baseUrl = "https://bible.pixelstack.cloud/";
  // ================== Auth Part =======================
  static const String users = 'api/auth/register';
  static const String verifyemail = 'api/auth/verify-email';
  static const String login = 'api/auth/login';
  static const String forgetPassword = 'api/auth/forgot-password';
  static const String resetPassword = 'api/auth/reset-password';
  static const String switchRole = 'api/auth/switch-role';
  static const String verifyMail = 'api/auth/verify-email';
  static const String resendOtp = 'api/auth/resend-verification-email';
  static const String loadUser = 'api/auth/me';
  // ================== Bible Part ======================
  static const String bibleBooks = 'api/application/bible/books';
  static const String bibleChapters = 'api/application/bible/chapters';
  static const String bibleVerse = 'api/application/bible/verses';
  static const String bibleNotes = 'api/application/bible/notes';
  static const String bibleExplain = "api/application/bible/explain";
  // ============== Quiz Api Service ====================
  static String quizQuestion(int level) =>
      'api/application/quiz?level=$level&page=1&limit=10';
  static const String updateProfile = 'api/auth/update-profile';
  static const String createAndagetJob = 'api/jobs';
  static const String quizStart = 'api/application/quiz/attempt/start';
  static const String quizAttemAnswer = 'api/application/quiz/attempt/answer';
  static String quizAttempt(String attemptId) {
  return "api/application/quiz/attempt/$attemptId";
}




  // ================= Home Api Services ================
  static const String bibleDaily = 'api/application/bible/daily';
  static const String bibleMaditation = 'api/application/bible/meditation';
  static const String bibleSearch = 'api/application/bible/search';
  // ================== plan Audio ======================
  static const String plainAudio = 'api/application/bible/audio';

  // ================ Donate part ============
  static const String  donateMoney = 'api/payment/stripe/donate';
}

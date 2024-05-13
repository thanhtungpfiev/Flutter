extension StringExt on String {
  String get obscureEmail {
    final email = this;
    final emailParts = email.split('@');
    final emailName = emailParts[0];
    final emailDomain = emailParts[1];
    final emailNameLength = emailName.length;
    final emailNameFirstHalf = emailName.substring(0, emailNameLength ~/ 2);
    final emailNameSecondHalf = emailName.substring(emailNameLength ~/ 2);
    final emailNameObscured = '*' * emailNameLength;
    return '$emailNameFirstHalf$emailNameObscured'
        '$emailNameSecondHalf@$emailDomain';
  }
}

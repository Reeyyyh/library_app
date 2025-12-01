import 'dart:math';

String generateRedeemCode() {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  String code = '';
  for (int i = 0; i < 7; i++) {
    code += characters[random.nextInt(characters.length)];
  }
  return code;
}

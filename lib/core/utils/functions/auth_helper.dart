
import 'package:firebase_auth/firebase_auth.dart';

Future<void> checkEmailVerification(User user) async {
  const timeout = Duration(seconds: 200);
  final endTime = DateTime.now().add(timeout);
  while (!user.emailVerified && DateTime.now().isBefore(endTime)) {
    await Future.delayed(const Duration(seconds: 20));
    await user.reload();

    user = FirebaseAuth.instance.currentUser!;
  }
}

Future<bool> waitForEmailVerification(User user) async {
  const timeout = Duration(seconds: 200);
  const interval = Duration(seconds: 20);
  final endTime = DateTime.now().add(timeout);

  while (DateTime.now().isBefore(endTime)) {
    await Future.delayed(interval);
    await user.reload();
    user = FirebaseAuth.instance.currentUser!;

    if (user.emailVerified) {
      return true;
    }
  }
  return false;
}

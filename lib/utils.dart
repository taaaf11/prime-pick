import 'dart:math';

bool isPrime(int n) {
  if (n <= 1) {
    return false;
  }

  for (int i = 2; i <= pow(n, 1 / 2).toInt(); i++) {
    if (n % i == 0) {
      return false;
    }
  }

  return true;
}

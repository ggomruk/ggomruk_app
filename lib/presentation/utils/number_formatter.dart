class NumberFormatter {
  static String tcToPercentage(double tc) {
    // -0.00085 -> 0.085
    return (tc * -100).toStringAsFixed(3);
  }

  static double percentageToTc(String percentage) {
    // 0.085 -> -0.00085
    final value = double.tryParse(percentage);
    if (value != null) {
      return -(value / 100);
    }
    return 0;
  }
}

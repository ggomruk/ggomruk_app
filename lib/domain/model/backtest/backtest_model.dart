class BacktestModel {
  final String strategyName;
  final Performance performance;
  final LeveragePerformance leveragePerformance;
  final String uid;

  BacktestModel({
    required this.strategyName,
    required this.performance,
    required this.leveragePerformance,
    required this.uid,
  });
}

class Performance {
  final double sharpe;
  final double cstrategy;
  final double bAndH;
  final double cagr;
  final double annMean;
  final double annStd;
  final int trades;
  final double initialUsdt;
  final double finalUsdt;

  Performance({
    required this.sharpe,
    required this.cstrategy,
    required this.bAndH,
    required this.cagr,
    required this.annMean,
    required this.annStd,
    required this.trades,
    required this.initialUsdt,
    required this.finalUsdt,
  });
}

class LeveragePerformance {
  final int leverageApplied;
  final double sharpe;
  final double cstrategy;
  final double cagr;
  final double annMean;
  final double annStd;
  final double finalUsdtLevered;

  LeveragePerformance({
    required this.leverageApplied,
    required this.sharpe,
    required this.cstrategy,
    required this.cagr,
    required this.annMean,
    required this.annStd,
    required this.finalUsdtLevered,
  });
}
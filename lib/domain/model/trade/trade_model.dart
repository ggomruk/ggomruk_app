class TradeModel {
  final String task;
  final String uid;
  final TradeParamsModel params;
  final double position;
  final bool isTrading;

  TradeModel({
    this.task = 'trade',
    required this.uid,
    required this.params,
    this.position = 0,
    this.isTrading = false,
  });

  TradeModel copyWith({
    String? task,
    String? uid,
    TradeParamsModel? params,
    double? position,
    bool? isTrading,
  }) {
    return TradeModel(
      task: task ?? this.task,
      uid: uid ?? this.uid,
      params: params ?? this.params,
      position: position ?? this.position,
      isTrading: isTrading ?? this.isTrading,
    );
  }
}

class TradeParamsModel {
  final String symbol;
  final String interval;
  final Map<String, Map<String, dynamic>> strategies;

  TradeParamsModel({
    required this.symbol,
    required this.interval,
    required this.strategies,
  });
}
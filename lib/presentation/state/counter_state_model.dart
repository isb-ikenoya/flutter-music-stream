class CounterStateModel {
  // データの項目
  final int count;
  final String message;

  // コンストラクタ
  CounterStateModel({required this.count, required this.message});

  CounterStateModel copyWith({int? count, String? message}) {
    return CounterStateModel(
      count: count ?? this.count,
      message: message ?? this.message,
    );
  }

}
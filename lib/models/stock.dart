class Stock {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;
  final double dailyChangePercentage;
  final String description;
  final String marketCap;
  final String peRatio;
  final String volume;
  final double openPrice;
  final double highPrice;
  final double lowPrice;

  Stock({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.dailyChangePercentage,
    required this.description,
    required this.marketCap,
    required this.peRatio,
    required this.volume,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
  });
}

import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/stock.dart';
import '../data/mock_data.dart';

class MarketProvider with ChangeNotifier {
  List<Stock> _stocks = [];
  Timer? _simulationTimer;
  final Random _random = Random();

  List<Stock> get stocks => _stocks;

  MarketProvider() {
    // Initialize with mock data
    _stocks = List.from(MockData.stocks);
    _startSimulation();
  }

  void _startSimulation() {
    // Update every 2 seconds
    _simulationTimer = Timer.periodic(Duration(milliseconds: 1500), (timer) {
      _simulateMarketMovement();
    });
  }

  void _simulateMarketMovement() {
    // Pick a random stock index
    int index = _random.nextInt(_stocks.length);
    Stock stock = _stocks[index];

    // Generate a small random percentage change (-0.5% to +0.5%)
    double changePercent = (_random.nextDouble() - 0.5) * 0.5; // range -0.25 to +0.25 effective
    
    // Update Price
    double newPrice = stock.currentPrice * (1 + (changePercent / 100));
    
    // Update Daily Change
    double newDailyChange = stock.dailyChangePercentage + changePercent;

    // Create new immutable stock object with all fields preserved
    Stock updatedStock = Stock(
      id: stock.id,
      name: stock.name,
      symbol: stock.symbol,
      currentPrice: newPrice,
      dailyChangePercentage: newDailyChange,
      description: stock.description,
      marketCap: stock.marketCap,
      peRatio: stock.peRatio,
      volume: stock.volume,
      openPrice: stock.openPrice,
      highPrice: stock.highPrice, 
      lowPrice: stock.lowPrice,
    );

    _stocks[index] = updatedStock;
    notifyListeners();
  }

  @override
  void dispose() {
    _simulationTimer?.cancel();
    super.dispose();
  }
}

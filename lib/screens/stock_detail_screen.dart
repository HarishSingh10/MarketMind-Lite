import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../widgets/gradient_background.dart';
import '../theme.dart';

class StockDetailScreen extends StatelessWidget {
  final Stock stock;

  const StockDetailScreen({Key? key, required this.stock}) : super(key: key);

  String getAIComment(double change) {
    if (change > 2.0) return "🚀 Strong upward momentum today.";
    if (change >= 0.0) return "📈 Stable performance today.";
    return "⚠️ Market sentiment looks weak, review fundamentals.";
  }

  @override
  Widget build(BuildContext context) {
    bool isPositive = stock.dailyChangePercentage >= 0;
    Color changeColor = isPositive ? AppTheme.accentGreen : AppTheme.accentRed;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(stock.symbol),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Center(
                child: Column(
                  children: [
                    Text(
                      stock.name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$${stock.currentPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: changeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: changeColor.withOpacity(0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                            color: changeColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${stock.dailyChangePercentage.abs().toStringAsFixed(2)}% Today',
                            style: TextStyle(
                              color: changeColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Mock Chart Section
              Text("Price History (24H)", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppTheme.surfaceDark.withOpacity(0.5),
                  border: Border.all(color: Colors.white10),
                  gradient: LinearGradient(
                    colors: [
                      changeColor.withOpacity(0.2),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: CustomPaint(
                  painter: _ChartPainter(color: changeColor),
                ),
              ),
              
              SizedBox(height: 32),

              // Key Stats Grid
              Text(
                "Key Statistics",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 2.0, // Increased height ratio to prevent overflow
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                   _buildStatCard("Market Cap", stock.marketCap),
                   _buildStatCard("Volume", stock.volume),
                   _buildStatCard("P/E Ratio", stock.peRatio),
                   _buildStatCard("Open", "\$${stock.openPrice.toStringAsFixed(2)}"),
                   _buildStatCard("High", "\$${stock.highPrice.toStringAsFixed(2)}"),
                   _buildStatCard("Low", "\$${stock.lowPrice.toStringAsFixed(2)}"),
                ],
              ),
               SizedBox(height: 32),

              // About Section
              Text(
                "About ${stock.name}",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                stock.description,
                style: TextStyle(color: Colors.grey[300], height: 1.5, fontSize: 16),
              ),

              SizedBox(height: 32),
              
              // AI Insight Card
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.2),
                      AppTheme.secondaryColor.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.psychology, color: AppTheme.secondaryColor),
                        SizedBox(width: 8),
                        Text(
                          "MarketMind AI Analysis",
                          style: TextStyle(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      getAIComment(stock.dailyChangePercentage),
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final Color color;
  _ChartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    final path = Path();
    // Draw a simple mock jagged line
    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.2, size.height * 0.8);
    path.lineTo(size.width * 0.4, size.height * 0.5);
    path.lineTo(size.width * 0.6, size.height * 0.6);
    path.lineTo(size.width * 0.8, size.height * 0.3);
    path.lineTo(size.width, size.height * 0.4);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

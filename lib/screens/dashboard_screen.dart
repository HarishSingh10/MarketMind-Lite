import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/market_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/stock_card.dart';
import '../widgets/gradient_background.dart';
import '../widgets/app_logo.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // We can also get the user name here to greet them
    final userProvider = Provider.of<UserProvider>(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            children: [
              AppLogo(size: 32, showText: false),
              SizedBox(width: 12),
              Text('MarketMind Lite'),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${userProvider.userName}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              Text(
                'Market Overview',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Consumer<MarketProvider>(
                  builder: (context, market, child) {
                    return ListView.builder(
                      itemCount: market.stocks.length,
                      itemBuilder: (context, index) {
                        return StockCard(stock: market.stocks[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

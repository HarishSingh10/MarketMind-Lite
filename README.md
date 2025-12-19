# MarketMind Lite

MarketMind Lite is a modern, fintech-style Flutter application designed to simulate a stock market dashboard and a learning management system (LMS) for financial education.

## 🚀 Features

### 1. 📈 Dashboard
- **Live Market Simulation**: Displays 5 stocks (e.g., Apple, Tesla) with real-time price updates every 1.5 seconds.
- **Stock Cards**: Modern UI showing Stock Name, Symbol, Current Price, and Daily % Change.
- **Visual Indicators**: Color-coded changes (Green for positive, Red for negative).

### 2. 🔍 Stock Detail Page
- **Detailed View**: Shows in-depth information for the selected stock.
- **AI Analysis**: Dynamic, rule-based commentary on stock performance:
  - 🚀 "Strong upward momentum" (> 2%)
  - 📈 "Stable performance" (0-2%)
  - ⚠️ "Market sentiment looks weak" (< 0%)

### 3. 🎓 Learning Hub (LMS)
- **Course List**: Access 3 educational modules (Stock Basics, Technical Analysis, Risk Management).
- **Progress Tracking**: 
  - Real-time progress bars.
  - "Mark as Complete" functionality persists progress locally.
  - Progress is saved even after closing the app.

### 4. 🧭 Navigation
- **Bottom Navigation Bar**: Seamless switching between Dashboard, Learning Hub, and Profile.
- **Profile Tab**: View total course completion stats and logout option.

### 5. 🔐 Authentication & Data
- **Local Login/Signup**: Simulates authentication with persistent user sessions.
- **Auto-Login**: functionality keeps users logged in upon app restart.
- **Data Persistence**: Uses `shared_preferences` to store user sessions and course progress locally.

## 🛠 Tech Stack
- **Framework**: Flutter (Dart)
- **State Management**: Provider (MultiProvider architecture)
- **Styling**: Google Fonts (Outfit), Custom Dark Theme, Glassmorphism effects.
- **Animations**: flutter_animate for smooth UI transitions.
- **Storage**: shared_preferences for local data persistence.

## 📱 How to Run
1. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
2. **Run the App**:
   ```bash
   flutter run
   ```

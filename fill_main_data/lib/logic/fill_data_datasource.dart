import 'package:base/models/portfolio_main_data.dart';

abstract class FillDataDataSource{
  Future addTheData(PortfolioMainData portfolioMainData);
}
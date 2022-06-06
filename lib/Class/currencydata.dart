class CurrencyData{
  String currency;
  String imagePath;
  String symbol;

  CurrencyData({
    required this.symbol,
    required this.currency,
    required this.imagePath,
  });

  static getCurrencyData(String cur,String path,String sym){
    return CurrencyData(currency: cur, imagePath: path,symbol:sym );
  }

}
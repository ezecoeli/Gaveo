class CurrencyInfo {
  final String flag;
  final String nameEs;
  final String nameEn;
  final String code;
  final String symbol;

  const CurrencyInfo({
    required this.flag,
    required this.nameEs,
    required this.nameEn,
    required this.code,
    required this.symbol,
  });

  String localizedName(String locale) => locale == 'en' ? nameEn : nameEs;
}

const List<CurrencyInfo> kCurrencies = [
  // LATAM first
  CurrencyInfo(flag: '🇦🇷', nameEs: 'Peso argentino',     nameEn: 'Argentine peso',      code: 'ARS', symbol: '\$'),
  CurrencyInfo(flag: '🇨🇱', nameEs: 'Peso chileno',       nameEn: 'Chilean peso',        code: 'CLP', symbol: '\$'),
  CurrencyInfo(flag: '🇲🇽', nameEs: 'Peso mexicano',      nameEn: 'Mexican peso',        code: 'MXN', symbol: '\$'),
  CurrencyInfo(flag: '🇨🇴', nameEs: 'Peso colombiano',    nameEn: 'Colombian peso',      code: 'COP', symbol: '\$'),
  CurrencyInfo(flag: '🇺🇾', nameEs: 'Peso uruguayo',      nameEn: 'Uruguayan peso',      code: 'UYU', symbol: '\$'),
  CurrencyInfo(flag: '🇧🇴', nameEs: 'Boliviano',          nameEn: 'Bolivian boliviano',  code: 'BOB', symbol: 'Bs'),
  CurrencyInfo(flag: '🇵🇾', nameEs: 'Guaraní paraguayo',  nameEn: 'Paraguayan guaraní',  code: 'PYG', symbol: '₲'),
  CurrencyInfo(flag: '🇵🇪', nameEs: 'Sol peruano',        nameEn: 'Peruvian sol',        code: 'PEN', symbol: 'S/'),
  CurrencyInfo(flag: '🇧🇷', nameEs: 'Real brasileño',     nameEn: 'Brazilian real',      code: 'BRL', symbol: 'R\$'),
  CurrencyInfo(flag: '🇻🇪', nameEs: 'Bolívar venezolano', nameEn: 'Venezuelan bolívar',  code: 'VES', symbol: 'Bs.S'),
  CurrencyInfo(flag: '🇪🇨', nameEs: 'Dólar ecuatoriano',  nameEn: 'Ecuadorian dollar',   code: 'USD', symbol: '\$'),
  CurrencyInfo(flag: '🇵🇦', nameEs: 'Balboa panameño',    nameEn: 'Panamanian balboa',   code: 'PAB', symbol: 'B/'),
  CurrencyInfo(flag: '🇨🇷', nameEs: 'Colón costarricense',nameEn: 'Costa Rican colón',   code: 'CRC', symbol: '₡'),
  CurrencyInfo(flag: '🇬🇹', nameEs: 'Quetzal guatemalteco',nameEn:'Guatemalan quetzal',  code: 'GTQ', symbol: 'Q'),
  CurrencyInfo(flag: '🇭🇳', nameEs: 'Lempira hondureño',  nameEn: 'Honduran lempira',    code: 'HNL', symbol: 'L'),
  CurrencyInfo(flag: '🇳🇮', nameEs: 'Córdoba nicaragüense',nameEn:'Nicaraguan córdoba',  code: 'NIO', symbol: 'C\$'),
  CurrencyInfo(flag: '🇩🇴', nameEs: 'Peso dominicano',    nameEn: 'Dominican peso',      code: 'DOP', symbol: 'RD\$'),
  CurrencyInfo(flag: '🇨🇺', nameEs: 'Peso cubano',        nameEn: 'Cuban peso',          code: 'CUP', symbol: '\$'),
  // Global
  CurrencyInfo(flag: '🇺🇸', nameEs: 'Dólar estadounidense',nameEn:'US dollar',           code: 'USD', symbol: '\$'),
  CurrencyInfo(flag: '🇪🇺', nameEs: 'Euro',               nameEn: 'Euro',                code: 'EUR', symbol: '€'),
  CurrencyInfo(flag: '🇬🇧', nameEs: 'Libra esterlina',    nameEn: 'British pound',       code: 'GBP', symbol: '£'),
  CurrencyInfo(flag: '🇯🇵', nameEs: 'Yen japonés',        nameEn: 'Japanese yen',        code: 'JPY', symbol: '¥'),
  CurrencyInfo(flag: '🇨🇭', nameEs: 'Franco suizo',       nameEn: 'Swiss franc',         code: 'CHF', symbol: 'Fr'),
  CurrencyInfo(flag: '🇨🇦', nameEs: 'Dólar canadiense',   nameEn: 'Canadian dollar',     code: 'CAD', symbol: 'CA\$'),
  CurrencyInfo(flag: '🇦🇺', nameEs: 'Dólar australiano',  nameEn: 'Australian dollar',   code: 'AUD', symbol: 'A\$'),
  CurrencyInfo(flag: '🇨🇳', nameEs: 'Yuan chino',         nameEn: 'Chinese yuan',        code: 'CNY', symbol: '¥'),
  CurrencyInfo(flag: '🇮🇳', nameEs: 'Rupia india',        nameEn: 'Indian rupee',        code: 'INR', symbol: '₹'),
  CurrencyInfo(flag: '🇷🇺', nameEs: 'Rublo ruso',         nameEn: 'Russian ruble',       code: 'RUB', symbol: '₽'),
  CurrencyInfo(flag: '🇰🇷', nameEs: 'Won surcoreano',     nameEn: 'South Korean won',    code: 'KRW', symbol: '₩'),
  CurrencyInfo(flag: '🇸🇬', nameEs: 'Dólar de Singapur',  nameEn: 'Singapore dollar',    code: 'SGD', symbol: 'S\$'),
  CurrencyInfo(flag: '🇭🇰', nameEs: 'Dólar de Hong Kong', nameEn: 'Hong Kong dollar',    code: 'HKD', symbol: 'HK\$'),
  CurrencyInfo(flag: '🇳🇴', nameEs: 'Corona noruega',     nameEn: 'Norwegian krone',     code: 'NOK', symbol: 'kr'),
  CurrencyInfo(flag: '🇸🇪', nameEs: 'Corona sueca',       nameEn: 'Swedish krona',       code: 'SEK', symbol: 'kr'),
  CurrencyInfo(flag: '🇩🇰', nameEs: 'Corona danesa',      nameEn: 'Danish krone',        code: 'DKK', symbol: 'kr'),
  CurrencyInfo(flag: '🇳🇿', nameEs: 'Dólar neozelandés',  nameEn: 'New Zealand dollar',  code: 'NZD', symbol: 'NZ\$'),
  CurrencyInfo(flag: '🇿🇦', nameEs: 'Rand sudafricano',   nameEn: 'South African rand',  code: 'ZAR', symbol: 'R'),
  CurrencyInfo(flag: '🇹🇷', nameEs: 'Lira turca',         nameEn: 'Turkish lira',        code: 'TRY', symbol: '₺'),
  CurrencyInfo(flag: '🇸🇦', nameEs: 'Riyal saudí',        nameEn: 'Saudi riyal',         code: 'SAR', symbol: '﷼'),
  CurrencyInfo(flag: '🇦🇪', nameEs: 'Dírham emiratí',     nameEn: 'UAE dirham',          code: 'AED', symbol: 'د.إ'),
  CurrencyInfo(flag: '🇵🇱', nameEs: 'Esloti polaco',      nameEn: 'Polish złoty',        code: 'PLN', symbol: 'zł'),
];

/// Returns the [CurrencyInfo] matching [code], or null if not found.
/// When multiple entries share the same code (e.g. USD), returns the first one.
CurrencyInfo? currencyByCode(String code) {
  try {
    return kCurrencies.firstWhere((c) => c.code == code);
  } catch (_) {
    return null;
  }
}

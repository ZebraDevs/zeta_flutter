/// Class definition for a country with its name, dial code, and ISO code.
///
/// {@category Components}
class ZetaCountry {
  /// Constructor for [ZetaCountry]
  const ZetaCountry({
    required this.name,
    required this.dialCode,
    required this.isoCode,
  });

  /// Country's name
  final String name;

  /// Country's dial code
  final String dialCode;

  /// Country's ISO code
  final String isoCode;

  /// Country's flag URI
  String get flagUri => 'lib/assets/flags/${isoCode.toLowerCase()}.png';

  @override
  String toString() => {
        'dialCode': dialCode,
        'name': name,
        'isoCode': isoCode,
      }.toString();
}

/// Class definition for a list of countries.
///
/// {@category Interfaces}
class ZetaCountries {
  /// List of [ZetaCountry] for most countries around the world.
  static List<ZetaCountry> get list => _countriesList;
  static final List<ZetaCountry> _countriesList = [
    const ZetaCountry(
      isoCode: 'AF',
      name: 'Afghanistan',
      dialCode: '+93',
    ),
    const ZetaCountry(
      isoCode: 'AX',
      name: 'Åland Islands',
      dialCode: '+358',
    ),
    const ZetaCountry(
      isoCode: 'AL',
      name: 'Albania',
      dialCode: '+355',
    ),
    const ZetaCountry(
      isoCode: 'DZ',
      name: 'Algeria',
      dialCode: '+213',
    ),
    const ZetaCountry(
      isoCode: 'AS',
      name: 'American Samoa',
      dialCode: '+1684',
    ),
    const ZetaCountry(
      isoCode: 'AD',
      name: 'Andorra',
      dialCode: '+376',
    ),
    const ZetaCountry(
      isoCode: 'AO',
      name: 'Angola',
      dialCode: '+244',
    ),
    const ZetaCountry(
      isoCode: 'AI',
      name: 'Anguilla',
      dialCode: '+1264',
    ),
    const ZetaCountry(
      isoCode: 'AQ',
      name: 'Antarctica',
      dialCode: '+672',
    ),
    const ZetaCountry(
      isoCode: 'AG',
      name: 'Antigua and Barbuda',
      dialCode: '+1268',
    ),
    const ZetaCountry(
      isoCode: 'AR',
      name: 'Argentina',
      dialCode: '+54',
    ),
    const ZetaCountry(
      isoCode: 'AM',
      name: 'Armenia',
      dialCode: '+374',
    ),
    const ZetaCountry(
      isoCode: 'AW',
      name: 'Aruba',
      dialCode: '+297',
    ),
    const ZetaCountry(
      isoCode: 'AU',
      name: 'Australia',
      dialCode: '+61',
    ),
    const ZetaCountry(
      isoCode: 'AT',
      name: 'Austria',
      dialCode: '+43',
    ),
    const ZetaCountry(
      isoCode: 'AZ',
      name: 'Azerbaijan',
      dialCode: '+994',
    ),
    const ZetaCountry(
      isoCode: 'BS',
      name: 'Bahamas',
      dialCode: '+1242',
    ),
    const ZetaCountry(
      isoCode: 'BH',
      name: 'Bahrain',
      dialCode: '+973',
    ),
    const ZetaCountry(
      isoCode: 'BD',
      name: 'Bangladesh',
      dialCode: '+880',
    ),
    const ZetaCountry(
      isoCode: 'BB',
      name: 'Barbados',
      dialCode: '+1246',
    ),
    const ZetaCountry(
      isoCode: 'BY',
      name: 'Belarus',
      dialCode: '+375',
    ),
    const ZetaCountry(
      isoCode: 'BE',
      name: 'Belgium',
      dialCode: '+32',
    ),
    const ZetaCountry(
      isoCode: 'BZ',
      name: 'Belize',
      dialCode: '+501',
    ),
    const ZetaCountry(
      isoCode: 'BJ',
      name: 'Benin',
      dialCode: '+229',
    ),
    const ZetaCountry(
      isoCode: 'BM',
      name: 'Bermuda',
      dialCode: '+1441',
    ),
    const ZetaCountry(
      isoCode: 'BT',
      name: 'Bhutan',
      dialCode: '+975',
    ),
    const ZetaCountry(
      isoCode: 'BO',
      name: 'Bolivia (Plurinational State of)',
      dialCode: '+591',
    ),
    const ZetaCountry(
      isoCode: 'BA',
      name: 'Bosnia and Herzegovina',
      dialCode: '+387',
    ),
    const ZetaCountry(
      isoCode: 'BW',
      name: 'Botswana',
      dialCode: '+267',
    ),
    const ZetaCountry(
      isoCode: 'BV',
      name: 'Bouvet Island',
      dialCode: '+47',
    ),
    const ZetaCountry(
      isoCode: 'BR',
      name: 'Brazil',
      dialCode: '+55',
    ),
    const ZetaCountry(
      isoCode: 'IO',
      name: 'British Indian Ocean Territory',
      dialCode: '+246',
    ),
    const ZetaCountry(
      isoCode: 'BN',
      name: 'Brunei Darussalam',
      dialCode: '+673',
    ),
    const ZetaCountry(
      isoCode: 'BG',
      name: 'Bulgaria',
      dialCode: '+359',
    ),
    const ZetaCountry(
      isoCode: 'BF',
      name: 'Burkina Faso',
      dialCode: '+226',
    ),
    const ZetaCountry(
      isoCode: 'BI',
      name: 'Burundi',
      dialCode: '+257',
    ),
    const ZetaCountry(
      isoCode: 'CV',
      name: 'Cabo Verde',
      dialCode: '+238',
    ),
    const ZetaCountry(
      isoCode: 'KH',
      name: 'Cambodia',
      dialCode: '+855',
    ),
    const ZetaCountry(
      isoCode: 'CM',
      name: 'Cameroon',
      dialCode: '+237',
    ),
    const ZetaCountry(
      isoCode: 'CA',
      name: 'Canada',
      dialCode: '+1',
    ),
    const ZetaCountry(
      isoCode: 'KY',
      name: 'Cayman Islands',
      dialCode: '+1345',
    ),
    const ZetaCountry(
      isoCode: 'CF',
      name: 'Central African Republic',
      dialCode: '+236',
    ),
    const ZetaCountry(
      isoCode: 'TD',
      name: 'Chad',
      dialCode: '+235',
    ),
    const ZetaCountry(
      isoCode: 'CL',
      name: 'Chile',
      dialCode: '+56',
    ),
    const ZetaCountry(
      isoCode: 'CN',
      name: 'China',
      dialCode: '+86',
    ),
    const ZetaCountry(
      isoCode: 'CX',
      name: 'Christmas Island',
      dialCode: '+61',
    ),
    const ZetaCountry(
      isoCode: 'CC',
      name: 'Cocos (Keeling) Islands',
      dialCode: '+61',
    ),
    const ZetaCountry(
      isoCode: 'CO',
      name: 'Colombia',
      dialCode: '+57',
    ),
    const ZetaCountry(
      isoCode: 'KM',
      name: 'Comoros',
      dialCode: '+269',
    ),
    const ZetaCountry(
      isoCode: 'CG',
      name: 'Congo (Republic of the)',
      dialCode: '+242',
    ),
    const ZetaCountry(
      isoCode: 'CD',
      name: 'Congo (Democratic Republic of the)',
      dialCode: '+243',
    ),
    const ZetaCountry(
      isoCode: 'CK',
      name: 'Cook Islands',
      dialCode: '+682',
    ),
    const ZetaCountry(
      isoCode: 'CR',
      name: 'Costa Rica',
      dialCode: '+506',
    ),
    const ZetaCountry(
      isoCode: 'CI',
      name: 'Côte d`Ivoire',
      dialCode: '+225',
    ),
    const ZetaCountry(
      isoCode: 'HR',
      name: 'Croatia',
      dialCode: '+385',
    ),
    const ZetaCountry(
      isoCode: 'CU',
      name: 'Cuba',
      dialCode: '+53',
    ),
    const ZetaCountry(
      isoCode: 'CY',
      name: 'Cyprus',
      dialCode: '+357',
    ),
    const ZetaCountry(
      isoCode: 'CZ',
      name: 'Czech Republic',
      dialCode: '+420',
    ),
    const ZetaCountry(
      isoCode: 'DK',
      name: 'Denmark',
      dialCode: '+45',
    ),
    const ZetaCountry(
      isoCode: 'DJ',
      name: 'Djibouti',
      dialCode: '+253',
    ),
    const ZetaCountry(
      isoCode: 'DM',
      name: 'Dominica',
      dialCode: '+1767',
    ),
    const ZetaCountry(
      isoCode: 'DO',
      name: 'Dominican Republic',
      dialCode: '+1',
    ),
    const ZetaCountry(
      isoCode: 'EC',
      name: 'Ecuador',
      dialCode: '+593',
    ),
    const ZetaCountry(
      isoCode: 'EG',
      name: 'Egypt',
      dialCode: '+20',
    ),
    const ZetaCountry(
      isoCode: 'SV',
      name: 'El Salvador',
      dialCode: '+503',
    ),
    const ZetaCountry(
      isoCode: 'GQ',
      name: 'Equatorial Guinea',
      dialCode: '+240',
    ),
    const ZetaCountry(
      isoCode: 'ER',
      name: 'Eritrea',
      dialCode: '+291',
    ),
    const ZetaCountry(
      isoCode: 'EE',
      name: 'Estonia',
      dialCode: '+372',
    ),
    const ZetaCountry(
      isoCode: 'ET',
      name: 'Ethiopia',
      dialCode: '+251',
    ),
    const ZetaCountry(
      isoCode: 'FK',
      name: 'Falkland Islands (Malvinas)',
      dialCode: '+500',
    ),
    const ZetaCountry(
      isoCode: 'FO',
      name: 'Faroe Islands',
      dialCode: '+298',
    ),
    const ZetaCountry(
      isoCode: 'FJ',
      name: 'Fiji',
      dialCode: '+679',
    ),
    const ZetaCountry(
      isoCode: 'FI',
      name: 'Finland',
      dialCode: '+358',
    ),
    const ZetaCountry(
      isoCode: 'FR',
      name: 'France',
      dialCode: '+33',
    ),
    const ZetaCountry(
      isoCode: 'GF',
      name: 'French Guiana',
      dialCode: '+594',
    ),
    const ZetaCountry(
      isoCode: 'PF',
      name: 'French Polynesia',
      dialCode: '+689',
    ),
    const ZetaCountry(
      isoCode: 'TF',
      name: 'French Southern Territories',
      dialCode: '+262',
    ),
    const ZetaCountry(
      isoCode: 'GA',
      name: 'Gabon',
      dialCode: '+241',
    ),
    const ZetaCountry(
      isoCode: 'GM',
      name: 'Gambia',
      dialCode: '+220',
    ),
    const ZetaCountry(
      isoCode: 'GE',
      name: 'Georgia',
      dialCode: '+995',
    ),
    const ZetaCountry(
      isoCode: 'DE',
      name: 'Germany',
      dialCode: '+49',
    ),
    const ZetaCountry(
      isoCode: 'GH',
      name: 'Ghana',
      dialCode: '+233',
    ),
    const ZetaCountry(
      isoCode: 'GI',
      name: 'Gibraltar',
      dialCode: '+350',
    ),
    const ZetaCountry(
      isoCode: 'GR',
      name: 'Greece',
      dialCode: '+30',
    ),
    const ZetaCountry(
      isoCode: 'GL',
      name: 'Greenland',
      dialCode: '+299',
    ),
    const ZetaCountry(
      isoCode: 'GD',
      name: 'Grenada',
      dialCode: '+1473',
    ),
    const ZetaCountry(
      isoCode: 'GP',
      name: 'Guadeloupe',
      dialCode: '+590',
    ),
    const ZetaCountry(
      isoCode: 'GU',
      name: 'Guam',
      dialCode: '+1671',
    ),
    const ZetaCountry(
      isoCode: 'GT',
      name: 'Guatemala',
      dialCode: '+502',
    ),
    const ZetaCountry(
      isoCode: 'GG',
      name: 'Guernsey',
      dialCode: '+44',
    ),
    const ZetaCountry(
      isoCode: 'GN',
      name: 'Guinea',
      dialCode: '+224',
    ),
    const ZetaCountry(
      isoCode: 'GW',
      name: 'Guinea-Bissau',
      dialCode: '+245',
    ),
    const ZetaCountry(
      isoCode: 'GY',
      name: 'Guyana',
      dialCode: '+592',
    ),
    const ZetaCountry(
      isoCode: 'HT',
      name: 'Haiti',
      dialCode: '+509',
    ),
    const ZetaCountry(
      isoCode: 'HM',
      name: 'Heard Island and McDonald Islands',
      dialCode: '+0',
    ),
    const ZetaCountry(
      isoCode: 'VA',
      name: 'Vatican City State',
      dialCode: '+379',
    ),
    const ZetaCountry(
      isoCode: 'HN',
      name: 'Honduras',
      dialCode: '+504',
    ),
    const ZetaCountry(
      isoCode: 'HK',
      name: 'Hong Kong',
      dialCode: '+852',
    ),
    const ZetaCountry(
      isoCode: 'HU',
      name: 'Hungary',
      dialCode: '+36',
    ),
    const ZetaCountry(
      isoCode: 'IS',
      name: 'Iceland',
      dialCode: '+354',
    ),
    const ZetaCountry(
      isoCode: 'IN',
      name: 'India',
      dialCode: '+91',
    ),
    const ZetaCountry(
      isoCode: 'ID',
      name: 'Indonesia',
      dialCode: '+62',
    ),
    const ZetaCountry(
      isoCode: 'IR',
      name: 'Iran',
      dialCode: '+98',
    ),
    const ZetaCountry(
      isoCode: 'IQ',
      name: 'Iraq',
      dialCode: '+964',
    ),
    const ZetaCountry(
      isoCode: 'IE',
      name: 'Ireland',
      dialCode: '+353',
    ),
    const ZetaCountry(
      isoCode: 'IM',
      name: 'Isle of Man',
      dialCode: '+44',
    ),
    const ZetaCountry(
      isoCode: 'IL',
      name: 'Israel',
      dialCode: '+972',
    ),
    const ZetaCountry(
      isoCode: 'IT',
      name: 'Italy',
      dialCode: '+39',
    ),
    const ZetaCountry(
      isoCode: 'JM',
      name: 'Jamaica',
      dialCode: '+1876',
    ),
    const ZetaCountry(
      isoCode: 'JP',
      name: 'Japan',
      dialCode: '+81',
    ),
    const ZetaCountry(
      isoCode: 'JE',
      name: 'Jersey',
      dialCode: '+44',
    ),
    const ZetaCountry(
      isoCode: 'JO',
      name: 'Jordan',
      dialCode: '+962',
    ),
    const ZetaCountry(
      isoCode: 'KZ',
      name: 'Kazakhstan',
      dialCode: '+7',
    ),
    const ZetaCountry(
      isoCode: 'KE',
      name: 'Kenya',
      dialCode: '+254',
    ),
    const ZetaCountry(
      isoCode: 'KI',
      name: 'Kiribati',
      dialCode: '+686',
    ),
    const ZetaCountry(
      isoCode: 'XK',
      name: 'Kosovo (Republic of)',
      dialCode: '+383',
    ),
    const ZetaCountry(
      isoCode: 'KP',
      name: 'Korea (Democratic People`s Republic of)',
      dialCode: '+850',
    ),
    const ZetaCountry(
      isoCode: 'KR',
      name: 'Korea (Republic of)',
      dialCode: '+82',
    ),
    const ZetaCountry(
      isoCode: 'KW',
      name: 'Kuwait',
      dialCode: '+965',
    ),
    const ZetaCountry(
      isoCode: 'KG',
      name: 'Kyrgyzstan',
      dialCode: '+996',
    ),
    const ZetaCountry(
      isoCode: 'LA',
      name: 'Lao People`s Democratic Republic',
      dialCode: '+856',
    ),
    const ZetaCountry(
      isoCode: 'LV',
      name: 'Latvia',
      dialCode: '+371',
    ),
    const ZetaCountry(
      isoCode: 'LB',
      name: 'Lebanon',
      dialCode: '+961',
    ),
    const ZetaCountry(
      isoCode: 'LS',
      name: 'Lesotho',
      dialCode: '+266',
    ),
    const ZetaCountry(
      isoCode: 'LR',
      name: 'Liberia',
      dialCode: '+231',
    ),
    const ZetaCountry(
      isoCode: 'LY',
      name: 'Libya',
      dialCode: '+218',
    ),
    const ZetaCountry(
      isoCode: 'LI',
      name: 'Liechtenstein',
      dialCode: '+423',
    ),
    const ZetaCountry(
      isoCode: 'LT',
      name: 'Lithuania',
      dialCode: '+370',
    ),
    const ZetaCountry(
      isoCode: 'LU',
      name: 'Luxembourg',
      dialCode: '+352',
    ),
    const ZetaCountry(
      isoCode: 'MO',
      name: 'Macao',
      dialCode: '+853',
    ),
    const ZetaCountry(
      isoCode: 'MK',
      name: 'Macedonia (the former Yugoslav Republic of)',
      dialCode: '+389',
    ),
    const ZetaCountry(
      isoCode: 'MG',
      name: 'Madagascar',
      dialCode: '+261',
    ),
    const ZetaCountry(
      isoCode: 'MW',
      name: 'Malawi',
      dialCode: '+265',
    ),
    const ZetaCountry(
      isoCode: 'MY',
      name: 'Malaysia',
      dialCode: '+60',
    ),
    const ZetaCountry(
      isoCode: 'MV',
      name: 'Maldives',
      dialCode: '+960',
    ),
    const ZetaCountry(
      isoCode: 'ML',
      name: 'Mali',
      dialCode: '+223',
    ),
    const ZetaCountry(
      isoCode: 'MT',
      name: 'Malta',
      dialCode: '+356',
    ),
    const ZetaCountry(
      isoCode: 'MH',
      name: 'Marshall Islands',
      dialCode: '+692',
    ),
    const ZetaCountry(
      isoCode: 'MQ',
      name: 'Martinique',
      dialCode: '+596',
    ),
    const ZetaCountry(
      isoCode: 'MR',
      name: 'Mauritania',
      dialCode: '+222',
    ),
    const ZetaCountry(
      isoCode: 'MU',
      name: 'Mauritius',
      dialCode: '+230',
    ),
    const ZetaCountry(
      isoCode: 'YT',
      name: 'Mayotte',
      dialCode: '+262',
    ),
    const ZetaCountry(
      isoCode: 'MX',
      name: 'Mexico',
      dialCode: '+52',
    ),
    const ZetaCountry(
      isoCode: 'FM',
      name: 'Micronesia (Federated States of)',
      dialCode: '+691',
    ),
    const ZetaCountry(
      isoCode: 'MD',
      name: 'Moldova (Republic of)',
      dialCode: '+373',
    ),
    const ZetaCountry(
      isoCode: 'MC',
      name: 'Monaco',
      dialCode: '+377',
    ),
    const ZetaCountry(
      isoCode: 'MN',
      name: 'Mongolia',
      dialCode: '+976',
    ),
    const ZetaCountry(
      isoCode: 'ME',
      name: 'Montenegro',
      dialCode: '+382',
    ),
    const ZetaCountry(
      isoCode: 'MS',
      name: 'Montserrat',
      dialCode: '+1664',
    ),
    const ZetaCountry(
      isoCode: 'MA',
      name: 'Morocco',
      dialCode: '+212',
    ),
    const ZetaCountry(
      isoCode: 'MZ',
      name: 'Mozambique',
      dialCode: '+258',
    ),
    const ZetaCountry(
      isoCode: 'MM',
      name: 'Myanmar',
      dialCode: '+95',
    ),
    const ZetaCountry(
      isoCode: 'NA',
      name: 'Namibia',
      dialCode: '+264',
    ),
    const ZetaCountry(
      isoCode: 'NR',
      name: 'Nauru',
      dialCode: '+674',
    ),
    const ZetaCountry(
      isoCode: 'NP',
      name: 'Nepal',
      dialCode: '+977',
    ),
    const ZetaCountry(
      isoCode: 'NL',
      name: 'Netherlands',
      dialCode: '+31',
    ),
    const ZetaCountry(
      isoCode: 'NC',
      name: 'New Caledonia',
      dialCode: '+687',
    ),
    const ZetaCountry(
      isoCode: 'NZ',
      name: 'New Zealand',
      dialCode: '+64',
    ),
    const ZetaCountry(
      isoCode: 'NI',
      name: 'Nicaragua',
      dialCode: '+505',
    ),
    const ZetaCountry(
      isoCode: 'NE',
      name: 'Niger',
      dialCode: '+227',
    ),
    const ZetaCountry(
      isoCode: 'NG',
      name: 'Nigeria',
      dialCode: '+234',
    ),
    const ZetaCountry(
      isoCode: 'NU',
      name: 'Niue',
      dialCode: '+683',
    ),
    const ZetaCountry(
      isoCode: 'NF',
      name: 'Norfolk Island',
      dialCode: '+672',
    ),
    const ZetaCountry(
      isoCode: 'MP',
      name: 'Northern Mariana Islands',
      dialCode: '+1670',
    ),
    const ZetaCountry(
      isoCode: 'NO',
      name: 'Norway',
      dialCode: '+47',
    ),
    const ZetaCountry(
      isoCode: 'OM',
      name: 'Oman',
      dialCode: '+968',
    ),
    const ZetaCountry(
      isoCode: 'PK',
      name: 'Pakistan',
      dialCode: '+92',
    ),
    const ZetaCountry(
      isoCode: 'PW',
      name: 'Palau',
      dialCode: '+680',
    ),
    const ZetaCountry(
      isoCode: 'PS',
      name: 'Palestine, State of',
      dialCode: '+970',
    ),
    const ZetaCountry(
      isoCode: 'PA',
      name: 'Panama',
      dialCode: '+507',
    ),
    const ZetaCountry(
      isoCode: 'PG',
      name: 'Papua New Guinea',
      dialCode: '+675',
    ),
    const ZetaCountry(
      isoCode: 'PY',
      name: 'Paraguay',
      dialCode: '+595',
    ),
    const ZetaCountry(
      isoCode: 'PE',
      name: 'Peru',
      dialCode: '+51',
    ),
    const ZetaCountry(
      isoCode: 'PH',
      name: 'Philippines',
      dialCode: '+63',
    ),
    const ZetaCountry(
      isoCode: 'PN',
      name: 'Pitcairn',
      dialCode: '+64',
    ),
    const ZetaCountry(
      isoCode: 'PL',
      name: 'Poland',
      dialCode: '+48',
    ),
    const ZetaCountry(
      isoCode: 'PT',
      name: 'Portugal',
      dialCode: '+351',
    ),
    const ZetaCountry(
      isoCode: 'PR',
      name: 'Puerto Rico',
      dialCode: '+1939',
    ),
    const ZetaCountry(
      isoCode: 'QA',
      name: 'Qatar',
      dialCode: '+974',
    ),
    const ZetaCountry(
      isoCode: 'RE',
      name: 'Réunion',
      dialCode: '+262',
    ),
    const ZetaCountry(
      isoCode: 'RO',
      name: 'Romania',
      dialCode: '+40',
    ),
    const ZetaCountry(
      isoCode: 'RU',
      name: 'Russian Federation',
      dialCode: '+7',
    ),
    const ZetaCountry(
      isoCode: 'RW',
      name: 'Rwanda',
      dialCode: '+250',
    ),
    const ZetaCountry(
      isoCode: 'BL',
      name: 'Saint Barthélemy',
      dialCode: '+590',
    ),
    const ZetaCountry(
      isoCode: 'SH',
      name: 'Saint Helena, Ascension and Tristan da Cunha',
      dialCode: '+290',
    ),
    const ZetaCountry(
      isoCode: 'KN',
      name: 'Saint Kitts and Nevis',
      dialCode: '+1869',
    ),
    const ZetaCountry(
      isoCode: 'LC',
      name: 'Saint Lucia',
      dialCode: '+1758',
    ),
    const ZetaCountry(
      isoCode: 'MF',
      name: 'Saint Martin (French part)',
      dialCode: '+590',
    ),
    const ZetaCountry(
      isoCode: 'PM',
      name: 'Saint Pierre and Miquelon',
      dialCode: '+508',
    ),
    const ZetaCountry(
      isoCode: 'VC',
      name: 'Saint Vincent and the Grenadines',
      dialCode: '+1784',
    ),
    const ZetaCountry(
      isoCode: 'WS',
      name: 'Samoa',
      dialCode: '+685',
    ),
    const ZetaCountry(
      isoCode: 'SM',
      name: 'San Marino',
      dialCode: '+378',
    ),
    const ZetaCountry(
      isoCode: 'ST',
      name: 'Sao Tome and Principe',
      dialCode: '+239',
    ),
    const ZetaCountry(
      isoCode: 'SA',
      name: 'Saudi Arabia',
      dialCode: '+966',
    ),
    const ZetaCountry(
      isoCode: 'SN',
      name: 'Senegal',
      dialCode: '+221',
    ),
    const ZetaCountry(
      isoCode: 'RS',
      name: 'Serbia',
      dialCode: '+381',
    ),
    const ZetaCountry(
      isoCode: 'SC',
      name: 'Seychelles',
      dialCode: '+248',
    ),
    const ZetaCountry(
      isoCode: 'SL',
      name: 'Sierra Leone',
      dialCode: '+232',
    ),
    const ZetaCountry(
      isoCode: 'SG',
      name: 'Singapore',
      dialCode: '+65',
    ),
    const ZetaCountry(
      isoCode: 'SK',
      name: 'Slovakia',
      dialCode: '+421',
    ),
    const ZetaCountry(
      isoCode: 'SI',
      name: 'Slovenia',
      dialCode: '+386',
    ),
    const ZetaCountry(
      isoCode: 'SB',
      name: 'Solomon Islands',
      dialCode: '+677',
    ),
    const ZetaCountry(
      isoCode: 'SO',
      name: 'Somalia',
      dialCode: '+252',
    ),
    const ZetaCountry(
      isoCode: 'ZA',
      name: 'South Africa',
      dialCode: '+27',
    ),
    const ZetaCountry(
      isoCode: 'GS',
      name: 'South Georgia and the South Sandwich Islands',
      dialCode: '+500',
    ),
    const ZetaCountry(
      isoCode: 'SS',
      name: 'South Sudan',
      dialCode: '+211',
    ),
    const ZetaCountry(
      isoCode: 'ES',
      name: 'Spain',
      dialCode: '+34',
    ),
    const ZetaCountry(
      isoCode: 'LK',
      name: 'Sri Lanka',
      dialCode: '+94',
    ),
    const ZetaCountry(
      isoCode: 'SD',
      name: 'Sudan',
      dialCode: '+249',
    ),
    const ZetaCountry(
      isoCode: 'SR',
      name: 'Suriname',
      dialCode: '+597',
    ),
    const ZetaCountry(
      isoCode: 'SJ',
      name: 'Svalbard and Jan Mayen',
      dialCode: '+47',
    ),
    const ZetaCountry(
      isoCode: 'SZ',
      name: 'Swaziland',
      dialCode: '+268',
    ),
    const ZetaCountry(
      isoCode: 'SE',
      name: 'Sweden',
      dialCode: '+46',
    ),
    const ZetaCountry(
      isoCode: 'CH',
      name: 'Switzerland',
      dialCode: '+41',
    ),
    const ZetaCountry(
      isoCode: 'SY',
      name: 'Syrian Arab Republic',
      dialCode: '+963',
    ),
    const ZetaCountry(
      isoCode: 'TW',
      name: 'Taiwan',
      dialCode: '+886',
    ),
    const ZetaCountry(
      isoCode: 'TJ',
      name: 'Tajikistan',
      dialCode: '+992',
    ),
    const ZetaCountry(
      isoCode: 'TZ',
      name: 'Tanzania, United Republic of',
      dialCode: '+255',
    ),
    const ZetaCountry(
      isoCode: 'TH',
      name: 'Thailand',
      dialCode: '+66',
    ),
    const ZetaCountry(
      isoCode: 'TL',
      name: 'Timor-Leste',
      dialCode: '+670',
    ),
    const ZetaCountry(
      isoCode: 'TG',
      name: 'Togo',
      dialCode: '+228',
    ),
    const ZetaCountry(
      isoCode: 'TK',
      name: 'Tokelau',
      dialCode: '+690',
    ),
    const ZetaCountry(
      isoCode: 'TO',
      name: 'Tonga',
      dialCode: '+676',
    ),
    const ZetaCountry(
      isoCode: 'TT',
      name: 'Trinidad and Tobago',
      dialCode: '+1868',
    ),
    const ZetaCountry(
      isoCode: 'TN',
      name: 'Tunisia',
      dialCode: '+216',
    ),
    const ZetaCountry(
      isoCode: 'TR',
      name: 'Turkey',
      dialCode: '+90',
    ),
    const ZetaCountry(
      isoCode: 'TM',
      name: 'Turkmenistan',
      dialCode: '+993',
    ),
    const ZetaCountry(
      isoCode: 'TC',
      name: 'Turks and Caicos Islands',
      dialCode: '+1649',
    ),
    const ZetaCountry(
      isoCode: 'TV',
      name: 'Tuvalu',
      dialCode: '+688',
    ),
    const ZetaCountry(
      isoCode: 'UG',
      name: 'Uganda',
      dialCode: '+256',
    ),
    const ZetaCountry(
      isoCode: 'UA',
      name: 'Ukraine',
      dialCode: '+380',
    ),
    const ZetaCountry(
      isoCode: 'AE',
      name: 'United Arab Emirates',
      dialCode: '+971',
    ),
    const ZetaCountry(
      isoCode: 'GB',
      name: 'United Kingdom of Great Britain and Northern Ireland',
      dialCode: '+44',
    ),
    const ZetaCountry(
      isoCode: 'US',
      name: 'United States of America',
      dialCode: '+1',
    ),
    const ZetaCountry(
      isoCode: 'UY',
      name: 'Uruguay',
      dialCode: '+598',
    ),
    const ZetaCountry(
      isoCode: 'UZ',
      name: 'Uzbekistan',
      dialCode: '+998',
    ),
    const ZetaCountry(
      isoCode: 'VU',
      name: 'Vanuatu',
      dialCode: '+678',
    ),
    const ZetaCountry(
      isoCode: 'VE',
      name: 'Venezuela (Bolivarian Republic of)',
      dialCode: '+58',
    ),
    const ZetaCountry(
      isoCode: 'VN',
      name: 'Vietnam',
      dialCode: '+84',
    ),
    const ZetaCountry(
      isoCode: 'VG',
      name: 'Virgin Islands (British)',
      dialCode: '+1284',
    ),
    const ZetaCountry(
      isoCode: 'VI',
      name: 'Virgin Islands (U.S.)',
      dialCode: '+1340',
    ),
    const ZetaCountry(
      isoCode: 'WF',
      name: 'Wallis and Futuna',
      dialCode: '+681',
    ),
    const ZetaCountry(
      isoCode: 'YE',
      name: 'Yemen',
      dialCode: '+967',
    ),
    const ZetaCountry(
      isoCode: 'ZM',
      name: 'Zambia',
      dialCode: '+260',
    ),
    const ZetaCountry(
      isoCode: 'ZW',
      name: 'Zimbabwe',
      dialCode: '+263',
    ),
  ];
}

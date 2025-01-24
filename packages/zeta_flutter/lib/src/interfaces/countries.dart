/// Class definition for a country with its name, dial code, and ISO code.
class Country {
  /// Constructor for [Country]
  const Country({
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
class Countries {
  /// List of [Country] for most countries around the world.
  static List<Country> get list => _countriesList;
  static final List<Country> _countriesList = [
    const Country(
      isoCode: 'AF',
      name: 'Afghanistan',
      dialCode: '+93',
    ),
    const Country(
      isoCode: 'AX',
      name: 'Åland Islands',
      dialCode: '+358',
    ),
    const Country(
      isoCode: 'AL',
      name: 'Albania',
      dialCode: '+355',
    ),
    const Country(
      isoCode: 'DZ',
      name: 'Algeria',
      dialCode: '+213',
    ),
    const Country(
      isoCode: 'AS',
      name: 'American Samoa',
      dialCode: '+1684',
    ),
    const Country(
      isoCode: 'AD',
      name: 'Andorra',
      dialCode: '+376',
    ),
    const Country(
      isoCode: 'AO',
      name: 'Angola',
      dialCode: '+244',
    ),
    const Country(
      isoCode: 'AI',
      name: 'Anguilla',
      dialCode: '+1264',
    ),
    const Country(
      isoCode: 'AQ',
      name: 'Antarctica',
      dialCode: '+672',
    ),
    const Country(
      isoCode: 'AG',
      name: 'Antigua and Barbuda',
      dialCode: '+1268',
    ),
    const Country(
      isoCode: 'AR',
      name: 'Argentina',
      dialCode: '+54',
    ),
    const Country(
      isoCode: 'AM',
      name: 'Armenia',
      dialCode: '+374',
    ),
    const Country(
      isoCode: 'AW',
      name: 'Aruba',
      dialCode: '+297',
    ),
    const Country(
      isoCode: 'AU',
      name: 'Australia',
      dialCode: '+61',
    ),
    const Country(
      isoCode: 'AT',
      name: 'Austria',
      dialCode: '+43',
    ),
    const Country(
      isoCode: 'AZ',
      name: 'Azerbaijan',
      dialCode: '+994',
    ),
    const Country(
      isoCode: 'BS',
      name: 'Bahamas',
      dialCode: '+1242',
    ),
    const Country(
      isoCode: 'BH',
      name: 'Bahrain',
      dialCode: '+973',
    ),
    const Country(
      isoCode: 'BD',
      name: 'Bangladesh',
      dialCode: '+880',
    ),
    const Country(
      isoCode: 'BB',
      name: 'Barbados',
      dialCode: '+1246',
    ),
    const Country(
      isoCode: 'BY',
      name: 'Belarus',
      dialCode: '+375',
    ),
    const Country(
      isoCode: 'BE',
      name: 'Belgium',
      dialCode: '+32',
    ),
    const Country(
      isoCode: 'BZ',
      name: 'Belize',
      dialCode: '+501',
    ),
    const Country(
      isoCode: 'BJ',
      name: 'Benin',
      dialCode: '+229',
    ),
    const Country(
      isoCode: 'BM',
      name: 'Bermuda',
      dialCode: '+1441',
    ),
    const Country(
      isoCode: 'BT',
      name: 'Bhutan',
      dialCode: '+975',
    ),
    const Country(
      isoCode: 'BO',
      name: 'Bolivia (Plurinational State of)',
      dialCode: '+591',
    ),
    const Country(
      isoCode: 'BA',
      name: 'Bosnia and Herzegovina',
      dialCode: '+387',
    ),
    const Country(
      isoCode: 'BW',
      name: 'Botswana',
      dialCode: '+267',
    ),
    const Country(
      isoCode: 'BV',
      name: 'Bouvet Island',
      dialCode: '+47',
    ),
    const Country(
      isoCode: 'BR',
      name: 'Brazil',
      dialCode: '+55',
    ),
    const Country(
      isoCode: 'IO',
      name: 'British Indian Ocean Territory',
      dialCode: '+246',
    ),
    const Country(
      isoCode: 'BN',
      name: 'Brunei Darussalam',
      dialCode: '+673',
    ),
    const Country(
      isoCode: 'BG',
      name: 'Bulgaria',
      dialCode: '+359',
    ),
    const Country(
      isoCode: 'BF',
      name: 'Burkina Faso',
      dialCode: '+226',
    ),
    const Country(
      isoCode: 'BI',
      name: 'Burundi',
      dialCode: '+257',
    ),
    const Country(
      isoCode: 'CV',
      name: 'Cabo Verde',
      dialCode: '+238',
    ),
    const Country(
      isoCode: 'KH',
      name: 'Cambodia',
      dialCode: '+855',
    ),
    const Country(
      isoCode: 'CM',
      name: 'Cameroon',
      dialCode: '+237',
    ),
    const Country(
      isoCode: 'CA',
      name: 'Canada',
      dialCode: '+1',
    ),
    const Country(
      isoCode: 'KY',
      name: 'Cayman Islands',
      dialCode: '+1345',
    ),
    const Country(
      isoCode: 'CF',
      name: 'Central African Republic',
      dialCode: '+236',
    ),
    const Country(
      isoCode: 'TD',
      name: 'Chad',
      dialCode: '+235',
    ),
    const Country(
      isoCode: 'CL',
      name: 'Chile',
      dialCode: '+56',
    ),
    const Country(
      isoCode: 'CN',
      name: 'China',
      dialCode: '+86',
    ),
    const Country(
      isoCode: 'CX',
      name: 'Christmas Island',
      dialCode: '+61',
    ),
    const Country(
      isoCode: 'CC',
      name: 'Cocos (Keeling) Islands',
      dialCode: '+61',
    ),
    const Country(
      isoCode: 'CO',
      name: 'Colombia',
      dialCode: '+57',
    ),
    const Country(
      isoCode: 'KM',
      name: 'Comoros',
      dialCode: '+269',
    ),
    const Country(
      isoCode: 'CG',
      name: 'Congo (Republic of the)',
      dialCode: '+242',
    ),
    const Country(
      isoCode: 'CD',
      name: 'Congo (Democratic Republic of the)',
      dialCode: '+243',
    ),
    const Country(
      isoCode: 'CK',
      name: 'Cook Islands',
      dialCode: '+682',
    ),
    const Country(
      isoCode: 'CR',
      name: 'Costa Rica',
      dialCode: '+506',
    ),
    const Country(
      isoCode: 'CI',
      name: 'Côte d`Ivoire',
      dialCode: '+225',
    ),
    const Country(
      isoCode: 'HR',
      name: 'Croatia',
      dialCode: '+385',
    ),
    const Country(
      isoCode: 'CU',
      name: 'Cuba',
      dialCode: '+53',
    ),
    const Country(
      isoCode: 'CY',
      name: 'Cyprus',
      dialCode: '+357',
    ),
    const Country(
      isoCode: 'CZ',
      name: 'Czech Republic',
      dialCode: '+420',
    ),
    const Country(
      isoCode: 'DK',
      name: 'Denmark',
      dialCode: '+45',
    ),
    const Country(
      isoCode: 'DJ',
      name: 'Djibouti',
      dialCode: '+253',
    ),
    const Country(
      isoCode: 'DM',
      name: 'Dominica',
      dialCode: '+1767',
    ),
    const Country(
      isoCode: 'DO',
      name: 'Dominican Republic',
      dialCode: '+1',
    ),
    const Country(
      isoCode: 'EC',
      name: 'Ecuador',
      dialCode: '+593',
    ),
    const Country(
      isoCode: 'EG',
      name: 'Egypt',
      dialCode: '+20',
    ),
    const Country(
      isoCode: 'SV',
      name: 'El Salvador',
      dialCode: '+503',
    ),
    const Country(
      isoCode: 'GQ',
      name: 'Equatorial Guinea',
      dialCode: '+240',
    ),
    const Country(
      isoCode: 'ER',
      name: 'Eritrea',
      dialCode: '+291',
    ),
    const Country(
      isoCode: 'EE',
      name: 'Estonia',
      dialCode: '+372',
    ),
    const Country(
      isoCode: 'ET',
      name: 'Ethiopia',
      dialCode: '+251',
    ),
    const Country(
      isoCode: 'FK',
      name: 'Falkland Islands (Malvinas)',
      dialCode: '+500',
    ),
    const Country(
      isoCode: 'FO',
      name: 'Faroe Islands',
      dialCode: '+298',
    ),
    const Country(
      isoCode: 'FJ',
      name: 'Fiji',
      dialCode: '+679',
    ),
    const Country(
      isoCode: 'FI',
      name: 'Finland',
      dialCode: '+358',
    ),
    const Country(
      isoCode: 'FR',
      name: 'France',
      dialCode: '+33',
    ),
    const Country(
      isoCode: 'GF',
      name: 'French Guiana',
      dialCode: '+594',
    ),
    const Country(
      isoCode: 'PF',
      name: 'French Polynesia',
      dialCode: '+689',
    ),
    const Country(
      isoCode: 'TF',
      name: 'French Southern Territories',
      dialCode: '+262',
    ),
    const Country(
      isoCode: 'GA',
      name: 'Gabon',
      dialCode: '+241',
    ),
    const Country(
      isoCode: 'GM',
      name: 'Gambia',
      dialCode: '+220',
    ),
    const Country(
      isoCode: 'GE',
      name: 'Georgia',
      dialCode: '+995',
    ),
    const Country(
      isoCode: 'DE',
      name: 'Germany',
      dialCode: '+49',
    ),
    const Country(
      isoCode: 'GH',
      name: 'Ghana',
      dialCode: '+233',
    ),
    const Country(
      isoCode: 'GI',
      name: 'Gibraltar',
      dialCode: '+350',
    ),
    const Country(
      isoCode: 'GR',
      name: 'Greece',
      dialCode: '+30',
    ),
    const Country(
      isoCode: 'GL',
      name: 'Greenland',
      dialCode: '+299',
    ),
    const Country(
      isoCode: 'GD',
      name: 'Grenada',
      dialCode: '+1473',
    ),
    const Country(
      isoCode: 'GP',
      name: 'Guadeloupe',
      dialCode: '+590',
    ),
    const Country(
      isoCode: 'GU',
      name: 'Guam',
      dialCode: '+1671',
    ),
    const Country(
      isoCode: 'GT',
      name: 'Guatemala',
      dialCode: '+502',
    ),
    const Country(
      isoCode: 'GG',
      name: 'Guernsey',
      dialCode: '+44',
    ),
    const Country(
      isoCode: 'GN',
      name: 'Guinea',
      dialCode: '+224',
    ),
    const Country(
      isoCode: 'GW',
      name: 'Guinea-Bissau',
      dialCode: '+245',
    ),
    const Country(
      isoCode: 'GY',
      name: 'Guyana',
      dialCode: '+592',
    ),
    const Country(
      isoCode: 'HT',
      name: 'Haiti',
      dialCode: '+509',
    ),
    const Country(
      isoCode: 'HM',
      name: 'Heard Island and McDonald Islands',
      dialCode: '+0',
    ),
    const Country(
      isoCode: 'VA',
      name: 'Vatican City State',
      dialCode: '+379',
    ),
    const Country(
      isoCode: 'HN',
      name: 'Honduras',
      dialCode: '+504',
    ),
    const Country(
      isoCode: 'HK',
      name: 'Hong Kong',
      dialCode: '+852',
    ),
    const Country(
      isoCode: 'HU',
      name: 'Hungary',
      dialCode: '+36',
    ),
    const Country(
      isoCode: 'IS',
      name: 'Iceland',
      dialCode: '+354',
    ),
    const Country(
      isoCode: 'IN',
      name: 'India',
      dialCode: '+91',
    ),
    const Country(
      isoCode: 'ID',
      name: 'Indonesia',
      dialCode: '+62',
    ),
    const Country(
      isoCode: 'IR',
      name: 'Iran',
      dialCode: '+98',
    ),
    const Country(
      isoCode: 'IQ',
      name: 'Iraq',
      dialCode: '+964',
    ),
    const Country(
      isoCode: 'IE',
      name: 'Ireland',
      dialCode: '+353',
    ),
    const Country(
      isoCode: 'IM',
      name: 'Isle of Man',
      dialCode: '+44',
    ),
    const Country(
      isoCode: 'IL',
      name: 'Israel',
      dialCode: '+972',
    ),
    const Country(
      isoCode: 'IT',
      name: 'Italy',
      dialCode: '+39',
    ),
    const Country(
      isoCode: 'JM',
      name: 'Jamaica',
      dialCode: '+1876',
    ),
    const Country(
      isoCode: 'JP',
      name: 'Japan',
      dialCode: '+81',
    ),
    const Country(
      isoCode: 'JE',
      name: 'Jersey',
      dialCode: '+44',
    ),
    const Country(
      isoCode: 'JO',
      name: 'Jordan',
      dialCode: '+962',
    ),
    const Country(
      isoCode: 'KZ',
      name: 'Kazakhstan',
      dialCode: '+7',
    ),
    const Country(
      isoCode: 'KE',
      name: 'Kenya',
      dialCode: '+254',
    ),
    const Country(
      isoCode: 'KI',
      name: 'Kiribati',
      dialCode: '+686',
    ),
    const Country(
      isoCode: 'XK',
      name: 'Kosovo (Republic of)',
      dialCode: '+383',
    ),
    const Country(
      isoCode: 'KP',
      name: 'Korea (Democratic People`s Republic of)',
      dialCode: '+850',
    ),
    const Country(
      isoCode: 'KR',
      name: 'Korea (Republic of)',
      dialCode: '+82',
    ),
    const Country(
      isoCode: 'KW',
      name: 'Kuwait',
      dialCode: '+965',
    ),
    const Country(
      isoCode: 'KG',
      name: 'Kyrgyzstan',
      dialCode: '+996',
    ),
    const Country(
      isoCode: 'LA',
      name: 'Lao People`s Democratic Republic',
      dialCode: '+856',
    ),
    const Country(
      isoCode: 'LV',
      name: 'Latvia',
      dialCode: '+371',
    ),
    const Country(
      isoCode: 'LB',
      name: 'Lebanon',
      dialCode: '+961',
    ),
    const Country(
      isoCode: 'LS',
      name: 'Lesotho',
      dialCode: '+266',
    ),
    const Country(
      isoCode: 'LR',
      name: 'Liberia',
      dialCode: '+231',
    ),
    const Country(
      isoCode: 'LY',
      name: 'Libya',
      dialCode: '+218',
    ),
    const Country(
      isoCode: 'LI',
      name: 'Liechtenstein',
      dialCode: '+423',
    ),
    const Country(
      isoCode: 'LT',
      name: 'Lithuania',
      dialCode: '+370',
    ),
    const Country(
      isoCode: 'LU',
      name: 'Luxembourg',
      dialCode: '+352',
    ),
    const Country(
      isoCode: 'MO',
      name: 'Macao',
      dialCode: '+853',
    ),
    const Country(
      isoCode: 'MK',
      name: 'Macedonia (the former Yugoslav Republic of)',
      dialCode: '+389',
    ),
    const Country(
      isoCode: 'MG',
      name: 'Madagascar',
      dialCode: '+261',
    ),
    const Country(
      isoCode: 'MW',
      name: 'Malawi',
      dialCode: '+265',
    ),
    const Country(
      isoCode: 'MY',
      name: 'Malaysia',
      dialCode: '+60',
    ),
    const Country(
      isoCode: 'MV',
      name: 'Maldives',
      dialCode: '+960',
    ),
    const Country(
      isoCode: 'ML',
      name: 'Mali',
      dialCode: '+223',
    ),
    const Country(
      isoCode: 'MT',
      name: 'Malta',
      dialCode: '+356',
    ),
    const Country(
      isoCode: 'MH',
      name: 'Marshall Islands',
      dialCode: '+692',
    ),
    const Country(
      isoCode: 'MQ',
      name: 'Martinique',
      dialCode: '+596',
    ),
    const Country(
      isoCode: 'MR',
      name: 'Mauritania',
      dialCode: '+222',
    ),
    const Country(
      isoCode: 'MU',
      name: 'Mauritius',
      dialCode: '+230',
    ),
    const Country(
      isoCode: 'YT',
      name: 'Mayotte',
      dialCode: '+262',
    ),
    const Country(
      isoCode: 'MX',
      name: 'Mexico',
      dialCode: '+52',
    ),
    const Country(
      isoCode: 'FM',
      name: 'Micronesia (Federated States of)',
      dialCode: '+691',
    ),
    const Country(
      isoCode: 'MD',
      name: 'Moldova (Republic of)',
      dialCode: '+373',
    ),
    const Country(
      isoCode: 'MC',
      name: 'Monaco',
      dialCode: '+377',
    ),
    const Country(
      isoCode: 'MN',
      name: 'Mongolia',
      dialCode: '+976',
    ),
    const Country(
      isoCode: 'ME',
      name: 'Montenegro',
      dialCode: '+382',
    ),
    const Country(
      isoCode: 'MS',
      name: 'Montserrat',
      dialCode: '+1664',
    ),
    const Country(
      isoCode: 'MA',
      name: 'Morocco',
      dialCode: '+212',
    ),
    const Country(
      isoCode: 'MZ',
      name: 'Mozambique',
      dialCode: '+258',
    ),
    const Country(
      isoCode: 'MM',
      name: 'Myanmar',
      dialCode: '+95',
    ),
    const Country(
      isoCode: 'NA',
      name: 'Namibia',
      dialCode: '+264',
    ),
    const Country(
      isoCode: 'NR',
      name: 'Nauru',
      dialCode: '+674',
    ),
    const Country(
      isoCode: 'NP',
      name: 'Nepal',
      dialCode: '+977',
    ),
    const Country(
      isoCode: 'NL',
      name: 'Netherlands',
      dialCode: '+31',
    ),
    const Country(
      isoCode: 'NC',
      name: 'New Caledonia',
      dialCode: '+687',
    ),
    const Country(
      isoCode: 'NZ',
      name: 'New Zealand',
      dialCode: '+64',
    ),
    const Country(
      isoCode: 'NI',
      name: 'Nicaragua',
      dialCode: '+505',
    ),
    const Country(
      isoCode: 'NE',
      name: 'Niger',
      dialCode: '+227',
    ),
    const Country(
      isoCode: 'NG',
      name: 'Nigeria',
      dialCode: '+234',
    ),
    const Country(
      isoCode: 'NU',
      name: 'Niue',
      dialCode: '+683',
    ),
    const Country(
      isoCode: 'NF',
      name: 'Norfolk Island',
      dialCode: '+672',
    ),
    const Country(
      isoCode: 'MP',
      name: 'Northern Mariana Islands',
      dialCode: '+1670',
    ),
    const Country(
      isoCode: 'NO',
      name: 'Norway',
      dialCode: '+47',
    ),
    const Country(
      isoCode: 'OM',
      name: 'Oman',
      dialCode: '+968',
    ),
    const Country(
      isoCode: 'PK',
      name: 'Pakistan',
      dialCode: '+92',
    ),
    const Country(
      isoCode: 'PW',
      name: 'Palau',
      dialCode: '+680',
    ),
    const Country(
      isoCode: 'PS',
      name: 'Palestine, State of',
      dialCode: '+970',
    ),
    const Country(
      isoCode: 'PA',
      name: 'Panama',
      dialCode: '+507',
    ),
    const Country(
      isoCode: 'PG',
      name: 'Papua New Guinea',
      dialCode: '+675',
    ),
    const Country(
      isoCode: 'PY',
      name: 'Paraguay',
      dialCode: '+595',
    ),
    const Country(
      isoCode: 'PE',
      name: 'Peru',
      dialCode: '+51',
    ),
    const Country(
      isoCode: 'PH',
      name: 'Philippines',
      dialCode: '+63',
    ),
    const Country(
      isoCode: 'PN',
      name: 'Pitcairn',
      dialCode: '+64',
    ),
    const Country(
      isoCode: 'PL',
      name: 'Poland',
      dialCode: '+48',
    ),
    const Country(
      isoCode: 'PT',
      name: 'Portugal',
      dialCode: '+351',
    ),
    const Country(
      isoCode: 'PR',
      name: 'Puerto Rico',
      dialCode: '+1939',
    ),
    const Country(
      isoCode: 'QA',
      name: 'Qatar',
      dialCode: '+974',
    ),
    const Country(
      isoCode: 'RE',
      name: 'Réunion',
      dialCode: '+262',
    ),
    const Country(
      isoCode: 'RO',
      name: 'Romania',
      dialCode: '+40',
    ),
    const Country(
      isoCode: 'RU',
      name: 'Russian Federation',
      dialCode: '+7',
    ),
    const Country(
      isoCode: 'RW',
      name: 'Rwanda',
      dialCode: '+250',
    ),
    const Country(
      isoCode: 'BL',
      name: 'Saint Barthélemy',
      dialCode: '+590',
    ),
    const Country(
      isoCode: 'SH',
      name: 'Saint Helena, Ascension and Tristan da Cunha',
      dialCode: '+290',
    ),
    const Country(
      isoCode: 'KN',
      name: 'Saint Kitts and Nevis',
      dialCode: '+1869',
    ),
    const Country(
      isoCode: 'LC',
      name: 'Saint Lucia',
      dialCode: '+1758',
    ),
    const Country(
      isoCode: 'MF',
      name: 'Saint Martin (French part)',
      dialCode: '+590',
    ),
    const Country(
      isoCode: 'PM',
      name: 'Saint Pierre and Miquelon',
      dialCode: '+508',
    ),
    const Country(
      isoCode: 'VC',
      name: 'Saint Vincent and the Grenadines',
      dialCode: '+1784',
    ),
    const Country(
      isoCode: 'WS',
      name: 'Samoa',
      dialCode: '+685',
    ),
    const Country(
      isoCode: 'SM',
      name: 'San Marino',
      dialCode: '+378',
    ),
    const Country(
      isoCode: 'ST',
      name: 'Sao Tome and Principe',
      dialCode: '+239',
    ),
    const Country(
      isoCode: 'SA',
      name: 'Saudi Arabia',
      dialCode: '+966',
    ),
    const Country(
      isoCode: 'SN',
      name: 'Senegal',
      dialCode: '+221',
    ),
    const Country(
      isoCode: 'RS',
      name: 'Serbia',
      dialCode: '+381',
    ),
    const Country(
      isoCode: 'SC',
      name: 'Seychelles',
      dialCode: '+248',
    ),
    const Country(
      isoCode: 'SL',
      name: 'Sierra Leone',
      dialCode: '+232',
    ),
    const Country(
      isoCode: 'SG',
      name: 'Singapore',
      dialCode: '+65',
    ),
    const Country(
      isoCode: 'SK',
      name: 'Slovakia',
      dialCode: '+421',
    ),
    const Country(
      isoCode: 'SI',
      name: 'Slovenia',
      dialCode: '+386',
    ),
    const Country(
      isoCode: 'SB',
      name: 'Solomon Islands',
      dialCode: '+677',
    ),
    const Country(
      isoCode: 'SO',
      name: 'Somalia',
      dialCode: '+252',
    ),
    const Country(
      isoCode: 'ZA',
      name: 'South Africa',
      dialCode: '+27',
    ),
    const Country(
      isoCode: 'GS',
      name: 'South Georgia and the South Sandwich Islands',
      dialCode: '+500',
    ),
    const Country(
      isoCode: 'SS',
      name: 'South Sudan',
      dialCode: '+211',
    ),
    const Country(
      isoCode: 'ES',
      name: 'Spain',
      dialCode: '+34',
    ),
    const Country(
      isoCode: 'LK',
      name: 'Sri Lanka',
      dialCode: '+94',
    ),
    const Country(
      isoCode: 'SD',
      name: 'Sudan',
      dialCode: '+249',
    ),
    const Country(
      isoCode: 'SR',
      name: 'Suriname',
      dialCode: '+597',
    ),
    const Country(
      isoCode: 'SJ',
      name: 'Svalbard and Jan Mayen',
      dialCode: '+47',
    ),
    const Country(
      isoCode: 'SZ',
      name: 'Swaziland',
      dialCode: '+268',
    ),
    const Country(
      isoCode: 'SE',
      name: 'Sweden',
      dialCode: '+46',
    ),
    const Country(
      isoCode: 'CH',
      name: 'Switzerland',
      dialCode: '+41',
    ),
    const Country(
      isoCode: 'SY',
      name: 'Syrian Arab Republic',
      dialCode: '+963',
    ),
    const Country(
      isoCode: 'TW',
      name: 'Taiwan',
      dialCode: '+886',
    ),
    const Country(
      isoCode: 'TJ',
      name: 'Tajikistan',
      dialCode: '+992',
    ),
    const Country(
      isoCode: 'TZ',
      name: 'Tanzania, United Republic of',
      dialCode: '+255',
    ),
    const Country(
      isoCode: 'TH',
      name: 'Thailand',
      dialCode: '+66',
    ),
    const Country(
      isoCode: 'TL',
      name: 'Timor-Leste',
      dialCode: '+670',
    ),
    const Country(
      isoCode: 'TG',
      name: 'Togo',
      dialCode: '+228',
    ),
    const Country(
      isoCode: 'TK',
      name: 'Tokelau',
      dialCode: '+690',
    ),
    const Country(
      isoCode: 'TO',
      name: 'Tonga',
      dialCode: '+676',
    ),
    const Country(
      isoCode: 'TT',
      name: 'Trinidad and Tobago',
      dialCode: '+1868',
    ),
    const Country(
      isoCode: 'TN',
      name: 'Tunisia',
      dialCode: '+216',
    ),
    const Country(
      isoCode: 'TR',
      name: 'Turkey',
      dialCode: '+90',
    ),
    const Country(
      isoCode: 'TM',
      name: 'Turkmenistan',
      dialCode: '+993',
    ),
    const Country(
      isoCode: 'TC',
      name: 'Turks and Caicos Islands',
      dialCode: '+1649',
    ),
    const Country(
      isoCode: 'TV',
      name: 'Tuvalu',
      dialCode: '+688',
    ),
    const Country(
      isoCode: 'UG',
      name: 'Uganda',
      dialCode: '+256',
    ),
    const Country(
      isoCode: 'UA',
      name: 'Ukraine',
      dialCode: '+380',
    ),
    const Country(
      isoCode: 'AE',
      name: 'United Arab Emirates',
      dialCode: '+971',
    ),
    const Country(
      isoCode: 'GB',
      name: 'United Kingdom of Great Britain and Northern Ireland',
      dialCode: '+44',
    ),
    const Country(
      isoCode: 'US',
      name: 'United States of America',
      dialCode: '+1',
    ),
    const Country(
      isoCode: 'UY',
      name: 'Uruguay',
      dialCode: '+598',
    ),
    const Country(
      isoCode: 'UZ',
      name: 'Uzbekistan',
      dialCode: '+998',
    ),
    const Country(
      isoCode: 'VU',
      name: 'Vanuatu',
      dialCode: '+678',
    ),
    const Country(
      isoCode: 'VE',
      name: 'Venezuela (Bolivarian Republic of)',
      dialCode: '+58',
    ),
    const Country(
      isoCode: 'VN',
      name: 'Vietnam',
      dialCode: '+84',
    ),
    const Country(
      isoCode: 'VG',
      name: 'Virgin Islands (British)',
      dialCode: '+1284',
    ),
    const Country(
      isoCode: 'VI',
      name: 'Virgin Islands (U.S.)',
      dialCode: '+1340',
    ),
    const Country(
      isoCode: 'WF',
      name: 'Wallis and Futuna',
      dialCode: '+681',
    ),
    const Country(
      isoCode: 'YE',
      name: 'Yemen',
      dialCode: '+967',
    ),
    const Country(
      isoCode: 'ZM',
      name: 'Zambia',
      dialCode: '+260',
    ),
    const Country(
      isoCode: 'ZW',
      name: 'Zimbabwe',
      dialCode: '+263',
    ),
  ];
}

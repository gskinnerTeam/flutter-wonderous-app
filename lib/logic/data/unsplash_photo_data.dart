import 'package:wonders/_tools/unsplash_download_service.dart';
import 'package:wonders/logic/common/platform_info.dart';

enum UnsplashPhotoSize { med, large, xl }

class UnsplashPhotoData {
  UnsplashPhotoData({
    required this.id,
    required this.url,
  });
  final String id;
  final String url;

  String getUnsplashUrl(int size) => '$url?q=90&fm=jpg&w=$size&fit=max';

  static String getSelfHostedUrl(String id, UnsplashPhotoSize targetSize) {
    late int size;
    switch (targetSize) {
      case UnsplashPhotoSize.med:
        size = 400;
        break;
      case UnsplashPhotoSize.large:
        size = 800;
        break;
      case UnsplashPhotoSize.xl:
        size = 1200;
        break;
    }
    if (PlatformInfo.pixelRatio >= 1.5 || PlatformInfo.isDesktop) {
      size *= 2;
    }
    return 'https://www.wonderous.info/unsplash/$id-$size.jpg';
  }

  /// List of image ids by collection. This can be generated with the [UnsplashDownloadService].generateUnsplashCollectionsClass().
  static final photosByCollectionId = {
    'SUK0tuMnLLw': [
      'T-A0pEYn_0w',
      'wO3o3ibEfxw',
      '5GSXOxJiF70',
      'SHTEX8-4knw',
      'zhmpjgrYM4U',
      'qT2toWR8x2M',
      '3u1UUdUW0dM',
      'ZTuNK61OFjE',
      'SAC9IP2L4ww',
      'YuRSdBq2Pks',
      '7g4afdiVhF8',
      '3XMsTfVnesg',
      'CdCeLu7Zi_U',
      '_sSK8shpE_0',
      'J0tUqWIIrYY',
      'gBPNJ-dq9C8',
      'VPavA7BBxK0',
      'UfK0P6WygEE',
      '8L7mOETNgHA',
      'zYix52PYbXk',
      '_iklK8oQKPs',
      'Yt0GMo9DcTg',
      '9h9bzwTzZHc',
      'MeBRK0Ypo9M'
    ],
    '684IRta86_c': [
      'gwraJHxsMd0',
      '8tMxz9MRJHc',
      'ywdQtrOmjmg',
      'XtZNcroGK3E',
      'TgfdQeODkVY',
      'B3-lUYDbyDo',
      'sAB4BWrQ4Y4',
      'cKICrMrWHqk',
      '_0Niuvr92LU',
      'SHDG46hSVfg',
      '28s5r-zA6Lw',
      'ZpN1lhola0s',
      'BpSLyvZIW2E',
      'Hqk4zmLXUuw',
      'E2NtGFv9lX0',
      'IosnvXR94qI',
      'w-oUzSufu8A',
      'FddqGrvwoyE',
      'Axl4311WzQU',
      'BCEexmxL9EQ',
      'mwV6PsB-7Bk',
      'VmVk172z034',
      '0pG9XKXCj4s',
      'eU4pipU_8HA'
    ],
    'dPgX5iK8Ufo': [
      '0jcM54HBO4c',
      'fcaeEfnh818',
      'bQFxKVLV6SY',
      'eTIG213bO4U',
      '8yYYyxdcyrY',
      'zeH77USuASc',
      'okvoZRLXOsw',
      '21AiwkRfAnY',
      '-e0u9SAFeP4',
      'BVj6AnXs3TA',
      'd2kxugivOJo',
      'RSvKa3Jg3Z8',
      'cG2JQnPfmAw',
      'o-bc8wuY29c',
      'xec7srO4U5c',
      '4nJOD8wtMS4',
      'JoJuM-n20zo',
      'CErddu-JwKw',
      'GTLJklnjn-E',
      'DSm50vbc9F0',
      'ka-HD2cZYec',
      '8tTh9isJoos',
      'OkiDIla7K8Q',
      'xaIEq6owYvM'
    ],
    'VPdti8Kjq9o': [
      'rhRk8J33Bcc',
      'INA89gCRuNo',
      'K-TOsIh8FxE',
      'grlIoctRp1o',
      'mCLvY_GsdW8',
      'GHA2X73SRL8',
      'BLGigyFXbPo',
      'j-1UlgFdpx8',
      'iIINwmkBizU',
      'PWdWPYF0_RY',
      'kdlTfNzJBx0',
      'LUdSrJw-BII',
      '3mzn2xpA2YA',
      'nAb-SFzL1GM',
      's87bBFZviAU',
      'sKYsYzEG2Lg',
      '3b4e9D731ME',
      'haLyuhP6oLE',
      'lUO-BjCiZEA',
      'TWOrGJ5REuY',
      'VFRTXGw1VjU',
      'ckotRXopwRM',
      'CzKI2-nejUk',
      'Q4g0Q-eVVEg'
    ],
    'Kg_h04xvZEo': [
      'eq4OpDuGN7w',
      'cSKa2PDcU-Q',
      'MLfwSItwSpg',
      '1xnuIi-zcTQ',
      '20Nfb3kTnsY',
      'Wbu_scb-9HQ',
      '0FMRVVrMCyc',
      'Q36BvLGdOAg',
      'RyGG5z6SUZ8',
      'ZQxxar2ovS0',
      'siy5LCp84AY',
      'chc2vP_7_kY',
      'i56swU7BDbQ',
      '6aZBfbzx5Ms',
      'VW8YW3Xlc0k',
      'MZayf0ZVY-A',
      'fDxfe1_5VyY',
      'E13mcj-2TLE',
      'sGPfjjAOX1o',
      'd0VxLuvjUJA',
      'lzwT4n05p20',
      'OXL47qN9brQ',
      'vhKZvNFmpPU',
      '2s1chnvuMQ4'
    ],
    'wUhgZTyUnl8': [
      'UiUtIG0xLPM',
      'qytSCIVTTc4',
      'Ewm_GNF15E4',
      'Tzooq3pm5P8',
      'laNV6F7Sk3M',
      'kNbq1SHfLd8',
      'aqWoohHDRYw',
      'bLxbRF-CFrU',
      'WMkuiKU6uBM',
      'yam1KMv0SgQ',
      'VddWWTaTnpQ',
      'oDZyswNe6jg',
      'Tpo2Fq8BtCk',
      'e83VIgq_hgI',
      'Q_OTD6Hs56c',
      'EKNe678ktEY',
      't1HTTqB2TtE',
      'bPfIUoXX_X4',
      '3NWi-SGUjHA',
      'oKvTO3WdxKY',
      'PO7CGnoDFUI',
      '7bBaW4UPk7A',
      'iyYMqhLwDQE',
      'BtYpDZNIeFc'
    ],
    'qWQJbDvCMW8': [
      'I4PEltFE6v8',
      '5JHj33-s604',
      'gKn3GCu55W4',
      '1MglIsDOypY',
      'pvOzKAmMtaU',
      'EfWHX2plrww',
      'cXnisQvxpbU',
      'z5cCf20gOE8',
      'AVgjb2KpWr4',
      'ucGxk8JLmWw',
      '_-X-y-NaQNs',
      'eVD08ZVuJmY',
      'QNJdCsluIoI',
      'irUJJCORE1c',
      'FgYSaefAUTs',
      'OdDzYng7lTI',
      'Un067U25aOc',
      'iYPIx7VIh5g',
      'Ivwyqtw3PzU',
      'c8F1hJ_UTrk',
      'Pm1hCH1X2r0',
      'sYMgkKkHpGI',
      '5_Bu25SV6X8',
      'py8omnp-hko'
    ],
    'CSEvB5Tza9E': [
      '-tnS9O1ubn8',
      'CxXpMYIk_64',
      'IBILLYRAW1o',
      'tjjrLV2x0-I',
      'YWbQKxSwMtE',
      'QxPNDh0_5EQ',
      'bylApKzvY3g',
      'oCkZ6WicY8Q',
      'H3ugdzHeh2I',
      'Mkh6SOuL-Z0',
      'TY7b_S4mLwk',
      'MmoaflYGwuI',
      '27a_s3DdbVc',
      'Y4QPolVdgx8',
      'J0Z37Hx5f-I',
      'f3hx6y0NzrQ',
      'IYKL2uhgsnU',
      'M66ux8WJ-9M',
      'FXXuJ9S-KkQ',
      'zRacUCRY_Sw',
      'boyXZfqpwpU',
      'rxv2qwYPe6s',
      'zpAwgjaI3lI',
      'MoonoldXeqs'
    ]
  };
}

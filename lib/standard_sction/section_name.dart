class section_name {
  List<String> ipe_section,
      ipn_section,
      halfipe_section,
      ipea_section,
      ipev_section,
      ipeo_section,
      halfipeo_section,
      halfipev_section,
      heaa_section,
      hd_section,
      halfHEA_section,
      halfHEB_section;
  List<String> halfHEM_section,
      hl_section,
      hlz_section,
      HEA_section,
      HEB_section,
      HEM_section,
      UPn_section,
      UPe_section,
      t_section,
      z_section,
      glL_section,
      unglL_section,
      Circle_section,
      Wsquare_section,
      Wrec_section,
      Ksquare_section,
      Krec_section;

  section_name() {
    String HEA = 'HEA';
    String IPN = 'IPN';
    String HEB = 'HEB';
    String HEM = 'HEM';
    String half_HEA = '1/2 HEA';
    String half_HEB = '1/2 HEB';
    String half_HEM = '1/2 HEM';
    String Hl = 'HL';
    String HLZ = 'HLZ';
    String UPN = 'UPN';
    String UPE = 'UPE';
    String T = 'T';
    String z = 'Z';
    String L = 'L';
    String Lenght = 'Lenght';
    String circle = 'HKQ';
    String WholoSquare = 'WHqQ';
    String KholoSquare = 'KHqQ';
    String Wrec = 'WHrQ';
    String Krec = 'KHrQ';

    List<String> ipn_section_names = [
      '80',
      '100',
      '120',
      '140',
      '160',
      '180',
      '200',
      '220',
      '240',
      '260',
      '280',
      '300',
      '320',
      '340',
      '360',
      '380',
      '400',
      '450',
      '500',
      '550',
      '600',
    ];
    List<String> ipea_section_names = [
      'IPEa_120',
      'IPEa_140',
      'IPEa_160',
      'IPEa_180',
      'IPEa_200',
      'IPEa_220',
      'IPEa_240',
      'IPEa_270',
      'IPEa_300',
      'IPEa_330',
      'IPEa_360',
      'IPEa_400',
      'IPEa_450',
      'IPEa_500',
      'IPEa_550',
      'IPEa_600',
    ];
    List<String> ipe_section_names = [
      'IPE_80',
      'IPE_100',
      'IPE_120',
      'IPE_140',
      'IPE_160',
      'IPE_180',
      'IPE_200',
      'IPE_220',
      'IPE_240',
      'IPE_270',
      'IPE_300',
      'IPE_330',
      'IPE_360',
      'IPE_400',
      'IPE_450',
      'IPE_500',
      'IPE_550',
      'IPE_600',
    ];
    List<String> half_ipe_section_names = [
      '1/2 IPE_140',
      '1/2 IPE_160',
      '1/2 IPE_180',
      '1/2 IPE_200',
      '1/2 IPE_220',
      '1/2 IPE_240',
      '1/2 IPE_270',
      '1/2 IPE_300',
      '1/2 IPE_330',
      '1/2 IPE_360',
      '1/2 IPE_400',
      '1/2 IPE_450',
      '1/2 IPE_500',
      '1/2 IPE_550',
      '1/2 IPE_600',
    ];

    List<String> ipeo_section_names = [
      'IPEo_180',
      'IPEo_200',
      'IPEo_220',
      'IPEo_240',
      'IPEo_270',
      'IPEo_300',
      'IPEo_330',
      'IPEo_360',
      'IPEo_400',
      'IPEo_450',
      'IPEo_500',
      'IPEo_550',
      'IPEo_600',
    ];
    List<String> half_ipeo_section_names = [
      '1/2 IPEo_270',
      '1/2 IPEo_300',
      '1/2 IPEo_330',
      '1/2 IPEo_360',
      '1/2 IPEo_400',
      '1/2 IPEo_450',
      '1/2 IPEo_500',
      '1/2 IPEo_550',
      '1/2 IPEo_600',
    ];
    List<String> ipev_section_names = [
      'IPEv_400',
      'IPEv_450',
      'IPEv_500',
      'IPEv_550',
      'IPEv_600',
    ];
    List<String> half_ipev_section_names = [
      '1/2 IPEv_400',
      '1/2 IPEv_450',
      '1/2 IPEv_500',
      '1/2 IPEv_550',
      '1/2 IPEv_600',
    ];
    List<String> heaa_section_names = [
      'HEAA_100',
      'HEAA_120',
      'HEAA_140',
      'HEAA_160',
      'HEAA_180',
      'HEAA_200',
      'HEAA_220',
      'HEAA_240',
      'HEAA_260',
      'HEAA_280',
      'HEAA_300',
      'HEAA_320',
      'HEAA_340',
      'HEAA_360',
      'HEAA_400',
      'HEAA_450',
      'HEAA_500',
      'HEAA_550',
      'HEAA_650',
      'HEAA_600',
      'HEAA_700',
      'HEAA_800',
      'HEAA_900',
      'HEAA_1000',
    ];
    List<String> hex_section_names = [
      '100',
      '120',
      '140',
      '160',
      '180',
      '200',
      '220',
      '240',
      '260',
      '280',
      '300',
      '320',
      '340',
      '360',
      '400',
      '450',
      '500',
      '550',
      '600',
      '650',
      '700',
      '800',
      '900',
      '1000',
    ];
    List<String> half_hex_section_names = [
      '140',
      '160',
      '180',
      '200',
      '220',
      '240',
      '260',
      '280',
      '300',
      '320',
      '340',
      '360',
      '400',
      '450',
      '500',
      '550',
      '600',
      '650',
      '700',
      '800',
    ];
    List<String> hd_section_names = [
      'HD 260 x 54.1',
      'HD 260 x 68.2',
      'HD 260 x 93.0',
      'HD 260 x 114',
      'HD 260 x 142',
      'HD 260 x 172',
      'HD 260 x 225',
      'HD 260 x 299',
      'HD 320 x 79.4',
      'HD 320 x 97.6',
      'HD 320 x 127',
      'HD 320 x 158',
      'HD 320 x 198',
      'HD 320 x 245',
      'HD 320 x 300',
      'HD 360 x 134',
      'HD 360 x 147',
      'HD 360 x 162',
      'HD 360 x 179',
      'HD 360 x 196',
      'HD 400 x 187',
      'HD 400 x 216',
      'HD 400 x 237',
      'HD 400 x 262',
      'HD 400 x 287',
      'HD 400 x 314',
      'HD 400 x 347',
      'HD 400 x 382',
      'HD 400 x 421',
      'HD 400 x 463',
      'HD 400 x 509',
      'HD 400 x 551',
      'HD 400 x 592',
      'HD 400 x 634',
      'HD 400 x 677',
      'HD 400 x 744',
      'HD 400 x 818',
      'HD 400 x 900',
      'HD 400 x 990',
      'HD 400 x 1086',
      'HD 400 x 1202',
      'HD 400 x 1299',
    ];
    List<String> hl_section_names = [
      '920 x 344  ',
      '920 x 368  ',
      '920 x 390  ',
      '920 x 420  ',
      '920 x 449  ',
      '920 x 491  ',
      '920 x 537',
      '920 x 588',
      '920 x 656',
      '920 x 725',
      '920 x 787',
      '920 x 970',
      '920 x 1077',
      '920 x 1194',
      '920 x 1269',
      '920 x 1377',
      '1000 AA',
      '1000 A',
      '1000 B',
      '1000 M',
      '1000 x 443',
      '1000 x 483',
      '1000 x 539',
      '1000 x 554',
      '1000 x 591',
      '1000 x 642',
      '1000 x 748',
      '1000 x 883',
      '1000 x 976',
      '1100 A',
      '1100 B',
      '1100 M',
      '1100 R',
      '1100 x 548',
      '1100 x 607',
    ];
    List<String> hlz_section_names = [
      '1100A',
      '1100B',
      '1100C',
      '1100D',
    ];
    List<String> upn_spinner = [
      'UPN 50',
      'UPN 65',
      'UPN 80',
      'UPN 100',
      'UPN 120',
      'UPN 140',
      'UPN 160',
      'UPN 180',
      'UPN 200',
      'UPN 220',
      'UPN 240',
      'UPN 260',
      'UPN 280',
      'UPN 300',
      'UPN 320',
      'UPN 350',
      'UPN 380',
      'UPN 400',
    ];
    List<String> upn_section_names = [
      '50',
      '65',
      '80',
      '100',
      '120',
      '140',
      '160',
      '180',
      '200',
      '220',
      '240',
      '260',
      '280',
      '300',
      '320',
      '350',
      '380',
      '400',
    ];
    List<String> upe_section_names = [
      '80',
      '100',
      '120',
      '140',
      '160',
      '180',
      '200',
      '220',
      '240',
      '270',
      '300',
      '330',
      '360',
      '400',
    ];

    List<String> t_section_names = [
      '30',
      '35',
      '40',
      '50',
      '60',
      '70',
      '80',
      '100',
      '120',
      '140',
    ];
    List<String> z_section_names = [
      '30',
      '40',
      '50',
      '60',
      '80',
      '100',
      '120',
      '140',
      '160',
    ];
    List<String> glL_section_names = [
      '40 x 4',
      '40 x 5',
      '45 x 4.5',
      '50 x 4',
      '50 x 5',
      '50 x 6',
      '60 x 5',
      '60 x 6',
      '60 x 8',
      '65 x 7',
      '70 x 6',
      '70 x 7',
      '75 x 6',
      '75 x 8',
      '80 x 8',
      '80 x 10',
      '90 x 7',
      '90 x 8',
      '90 x 9',
      '90 x 10',
      '100 x 8',
      '100 x 10',
      '100 x 112',
      '120 x 10',
      '120 x 12',
      '130 x 12',
      '150 x 10',
      '150 x 12',
      '150 x 15',
      '160 x 15',
      '180 x 16',
      '180 x 18',
      '200 x 16',
      '200 x 18',
      '200 x 20',
      '200 x 24',
      '250 x 17',
      '250 x 20',
      '250 x 28',
      '250 x 35',
      '300 x 25',
      '300 x 28',
      '300 x 31',
      '300 x 35',
    ];
    List<String> unglL_section_names = [
      '40 x 20 x 4',
      '40 x 25 x 4',
      '45 x 30 x 4',
      '50 x 30 x 5',
      '60 x 30 x 5',
      '60 x 40 x 5',
      '60 x 40 x 6',
      '65 x 50 x 7',
      '70 x 50 x 6',
      '75 x 50 x 6',
      '75 x 50 x 8',
      '80 x 40 x 6',
      '80 x 40 x 8',
      '80 x 60 x 7',
      '100 x 50 x 6',
      '100 x 50 x 8',
      '100 x 65 x 7',
      '100 x 65 x 8',
      '100 x 65 x 10',
      '100 x 75 x 8',
      '100 x 75 x 10',
      '100 x 75 x 12',
      '120 x 80 x 8',
      '120 x 80 x 10',
      '120 x 80 x 12',
      '125 x 75 x 8',
      '125 x 75 x 10',
      '125 x 75 x 12',
      '135 x 65 x 8',
      '135 x 65 x 10',
      '150 x 75 x 9',
      '150 x 75 x 10',
      '150 x 75 x 12',
      '150 x 75 x 15',
      '150 x 90 x 10',
      '150 x 90 x 12',
      '150 x 90 x 15',
      '150 x 100 x 10',
      '150 x 100 x 12',
      '200 x 100 x 10',
      '200 x 100 x 12',
      '200 x 100 x 15',
      '200 x 150 x 12',
      '200 x 150 x 15',
    ];
    List<String> circle_section_names = [
      '33.7 x 2.5',
      '33.7 x 4',
      '42.4 x 2.5',
      '42.4 x 4',
      '48.3 x 2.5',
      '48.3 x 4',
      '48.3 x 5',
      '60.3 x 2.5',
      '60.3 x 4',
      '60.3 x 5',
      '76.1 x 2.5',
      '76.1 x 4',
      '76.1 x 5',
      '88.9 x 3',
      '88.9 x 5',
      '88.9 x 6.3',
      '101.6 x 4',
      '101.6 x 6.3',
      '101.6 x 8',
      '101.6 x 10',
      '114.3 x 4',
      '114.3 x 6.3',
      '114.3 x 8',
      '114.3 x 10',
      '139.7 x 4',
      '139.7 x 6.3',
      '139.7 x 8',
      '139.7 x 12.5',
      '168.3 x 4',
      '168.3 x 8',
      '168.3 x 10',
      '168.3 x 12.5',
      '177.8 x 5',
      '177.8 x 8',
      '177.8 x 10',
      '177.8 x 12.5',
      '193.7 x 6.3',
      '177.8 x 10',
      '177.8 x 16',
      '219.1 x 6.3',
      '219.1 x 10',
      '219.1 x 12.5',
      '219.1 x 20',
    ];
    List<String> Wsquare_section_names = [
      '40 x 4',
      '40 x 5',
      '50 x 4',
      '50 x 5',
      '50 x 6.3',
      '60 x 4',
      '60 x 5',
      '60 x 6.3',
      '60 x 8',
      '70 x 4',
      '70 x 5',
      '70 x 6.3',
      '70 x 8',
      '80 x 4',
      '80 x 5',
      '80 x 6.3',
      '80 x 8',
      '90 x 4',
      '90 x 5',
      '90 x 6.3',
      '90 x 8',
      '100 x 4',
      '100 x 5',
      '100 x 6.3',
      '100 x 8',
      '100 x 10',
      '120 x 5',
      '120 x 6.3',
      '120 x 8',
      '120 x 10',
      '120 x 12.5',
      '140 x 5',
      '140 x 6.3',
      '140 x 8',
      '140 x 10',
      '140 x 12.5',
      '150 x 6.3',
      '150 x 8',
      '150 x 10',
      '150 x 12.5',
      '150 x 16',
      '160 x 6.3',
      '160 x 8',
      '160 x 10',
      '160 x 12.5',
      '160 x 16',
      '180 x 6.3',
      '180 x 8',
      '180 x 10',
      '180 x 12.5',
      '180 x 16',
      '200 x 6.3',
      '200 x 8',
      '200 x 10',
      '200 x 12.5',
      '200 x 16',
      '220 x 6.3',
      '220 x 8',
      '220 x 10',
      '220 x 12.5',
      '220 x 16',
      '250 x 6.3',
      '250 x 8',
      '250 x 10',
      '250 x 12.5',
      '250 x 16',
      '260 x 6.3',
      '260 x 8',
      '260 x 10',
      '260 x 12.5',
      '260 x 16',
      '300 x 6.3',
      '300 x 8',
      '300 x 10',
      '300 x 12.5',
      '300 x 16',
      '350 x 8',
      '350 x 10',
      '350 x 12.5',
      '350 x 16',
      '400 x 10',
      '400 x 12.5',
      '400 x 16',
      '400 x 20',
    ];
    List<String> Ksquare_section_names = [
      '30 x 2.5',
      '40 x 3',
      '40 x 4',
      '50 x 3',
      '50 x 4',
      '50 x 5',
      '60 x 3',
      '60 x 4',
      '60 x 5',
      '60 x 6.3',
      '60 x 8',
      '70 x 3',
      '70 x 4',
      '70 x 5',
      '70 x 6.3',
      '80 x 4',
      '80 x 5',
      '80 x 6.3',
      '80 x 8',
      '90 x 4',
      '90 x 5',
      '90 x 6.3',
      '90 x 8',
      '100 x 5',
      '100 x 6.3',
      '100 x 8',
      '100 x 10',
      '100 x 12.5',
      '120 x 5',
      '120 x 6.3',
      '120 x 8',
      '120 x 10',
      '120 x 12.5',
      '140 x 5',
      '140 x 6.3',
      '140 x 8',
      '140 x 10',
      '140 x 12.5',
      '150 x 5',
      '150 x 6.3',
      '150 x 8',
      '150 x 10',
      '150 x 12.5',
      '150 x 16',
      '160 x 5',
      '160 x 6.3',
      '160 x 8',
      '160 x 10',
      '160 x 12.5',
      '160 x 16',
      '180 x 6.3',
      '180 x 8',
      '180 x 10',
      '180 x 12.5',
      '180 x 16',
      '200 x 6.3',
      '200 x 8',
      '200 x 10',
      '200 x 12.5',
      '200 x 16',
      '220 x 6.3',
      '220 x 8',
      '220 x 10',
      '220 x 12.5',
      '220 x 16',
      '250 x 6.3',
      '250 x 8',
      '250 x 10',
      '250 x 12.5',
      '250 x 16',
      '260 x 6.3',
      '260 x 8',
      '260 x 10',
      '260 x 12.5',
      '260 x 16',
      '300 x 6.3',
      '300 x 8',
      '300 x 10',
      '300 x 12.5',
      '300 x 16',
      '350 x 8',
      '350 x 10',
      '350 x 12.5',
      '350 x 16',
      '400 x 10',
      '400 x 12.5',
      '400 x 16',
    ];
    List<String> Wrec_section_names = [
      '50 x 30 x 3.2',
      '50 x 30 x 4',
      '50 x 30 x 5',
      '60 x 40 x 3.2',
      '60 x 40 x 4',
      '60 x 40 x 5',
      '60 x 40 x 6.3',
      '80 x 40 x 4',
      '80 x 40 x 5',
      '80 x 40 x 6.3',
      '80 x 40 x 8',
      '90 x 50 x 4',
      '90 x 50 x 5',
      '90 x 50 x 6.3',
      '90 x 50 x 8',
      '100 x 50 x 4',
      '100 x 50 x 5',
      '100 x 50 x 6.3',
      '100 x 50 x 8',
      '120 x 60 x 4',
      '120 x 60 x 5',
      '120 x 60 x 6.3',
      '120 x 60 x 8',
      '120 x 60 x 10',
      '120 x 80 x 4',
      '120 x 80 x 5',
      '120 x 80 x 6.3',
      '120 x 80 x 8',
      '120 x 80 x 10',
      '140 x 80 x 4',
      '140 x 80 x 5',
      '140 x 80 x 6.3',
      '140 x 80 x 8',
      '140 x 80 x 10',
      '150 x 100 x 6.3',
      '150 x 100 x 8',
      '150 x 100 x 12.5',
      '160 x 80 x 5',
      '160 x 80 x 6.3',
      '160 x 80 x 8',
      '160 x 80 x 12.5',
      '180 x 100 x 5',
      '180 x 100 x 6.3',
      '180 x 100 x 8',
      '180 x 100 x 10',
      '180 x 100 x 12.5',
      '200 x 100 x 6.3',
      '200 x 100 x 8',
      '200 x 100 x 10',
      '200 x 100 x 12.5',
      '200 x 100 x 16',
      '200 x 120 x 6.3',
      '200 x 120 x 8',
      '200 x 120 x 10',
      '200 x 120 x 12.5',
      '250 x 150 x 6.3',
      '250 x 150 x 8',
      '250 x 150 x 10',
      '250 x 150 x 12.5',
      '250 x 150 x 16',
      '260 x 180 x 6.3',
      '260 x 180 x 8',
      '260 x 180 x 10',
      '260 x 180 x 12.5',
      '260 x 180 x 16',
      '300 x 200 x 6.3',
      '300 x 200 x 8',
      '300 x 200 x 10',
      '300 x 200 x 12.5',
      '300 x 200 x 16',
      '350 x 250 x 6.3',
      '350 x 250 x 8',
      '350 x 250 x 10',
      '350 x 250 x 12.5',
      '350 x 250 x 16',
      '400 x 200 x 8',
      '400 x 200 x 10',
      '400 x 200 x 12.5',
      '400 x 200 x 16',
      '450 x 250 x 8',
      '450 x 250 x 10',
      '450 x 250 x 12.5',
      '450 x 250 x 16',
      '500 x 300 x 10',
      '500 x 300 x 12.5',
      '500 x 300 x 16',
      '500 x 300 x 20',
    ];
    List<String> Krec_section_names = [
      '50 x 30 x 3',
      '50 x 30 x 4',
      '60 x 40 x 3',
      '60 x 40 x 4',
      '60 x 40 x 5',
      '80 x 40 x 3',
      '80 x 40 x 4',
      '80 x 40 x 5',
      '90 x 50 x 4',
      '90 x 50 x 5',
      '100 x 50 x 4',
      '100 x 50 x 5',
      '100 x 50 x 6.3',
      '100 x 60 x 4',
      '100 x 60 x 5',
      '100 x 60 x 6.3',
      '100 x 80 x 4',
      '100 x 80 x 5',
      '100 x 80 x 6.3',
      '120 x 60 x 4',
      '120 x 60 x 5',
      '120 x 60 x 6.3',
      '120 x 60 x 8',
      '120 x 80 x 4',
      '120 x 80 x 5',
      '120 x 80 x 6.3',
      '120 x 80 x 8',
      '140 x 80 x 4',
      '140 x 80 x 5',
      '140 x 80 x 6.3',
      '140 x 80 x 8',
      '140 x 80 x 10',
      '150 x 100 x 5',
      '150 x 100 x 6.3',
      '150 x 100 x 8',
      '150 x 100 x 10',
      '150 x 100 x 12.5',
      '160 x 80 x 5',
      '160 x 80 x 6.3',
      '160 x 80 x 8',
      '160 x 80 x 10',
      '160 x 80 x 12.5',
      '180 x 100 x 6.3',
      '180 x 100 x 8',
      '180 x 100 x 10',
      '180 x 100 x 12.5',
      '200 x 100 x 6.3',
      '200 x 100 x 8',
      '200 x 100 x 10',
      '200 x 100 x 12.5',
      '200 x 120 x 6.3',
      '200 x 120 x 8',
      '200 x 120 x 10',
      '200 x 120 x 12.5',
      '250 x 150 x 6.3',
      '250 x 150 x 8',
      '250 x 150 x 10',
      '250 x 150 x 12.5',
      '250 x 150 x 16',
      '260 x 180 x 6.3',
      '260 x 180 x 8',
      '260 x 180 x 10',
      '260 x 180 x 12',
      '260 x 180 x 16',
      '300 x 100 x 6.3',
      '300 x 100 x 8',
      '300 x 100 x 10',
      '300 x 100 x 12',
      '300 x 100 x 16',
      '300 x 150 x 6.3',
      '350 x 150 x 8',
      '350 x 150 x 10',
      '350 x 150 x 12',
      '350 x 150 x 16',
      '300 x 200 x 6.3',
      '300 x 200 x 8',
      '300 x 200 x 10',
      '300 x 200 x 12',
      '300 x 200 x 16',
      '350 x 250 x 8',
      '350 x 250 x 10',
      '350 x 250 x 12',
      '350 x 250 x 16',
      '400 x 200 x 10',
      '400 x 200 x 12',
      '400 x 200 x 16',
      '400 x 300 x 10',
      '400 x 300 x 12',
      '400 x 300 x 16',
    ];

    ipe_section = ipe_section_names;
    ipn_section = sumItemToArray(IPN, ipn_section_names);
    halfipe_section = half_ipe_section_names;
    ipea_section = ipea_section_names;
    ipeo_section = ipeo_section_names;
    halfipeo_section = half_ipeo_section_names;
    ipev_section = ipev_section_names;
    halfipev_section = half_ipev_section_names;
    heaa_section = heaa_section_names;
    hd_section = hd_section_names;
    HEA_section = sumItemToArray(HEA, hex_section_names);
    HEB_section = sumItemToArray(HEB, hex_section_names);
    HEM_section = sumItemToArray(HEM, hex_section_names);
    halfHEA_section = sumItemToArray(half_HEA, half_hex_section_names);
    halfHEB_section = sumItemToArray(half_HEB, half_hex_section_names);
    halfHEM_section = sumItemToArray(half_HEM, half_hex_section_names);
    hl_section = sumItemToArray(Hl, hl_section_names);
    hlz_section = sumItemToArray(HLZ, hlz_section_names);
    UPe_section = sumItemToArray(UPE, upe_section_names);
    UPn_section = sumItemToArray(UPN, upn_section_names);
    t_section = sumItemToArray(T, t_section_names);
    z_section = sumItemToArray(z, z_section_names);
    glL_section = sumItemToArray(L, glL_section_names);
    unglL_section = sumItemToArray(L, unglL_section_names);
    Circle_section = sumItemToArray(circle, circle_section_names);
    Wsquare_section = sumItemToArray(WholoSquare, Wsquare_section_names);
    Ksquare_section = sumItemToArray(KholoSquare, Ksquare_section_names);
    Wrec_section = sumItemToArray(Wrec, Wrec_section_names);
    Krec_section = sumItemToArray(Krec, Krec_section_names);
  }

  List<String> sumItemToArray(String item, List<String> Array) {
    List<String> arrayRetern = new List();
    for (int i = 0; i < Array.length; i++) {
      arrayRetern.add( item +  ' ' + Array[i]);
    }
    return arrayRetern;
  }

 List<String> I_section() {
    List<String> arrayListreturn = new List();
    for (int i = 0; i < ipn_section.length; i++) {
      arrayListreturn.add(ipn_section[i]);
    }
    for (int i = 0; i < ipe_section.length; i++) {
      arrayListreturn.add(ipe_section[i]);
    }
    for (int i = 0; i < ipea_section.length; i++) {
      arrayListreturn.add(ipea_section[i]);
    }
    for (int i = 0; i < ipev_section.length; i++) {
      arrayListreturn.add(ipev_section[i]);
    }
    for (int i = 0; i < ipeo_section.length; i++) {
      arrayListreturn.add(ipeo_section[i]);
    }
    for (int i = 0; i < heaa_section.length; i++) {
      arrayListreturn.add(heaa_section[i]);
    }
    for (int i = 0; i < hd_section.length; i++) {
      arrayListreturn.add(hd_section[i]);
    }
    for (int i = 0; i < hl_section.length; i++) {
      arrayListreturn.add(hl_section[i]);
    }
    for (int i = 0; i < hlz_section.length; i++) {
      arrayListreturn.add(hlz_section[i]);
    }
    for (int i = 0; i < HEA_section.length; i++) {
      arrayListreturn.add(HEA_section[i]);
    }
    for (int i = 0; i < HEB_section.length; i++) {
      arrayListreturn.add(HEB_section[i]);
    }
    for (int i = 0; i < HEM_section.length; i++) {
      arrayListreturn.add(HEM_section[i]);
    }
    return arrayListreturn;
  }

  List<String> IPN_section() {
    List<String> arrayListreturn = new List();
    for (int i = 0; i < ipn_section.length; i++) {
      arrayListreturn.add(ipn_section[i]);
    }
    return arrayListreturn;
  }

  List<String> IPE_section() {
    List<String> arrayListreturn = new List();
    for (int i = 0; i < ipe_section.length; i++) {
      arrayListreturn.add(ipe_section[i]);
    }
    for (int i = 0; i < ipea_section.length; i++) {
      arrayListreturn.add(ipea_section[i]);
    }
    for (int i = 0; i < ipev_section.length; i++) {
      arrayListreturn.add(ipev_section[i]);
    }
    for (int i = 0; i < ipeo_section.length; i++) {
      arrayListreturn.add(ipeo_section[i]);
    }
    return arrayListreturn;
  }

  List<String> HD_section() {
    List<String> arrayListreturn = new List();
    /*for(int i=0; i<i_section.length; i++){
            arrayListreturn.add(i_section[i]);
        }*/
    for (int i = 0; i < hd_section.length; i++) {
      arrayListreturn.add(hd_section[i]);
    }
    return arrayListreturn;
  }

  List<String> HE_section() {
    List<String> arrayListreturn = new List();
    /*for(int i=0; i<i_section.length; i++){
            arrayListreturn.add(i_section[i]);
        }*/
    for (int i = 0; i < heaa_section.length; i++) {
      arrayListreturn.add(heaa_section[i]);
    }
    for (int i = 0; i < HEA_section.length; i++) {
      arrayListreturn.add(HEA_section[i]);
    }
    for (int i = 0; i < HEB_section.length; i++) {
      arrayListreturn.add(HEB_section[i]);
    }
    for (int i = 0; i < HEM_section.length; i++) {
      arrayListreturn.add(HEM_section[i]);
    }
    return arrayListreturn;
  }

  List<String> HL_section() {
    List<String> arrayListreturn = new List();
    /*for(int i=0; i<i_section.length; i++){
            arrayListreturn.add(i_section[i]);
        }*/
    for (int i = 0; i < hl_section.length; i++) {
      arrayListreturn.add(hl_section[i]);
    }
    for (int i = 0; i < hlz_section.length; i++) {
      arrayListreturn.add(hlz_section[i]);
    }
    return arrayListreturn;
  }

  List<String> U_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < UPe_section.length; i++) {
      arrayListretern.add(UPe_section[i]);
    }
    for (int i = 0; i < UPn_section.length; i++) {
      arrayListretern.add(UPn_section[i]);
    }
    return arrayListretern;
  }

  List<String> UPN_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < UPn_section.length; i++) {
      arrayListretern.add(UPn_section[i]);
    }
    return arrayListretern;
  }

  List<String> UPE_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < UPe_section.length; i++) {
      arrayListretern.add(UPe_section[i]);
    }
    return arrayListretern;
  }

  List<String> T_section() {
    List<String> arrayListreturn = new List();
    for (int i = 0; i < t_section.length; i++) {
      arrayListreturn.add(t_section[i]);
    }

    return arrayListreturn;
  }

  List<String> T0_section() {
    List<String> arrayListreturn = new List();
    for (int i = 0; i < t_section.length; i++) {
      arrayListreturn.add(t_section[i]);
    }
    for (int i = 0; i < halfipe_section.length; i++) {
      arrayListreturn.add(halfipe_section[i]);
    }
    for (int i = 0; i < halfipeo_section.length; i++) {
      arrayListreturn.add(halfipeo_section[i]);
    }
    for (int i = 0; i < halfipev_section.length; i++) {
      arrayListreturn.add(halfipev_section[i]);
    }
    for (int i = 0; i < halfHEA_section.length; i++) {
      arrayListreturn.add(halfHEA_section[i]);
    }
    for (int i = 0; i < halfHEB_section.length; i++) {
      arrayListreturn.add(halfHEB_section[i]);
    }
    for (int i = 0; i < halfHEM_section.length; i++) {
      arrayListreturn.add(halfHEM_section[i]);
    }

    return arrayListreturn;
  }

  List<String> Thalf_section() {
    List<String> arrayListreturn = new List();
    for (int i = 0; i < halfipe_section.length; i++) {
      arrayListreturn.add(halfipe_section[i]);
    }
    for (int i = 0; i < halfipeo_section.length; i++) {
      arrayListreturn.add(halfipeo_section[i]);
    }
    for (int i = 0; i < halfipev_section.length; i++) {
      arrayListreturn.add(halfipev_section[i]);
    }
    for (int i = 0; i < halfHEA_section.length; i++) {
      arrayListreturn.add(halfHEA_section[i]);
    }
    for (int i = 0; i < halfHEB_section.length; i++) {
      arrayListreturn.add(halfHEB_section[i]);
    }
    for (int i = 0; i < halfHEM_section.length; i++) {
      arrayListreturn.add(halfHEM_section[i]);
    }

    return arrayListreturn;
  }

  List<String> Z_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < z_section.length; i++) {
      arrayListretern.add(z_section[i]);
    }
    return arrayListretern;
  }

  List<String> L0_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < glL_section.length; i++) {
      arrayListretern.add(glL_section[i]);
    }
    for (int i = 0; i < unglL_section.length; i++) {
      arrayListretern.add(unglL_section[i]);
    }
    return arrayListretern;
  }

  List<String> Lequal_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < glL_section.length; i++) {
      arrayListretern.add(glL_section[i]);
    }
    return arrayListretern;
  }

  List<String> Lunequal_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < unglL_section.length; i++) {
      arrayListretern.add(unglL_section[i]);
    }
    return arrayListretern;
  }

  List<String> circle_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < Circle_section.length; i++) {
      arrayListretern.add(Circle_section[i]);
    }
    return arrayListretern;
  }

  List<String> WRec_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < Wrec_section.length; i++) {
      arrayListretern.add(Wrec_section[i]);
    }
    return arrayListretern;
  }

  List<String> KRec_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < Krec_section.length; i++) {
      arrayListretern.add(Krec_section[i]);
    }
    return arrayListretern;
  }

  List<String> Wsquar_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < Wsquare_section.length; i++) {
      arrayListretern.add(Wsquare_section[i]);
    }
    return arrayListretern;
  }

  List<String> Ksquar_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < Ksquare_section.length; i++) {
      arrayListretern.add(Ksquare_section[i]);
    }
    return arrayListretern;
  }

  List<String> HolwRec_section() {
    List<String> arrayListretern = new List();
    for (int i = 0; i < Wsquare_section.length; i++) {
      arrayListretern.add(Wsquare_section[i]);
    }
    for (int i = 0; i < Ksquare_section.length; i++) {
      arrayListretern.add(Ksquare_section[i]);
    }
    for (int i = 0; i < Wrec_section.length; i++) {
      arrayListretern.add(Wrec_section[i]);
    }
    for (int i = 0; i < Krec_section.length; i++) {
      arrayListretern.add(Krec_section[i]);
    }
    return arrayListretern;
  }
}

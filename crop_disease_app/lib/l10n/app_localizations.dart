import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

// This file is a manual delegate wrapper.
// Run: flutter gen-l10n to auto-generate from .arb files.
// For now, this provides a working implementation.

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'home': 'Home',
      'history': 'History',
      'settings': 'Settings',
      'welcomeMessage': 'Hello, Farmer 👋',
      'homeSubtitle': 'Take a photo of your crop to detect diseases instantly.',
      'scanCrop': 'Scan Crop',
      'scanCropSubtitle': 'Use your camera to capture a leaf',
      'uploadImage': 'Upload Image',
      'uploadImageSubtitle': 'Choose a photo from your gallery',
      'results': 'Results',
      'confidence': 'Confidence:',
      'description': 'Description',
      'treatment': 'Treatment',
      'backToHome': 'Back to Home',
      'offlineMode': 'Offline Mode',
      'noImageSelected': 'No image selected',
      'takePhoto': 'Take Photo',
      'chooseFromGallery': 'Choose from Gallery',
      'analyzeImage': 'Analyze Image',
      'analyzing': 'Analyzing...',
      'retake': 'Retake',
      'noHistory': 'No scans yet. Start by scanning a crop.',
      'language': 'Language',
      'logout': 'Logout',
      'login': 'Login',
      'welcomeBack': 'Welcome Back',
      'loginSubtitle': 'Sign in to sync your scan history',
      'email': 'Email',
      'password': 'Password',
      'invalidEmail': 'Enter a valid email',
      'passwordTooShort': 'Password must be at least 6 characters',
      'continueOffline': 'Continue without account',
      'noAccount': "Don't have an account?",
      'register': 'Register',
      'fullName': 'Full Name',
      'fieldRequired': 'This field is required',
      'createAccount': 'Create Account',
    },
    'sw': {
      'home': 'Nyumbani',
      'history': 'Historia',
      'settings': 'Mipangilio',
      'welcomeMessage': 'Habari, Mkulima 👋',
      'homeSubtitle': 'Piga picha ya mazao yako ili kugundua magonjwa mara moja.',
      'scanCrop': 'Scan Mazao',
      'scanCropSubtitle': 'Tumia kamera yako kupiga picha ya jani',
      'uploadImage': 'Pakia Picha',
      'uploadImageSubtitle': 'Chagua picha kutoka kwenye gallery yako',
      'results': 'Matokeo',
      'confidence': 'Uhakika:',
      'description': 'Maelezo',
      'treatment': 'Matibabu',
      'backToHome': 'Rudi Nyumbani',
      'offlineMode': 'Hali ya Nje ya Mtandao',
      'noImageSelected': 'Hakuna picha iliyochaguliwa',
      'takePhoto': 'Piga Picha',
      'chooseFromGallery': 'Chagua kutoka Gallery',
      'analyzeImage': 'Changanua Picha',
      'analyzing': 'Inachambua...',
      'retake': 'Piga tena',
      'noHistory': 'Hakuna scan bado. Anza kwa kuscan mazao.',
      'language': 'Lugha',
      'logout': 'Toka',
      'login': 'Ingia',
      'welcomeBack': 'Karibu Tena',
      'loginSubtitle': 'Ingia ili kusawazisha historia yako ya scan',
      'email': 'Barua pepe',
      'password': 'Nywila',
      'invalidEmail': 'Weka barua pepe sahihi',
      'passwordTooShort': 'Nywila lazima iwe na herufi 6 au zaidi',
      'continueOffline': 'Endelea bila akaunti',
      'noAccount': 'Huna akaunti?',
      'register': 'Jisajili',
      'fullName': 'Jina Kamili',
      'fieldRequired': 'Sehemu hii inahitajika',
      'createAccount': 'Fungua Akaunti',
    },
    'am': {
      'home': 'መነሻ',
      'history': 'ታሪክ',
      'settings': 'ቅንብሮች',
      'welcomeMessage': 'ሰላም፣ ገበሬ 👋',
      'homeSubtitle': 'የሰብልዎን ፎቶ ያንሱ እና በቅጽበት በሽታዎችን ያግኙ።',
      'scanCrop': 'ሰብልን ስካን ያድርጉ',
      'scanCropSubtitle': 'ቅጠሉን ለማንሳት ካሜራዎን ይጠቀሙ',
      'uploadImage': 'ምስል ይጫኑ',
      'uploadImageSubtitle': 'ከጋለሪዎ ፎቶ ይምረጡ',
      'results': 'ውጤቶች',
      'confidence': 'እርግጠኝነት:',
      'description': 'መግለጫ',
      'treatment': 'ህክምና',
      'backToHome': 'ወደ መነሻ ተመለስ',
      'offlineMode': 'ከመስመር ውጭ ሁነታ',
      'noImageSelected': 'ምንም ምስል አልተመረጠም',
      'takePhoto': 'ፎቶ ያንሱ',
      'chooseFromGallery': 'ከጋለሪ ይምረጡ',
      'analyzeImage': 'ምስሉን ይተንትኑ',
      'analyzing': 'በመተንተን ላይ...',
      'retake': 'እንደገና ያንሱ',
      'noHistory': 'እስካሁን ምንም ስካን የለም። ሰብልን በስካን ይጀምሩ።',
      'language': 'ቋንቋ',
      'logout': 'ውጣ',
      'login': 'ግባ',
      'welcomeBack': 'እንኳን ደህና ተመለሱ',
      'loginSubtitle': 'የስካን ታሪክዎን ለማስተባበር ይግቡ',
      'email': 'ኢሜይል',
      'password': 'የይለፍ ቃል',
      'invalidEmail': 'ትክክለኛ ኢሜይል ያስገቡ',
      'passwordTooShort': 'የይለፍ ቃሉ ቢያንስ 6 ቁምፊዎች ሊኖሩት ይገባል',
      'continueOffline': 'ያለ መለያ ቀጥሉ',
      'noAccount': 'መለያ የለዎትም?',
      'register': 'ይመዝገቡ',
      'fullName': 'ሙሉ ስም',
      'fieldRequired': 'ይህ መስክ ያስፈልጋል',
      'createAccount': 'መለያ ይፍጠሩ',
    },
  };

  String _t(String key) {
    final lang = _localizedStrings[locale.languageCode] ?? _localizedStrings['en']!;
    return lang[key] ?? _localizedStrings['en']![key] ?? key;
  }

  String get home => _t('home');
  String get history => _t('history');
  String get settings => _t('settings');
  String get welcomeMessage => _t('welcomeMessage');
  String get homeSubtitle => _t('homeSubtitle');
  String get scanCrop => _t('scanCrop');
  String get scanCropSubtitle => _t('scanCropSubtitle');
  String get uploadImage => _t('uploadImage');
  String get uploadImageSubtitle => _t('uploadImageSubtitle');
  String get results => _t('results');
  String get confidence => _t('confidence');
  String get description => _t('description');
  String get treatment => _t('treatment');
  String get backToHome => _t('backToHome');
  String get offlineMode => _t('offlineMode');
  String get noImageSelected => _t('noImageSelected');
  String get takePhoto => _t('takePhoto');
  String get chooseFromGallery => _t('chooseFromGallery');
  String get analyzeImage => _t('analyzeImage');
  String get analyzing => _t('analyzing');
  String get retake => _t('retake');
  String get noHistory => _t('noHistory');
  String get language => _t('language');
  String get logout => _t('logout');
  String get login => _t('login');
  String get welcomeBack => _t('welcomeBack');
  String get loginSubtitle => _t('loginSubtitle');
  String get email => _t('email');
  String get password => _t('password');
  String get invalidEmail => _t('invalidEmail');
  String get passwordTooShort => _t('passwordTooShort');
  String get continueOffline => _t('continueOffline');
  String get noAccount => _t('noAccount');
  String get register => _t('register');
  String get fullName => _t('fullName');
  String get fieldRequired => _t('fieldRequired');
  String get createAccount => _t('createAccount');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'sw', 'am'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Sent`
  String get sent {
    return Intl.message(
      'Sent',
      name: 'sent',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `EA`
  String get productName {
    return Intl.message(
      'EA',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `The text field is empty`
  String get emptyTextFiledErorr {
    return Intl.message(
      'The text field is empty',
      name: 'emptyTextFiledErorr',
      desc: '',
      args: [],
    );
  }

  /// `This is not an email, write proper email.`
  String get notCorrectEmailFormat {
    return Intl.message(
      'This is not an email, write proper email.',
      name: 'notCorrectEmailFormat',
      desc: '',
      args: [],
    );
  }

  /// `The written password is too short`
  String get tooShortPassword {
    return Intl.message(
      'The written password is too short',
      name: 'tooShortPassword',
      desc: '',
      args: [],
    );
  }

  /// `The given password is too weak`
  String get weakPasswor {
    return Intl.message(
      'The given password is too weak',
      name: 'weakPasswor',
      desc: '',
      args: [],
    );
  }

  /// `Do you have any techincal issue ?`
  String get technicalIssueQuestion {
    return Intl.message(
      'Do you have any techincal issue ?',
      name: 'technicalIssueQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Find out more`
  String get seeMore {
    return Intl.message(
      'Find out more',
      name: 'seeMore',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Search for products,invoices ..`
  String get searchPrivilage {
    return Intl.message(
      'Search for products,invoices ..',
      name: 'searchPrivilage',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Documents`
  String get documents {
    return Intl.message(
      'Documents',
      name: 'documents',
      desc: '',
      args: [],
    );
  }

  /// `Reservations`
  String get reservations {
    return Intl.message(
      'Reservations',
      name: 'reservations',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Analytics`
  String get analytics {
    return Intl.message(
      'Analytics',
      name: 'analytics',
      desc: '',
      args: [],
    );
  }

  /// `Production`
  String get production {
    return Intl.message(
      'Production',
      name: 'production',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get archive {
    return Intl.message(
      'Archive',
      name: 'archive',
      desc: '',
      args: [],
    );
  }

  /// `CRM`
  String get crm {
    return Intl.message(
      'CRM',
      name: 'crm',
      desc: '',
      args: [],
    );
  }

  /// `Contractors`
  String get contractors {
    return Intl.message(
      'Contractors',
      name: 'contractors',
      desc: '',
      args: [],
    );
  }

  /// `People`
  String get people {
    return Intl.message(
      'People',
      name: 'people',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get events {
    return Intl.message(
      'Events',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasks {
    return Intl.message(
      'Tasks',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `Add Contractor`
  String get addContractor {
    return Intl.message(
      'Add Contractor',
      name: 'addContractor',
      desc: '',
      args: [],
    );
  }

  /// `Modify`
  String get modify {
    return Intl.message(
      'Modify',
      name: 'modify',
      desc: '',
      args: [],
    );
  }

  /// `exhibitions`
  String get exhibitions {
    return Intl.message(
      'exhibitions',
      name: 'exhibitions',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get print {
    return Intl.message(
      'Print',
      name: 'print',
      desc: '',
      args: [],
    );
  }

  /// `Import From File`
  String get importFromFile {
    return Intl.message(
      'Import From File',
      name: 'importFromFile',
      desc: '',
      args: [],
    );
  }

  /// `Warehouse`
  String get warehouse {
    return Intl.message(
      'Warehouse',
      name: 'warehouse',
      desc: '',
      args: [],
    );
  }

  /// `House Keeping`
  String get houseKeeping {
    return Intl.message(
      'House Keeping',
      name: 'houseKeeping',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate`
  String get duplicate {
    return Intl.message(
      'Duplicate',
      name: 'duplicate',
      desc: '',
      args: [],
    );
  }

  /// `Implementation`
  String get implementation {
    return Intl.message(
      'Implementation',
      name: 'implementation',
      desc: '',
      args: [],
    );
  }

  /// `{usedGB} GB of {totalStorageGB} used`
  String usageStorage(Object usedGB, Object totalStorageGB) {
    return Intl.message(
      '$usedGB GB of $totalStorageGB used',
      name: 'usageStorage',
      desc: '',
      args: [usedGB, totalStorageGB],
    );
  }

  /// `of`
  String get Of {
    return Intl.message(
      'of',
      name: 'Of',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

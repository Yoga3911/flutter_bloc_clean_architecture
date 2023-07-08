part of 'translate_bloc.dart';

class TranslateState extends Equatable {
  final String languageCode;
  final String countryCode;
  final String previousCountryCode;

  const TranslateState(
    this.languageCode,
    this.countryCode,
    this.previousCountryCode,
  );

  @override
  List<Object> get props => [
        languageCode,
        countryCode,
        previousCountryCode,
      ];

  factory TranslateState.fromMap(Map<String, dynamic> map) {
    return TranslateState(
      map["language_code"],
      map["country_code"],
      map["previous_country_code"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "language_code": languageCode,
      "country_code": countryCode,
      "previous_country_code": previousCountryCode,
    };
  }
}

/// A phone number.
///
/// {@category Interfaces}
class ZetaPhoneNumber {
  /// Creates a new [ZetaPhoneNumber].
  const ZetaPhoneNumber({
    required this.dialCode,
    required this.number,
  });

  /// The dial code of the phone number.
  final String dialCode;

  /// The number of the phone number.
  final String number;
}

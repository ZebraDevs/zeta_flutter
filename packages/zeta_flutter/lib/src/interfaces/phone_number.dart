/// A phone number.
class PhoneNumber {
  /// Creates a new [PhoneNumber].
  const PhoneNumber({
    required this.dialCode,
    required this.number,
  });

  /// The dial code of the phone number.
  final String dialCode;

  /// The number of the phone number.
  final String number;
}

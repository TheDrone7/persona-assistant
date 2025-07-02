/// The elements a skill can belong to.
/// These are also used for persona and shadow weaknesses/resistances.
enum CombatElement {
  slash,
  strike,
  pierce,
  fire,
  ice,
  electric,
  wind,
  light,
  dark,
  almighty,
}

/// The ailments personas or shadows can be resistant to or weak against.
enum Ailment { charm, poison, distress, confusion, fear, rage }

/// The affinities that can be inherited by a persona when fusing.
/// These are similar to combat elements but there is no almighty element here.
enum InheritanceElement {
  slash,
  strike,
  pierce,
  fire,
  ice,
  electric,
  wind,
  light,
  dark,
  ailment,
  recovery,
  support,
}

/// The arcana that personas and shadows can belong to.
enum Arcana {
  fool,
  magician,
  priestess,
  empress,
  emperor,
  hierophant,
  lovers,
  chariot,
  justice,
  hermit,
  fortune,
  strength,
  hanged,
  death,
  temperance,
  devil,
  tower,
  star,
  moon,
  sun,
  judgement,
  aeon;

  /// The name of the arcana capitalized.
  @override
  String toString() => name[0].toUpperCase() + name.substring(1);

  /// Returns the path to the image of the arcana (must be prefixed with the proper asset location).
  /// For example, if the arcana is "Fool", the path will be "images/arcana/fool.png".
  String get imagePath => 'images/arcana/${name.toLowerCase()}.png';

  /// Returns the arcana from a string name.
  static Arcana fromString(String name) {
    for (var value in Arcana.values) {
      if (value.name.toLowerCase() == name.toLowerCase()) {
        return value;
      }
    }
    return Arcana
        .chariot; // Default to Chariot if not found (there is one unknown arcana in files that is supposed to be Chariot)
  }
}

/// Resistance codes used in the shadow and persona data
enum ResistanceCode {
  normal('-', {'-': 100, '_': 100}),
  weak('Wk', {'w': 125, 'v': 200, 'V': 200, 'u': 250, 'z': 1275}),
  resist('Rs', {'s': 50, 'S': 50, 't': 25, 'T': 25}),
  absorb('Ab', {'d': -200}),
  nullify('Nu', {'n': 0}),
  repel('Rp', {'r': -100});

  /// A short representation of the resistance code for display purposes.
  final String short;

  /// A map of aliases for the resistance code, where the key is the alias
  /// and the value is the %damage for that resistance code.
  final Map<String, int> aliases;
  const ResistanceCode(this.short, this.aliases);

  @override
  String toString() => short;

  static ResistanceCode fromString(String code) {
    for (var value in ResistanceCode.values) {
      if (value.aliases.containsKey(code)) {
        return value;
      }
    }
    return ResistanceCode.normal;
  }
}

/// The types of skills that a persona can inherit when fusing.
enum InheritanceTypes {
  none('000000000000'),
  strikeA('011111111111'),
  pierceA('101111111111'),
  slashA('110111111111'),
  iceA('111011111111'),
  fireA('111101111111'),
  windA('111110111111'),
  elecA('111111011111'),
  darkA('111111101101'),
  lightA('111111110011'),
  iceD('111011101101'),
  fireD('111101101101'),
  windD('111110101101'),
  elecD('111111001101'),
  iceL('111011110011'),
  fireL('111101110011'),
  windL('111110110011'),
  elecL('111111010011'),
  strikeB('111000011111'),
  pierceB('111111100001'),
  fireB('111100000011'),
  iceB('111010000011'),
  elecB('111001000011'),
  windB('111000100011'),
  lightB('111000010011'),
  darkB('111000001101'),
  slashB('111000000001'),
  lidarkA('000111111111'),
  lidarkB('111111111000'),
  ailment('000111101101'),
  recovery('000111110011'),
  almighty('111111111111');

  /// A string representation of the inheritance types, where each character
  /// represents whether a specific inheritance element is available.
  /// '1' means available, '0' means not available.
  final String code;
  const InheritanceTypes(this.code);

  /// Returns a map of inheritance elements that are available in this type.
  Map<InheritanceElement, bool> get asMap {
    final Map<InheritanceElement, bool> map = {};
    for (int i = 0; i < code.length; i++) {
      final element = InheritanceElement.values[i];
      map[element] = code[i] == '1';
    }
    return map;
  }

  /// Create an InheritanceTypes from a string name.
  static InheritanceTypes fromString(String code) {
    for (var value in InheritanceTypes.values) {
      if (value.name == code) {
        return value;
      }
    }
    return InheritanceTypes.none;
  }
}

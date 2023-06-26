/// An enumeration representing the budget range for a pet adoption.
enum Budget { lessThan50, between50And150, moreThan150, notDefined }

/// An enumeration representing the personality traits of a pet.
enum Personalities {
  sociable,
  independent,
  territorial,
  shy,
  aggressive,
  other
}

/// An enumeration representing the type of house where a pet will live.
enum HouseType { smallFlat, bigFlat, smallHouse, bigHouse, notDefined }

/// An enumeration representing the frequency of house changes for a pet owner.
enum HouseChangeFrequency { lessThanTwoYears, fiveYears, never, notDefined }

/// An enumeration representing the time availability of a pet owner.
enum TimeAvailability {
  lessThanTwo,
  betweenTwoAndFour,
  moreThanFour,
  notDefined
}

/// An enumeration representing the activity level of a pet.
enum ActivityLevel { notActive, active, veryActive, notDefined }

/// The [PersonalityForm] class representing a personality form for a pet adoption.
class PersonalityForm {
  /// The ID of the form.
  String? id;

  /// The name of the person filling out the form.
  String name;

  /// Whether the person filling out the form has other pets or not.
  bool hasPets;

  /// The personality trait of the existing pet(s) of the person filling out the form.
  String coexistingPersonality;

  /// The budget range of the person filling out the form.
  String budget;

  /// The type of house where the pet will live.
  String houseType;

  /// The frequency of house changes for the pet owner.
  String changeFrequency;

  /// The time availability of the pet owner.
  String timeAvailability;

  /// The activity level of the pet.
  String activityLevel;

  /// Constructs a new instance of the [PersonalityForm] class with the specified parameters.
  ///
  /// The [id], [name], [hasPets], [coexistingPersonality], [budget], [houseType], [changeFrequency], [timeAvailability], and [activityLevel] parameters must not be null.
  PersonalityForm({
    required this.id,
    required this.name,
    required this.hasPets,
    required this.coexistingPersonality,
    required this.budget,
    required this.houseType,
    required this.changeFrequency,
    required this.timeAvailability,
    required this.activityLevel,
  });

  /// Constructs a new instance of the [PersonalityForm] class from a list of integers and the name and ID of the person filling out the form.
  ///
  /// The [values], [name], and [id] parameters must not be null.
  ///
  /// The returned [PersonalityForm] instance will have its fields populated with the values from the [values] parameter. If a value is not present in the [values] list, the corresponding field will be initialized to a default value.
  PersonalityForm.fromList(List<int> values, this.name, this.id)
      : hasPets = values[0] == 0,
        coexistingPersonality = Personalities.values[values[1]].toString(),
        budget = Budget.values[values[2]].toString(),
        houseType = HouseType.values[values[3]].toString(),
        changeFrequency = HouseChangeFrequency.values[values[4]].toString(),
        timeAvailability = TimeAvailability.values[values[5]].toString(),
        activityLevel = ActivityLevel.values[values[6]].toString();

  /// Constructs a new instance of the [PersonalityForm] class from a [Map] of key-value pairs.
  ///
  /// The [json] parameter must not be null.
  ///
  /// The returned [PersonalityForm] instance will have its fields populated with the values from the [json] parameter. If a key is not present in the [json], the corresponding field will be initialized to a default value.
  factory PersonalityForm.fromMap(Map<String, dynamic> json) => PersonalityForm(
      name: json['backdrop_path'],
      hasPets: json['hasPets'],
      coexistingPersonality: json['overview'],
      budget: json['budget'],
      houseType: json['house_type'],
      changeFrequency: json['change_frequency'],
      timeAvailability: json['time_availablity'],
      activityLevel: json['activity_level'],
      id: '');

  /// Constructs a new empty instance of the [PersonalityForm] class.
  PersonalityForm.empty()
      : name = '',
        id = '',
        hasPets = false,
        coexistingPersonality = Personalities.other.toString(),
        budget = Budget.notDefined.toString(),
        houseType = HouseType.notDefined.toString(),
        changeFrequency = HouseChangeFrequency.notDefined.toString(),
        timeAvailability = TimeAvailability.notDefined.toString(),
        activityLevel = ActivityLevel.notDefined.toString();

  /// Sets the name of the person filling out the form.
  set setName(String name) {
    this.name = name;
  }

  /// Sets whether the person filling out the form has other pets or not.
  set setHasPets(bool hasPets) {
    this.hasPets = hasPets;
  }

  /// Sets the personality trait of the existing pet(s) of the person filling out the form.
  set setCoexistingPersonality(Personalities coexistingPersonality) {
    this.coexistingPersonality = coexistingPersonality.toString();
  }

  /// Sets the budget range of the person filling out the form.
  set setBudget(Budget budget) {
    this.budget = budget.toString();
  }

  /// Sets the type of house where the pet will live.
  set setHouseType(HouseType houseType) {
    this.houseType = houseType.toString();
  }

  /// Sets the frequency of house changes for the pet owner.
  set setChangeFrequency(HouseChangeFrequency changeFrequency) {
    this.changeFrequency = changeFrequency.toString();
  }

  /// Sets the time availability of the pet owner.
  set setTimeAvailability(TimeAvailability timeAvailability) {
    this.timeAvailability = timeAvailability.toString();
  }

  /// Sets the activity level of the pet.
  set setActivityLevel(ActivityLevel activityLevel) {
    this.activityLevel = activityLevel.toString();
  }
}

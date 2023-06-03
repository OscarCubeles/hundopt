enum Budget { lessThan50, between50And150, moreThan150, notDefined }

enum Personalities {
  sociable,
  independent,
  territorial,
  shy,
  aggressive,
  other
}

enum HouseType { smallFlat, bigFlat, smallHouse, bigHouse, notDefined }

enum HouseChangeFrequency { lessThanTwoYears, fiveYears, never, notDefined }

enum TimeAvailability {
  lessThanTwo,
  betweenTwoAndFour,
  moreThanFour,
  notDefined
}

enum ActivityLevel { notActive, active, veryActive, notDefined }

class PersonalityForm {
  String? id;
  String name;
  bool hasPets;
  String coexistingPersonality;
  String budget;
  String houseType;
  String changeFrequency;
  String timeAvailability;
  String activityLevel;

  PersonalityForm(
      {required this.id,
      required this.name,
      required this.hasPets,
      required this.coexistingPersonality,
      required this.budget,
      required this.houseType,
      required this.changeFrequency,
      required this.timeAvailability,
      required this.activityLevel});

  PersonalityForm.fromList(List<int> values, this.name, this.id)
      : hasPets = values[0] == 0,
        coexistingPersonality = Personalities.values[values[1]].toString(),
        budget = Budget.values[values[2]].toString(),
        houseType = HouseType.values[values[3]].toString(),
        changeFrequency = HouseChangeFrequency.values[values[4]].toString(),
        timeAvailability = TimeAvailability.values[values[5]].toString(),
        activityLevel = ActivityLevel.values[values[6]].toString();

  factory PersonalityForm.fromMap(Map<String, dynamic> json) => PersonalityForm(
      name: json['backdrop_path'],
      hasPets: json['hasPets'],
      coexistingPersonality: json['overview'],
      budget: json['budget'],
      houseType: json['house_type'],
      changeFrequency: json['change_frequency'],
      timeAvailability: json['time_availablity'],
      activityLevel: json['activity_level'], id: '');

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

  set setName(String name) {
    this.name = name;
  }

  set setHasPets(bool hasPets) {
    this.hasPets = hasPets;
  }

  set setCoexistingPersonality(Personalities coexistingPersonality) {
    this.coexistingPersonality = coexistingPersonality.toString();
  }

  set setBudget(Budget budget) {
    this.budget = budget.toString();
  }

  set setHouseType(HouseType houseType) {
    this.houseType = houseType.toString();
  }

  set setChangeFrequency(HouseChangeFrequency changeFrequency) {
    this.changeFrequency = changeFrequency.toString();
  }

  set setTimeAvailability(TimeAvailability timeAvailability) {
    this.timeAvailability = timeAvailability.toString();
  }

  set setActivityLevel(ActivityLevel activityLevel) {
    this.activityLevel = activityLevel.toString();
  }
}

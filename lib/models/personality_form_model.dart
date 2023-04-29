enum MoneyRange { lessThan50, between50And150, moreThan150, notDefined }

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

enum TimeAvailability { lessThanTwo, betweenTwoAndFour, moreThanFour, notDefined }

enum ActivityLevel { notActive, active, veryActive,notDefined }

class PersonalityForm {
  String name;
  bool hasPets;
  bool coexistsWithDog;
  Personalities coexistingPersonality;
  MoneyRange budget;
  HouseType houseType;
  HouseChangeFrequency changeFrequency;
  TimeAvailability timeAvailability;
  ActivityLevel activityLevel;

  PersonalityForm(
      { required this.name,
      required this.hasPets,
      required this.coexistsWithDog,
      required this.coexistingPersonality,
      required this.budget,
      required this.houseType,
      required this.changeFrequency,
      required this.timeAvailability,
      required this.activityLevel});


  factory PersonalityForm.fromMap(Map<String, dynamic> json) => PersonalityForm(
      name: json['backdrop_path'],
      hasPets: json['hasPets'],
      coexistsWithDog: json['original_title'],
      coexistingPersonality: json['overview'],
      budget: json['budget'],
      houseType: json['house_type'],
      changeFrequency: json['change_frequency'],
      timeAvailability: json['time_availablity'],
      activityLevel: json['activity_level']);


  PersonalityForm.empty()
      : name = '',
        hasPets = false,
        coexistsWithDog = false,
        coexistingPersonality = Personalities.other,
        budget = MoneyRange.notDefined,
        houseType = HouseType.notDefined,
        changeFrequency = HouseChangeFrequency.notDefined,
        timeAvailability = TimeAvailability.notDefined,
        activityLevel = ActivityLevel.notDefined;

  set setName(String name) {
    this.name = name;
  }

  set setHasPets(bool hasPets) {
    this.hasPets = hasPets;
  }

  set setCoexistsWithDog(bool coexistsWithDog) {
    this.coexistsWithDog = coexistsWithDog;
  }

  set setCoexistingPersonality(Personalities coexistingPersonality) {
    this.coexistingPersonality = coexistingPersonality;
  }

  set setBudget(MoneyRange budget) {
    this.budget = budget;
  }

  set setHouseType(HouseType houseType) {
    this.houseType = houseType;
  }

  set setChangeFrequency(HouseChangeFrequency changeFrequency) {
    this.changeFrequency = changeFrequency;
  }

  set setTimeAvailability(TimeAvailability timeAvailability) {
    this.timeAvailability = timeAvailability;
  }

  set setActivityLevel(ActivityLevel activityLevel) {
    this.activityLevel = activityLevel;
  }

}

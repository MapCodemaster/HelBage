enum MalaysiaState {
  Johor,
  Kedah,
  Kelantan,
  Kuala_Lumpur,
  Malacca,
  Negeri_Sembilan,
  Pahang,
  Perak,
  Perlis,
  Sabah,
  Sarawak,
  Selangor;

  String getString() {
    switch (this.name) {
      case "Kuala_Lumpur":
        return "Kuala Lumpur";
      case "Negeri_Sembilan":
        return "Negeri Sembilan";
      default:
        return this.name;
    }
  }
}

MalaysiaState getState(String state) {
  switch (state) {
    case "Johor":
      return MalaysiaState.Johor;
    case "Kedah":
      return MalaysiaState.Kedah;
    case "Pahang":
      return MalaysiaState.Pahang;
    case "Kelatan":
      return MalaysiaState.Kelantan;
    case "Kuala Lumpur":
      return MalaysiaState.Kuala_Lumpur;
    case "Malacca":
      return MalaysiaState.Malacca;
    case "Negeri Sembilan":
      return MalaysiaState.Negeri_Sembilan;
    case "Perak":
      return MalaysiaState.Perak;
    case "Perlis":
      return MalaysiaState.Perlis;
    case "Sabah":
      return MalaysiaState.Sabah;
    case "Sarawak":
      return MalaysiaState.Sarawak;
    case "Selangor":
      return MalaysiaState.Selangor;
    default:
      return MalaysiaState.Johor;
  }
}

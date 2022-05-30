enum MalaysiaState
{
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

  String getString()
    {
      
    switch(this.name)
    {
      case "Kuala_Lumpur":return "Kuala Lumpur";
      case "Negeri_Sembilan":return "Negeri Sembilan";
      default : return this.name;
    }
    }
}
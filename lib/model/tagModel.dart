class tagModel
{
  String name;
  int? quantity;
  tagModel({required this.name});
  tagModel.withQuantity({required this.name,required this.quantity});
  @override
  String toString()
  {
    return this.name.toUpperCase();
  }
}
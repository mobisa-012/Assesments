class ItemsData {
  final String name;
  final String price;
  final String description;
  final String type;
  final String brand;
  final String supplier;
  final String quantity;
  final String wareHouse;
  final String date;

  ItemsData({
    required this.name,
    required this.price,
    required this.brand,
    required this.date,
    required this.description,
    required this.quantity,
    required this.supplier,
    required this.type,
    required this.wareHouse
  });
  Map<String, dynamic> toJson() {
    return {
      date: 'date',
      name: 'name',
      price: 'price',
      description: 'description',
      supplier: 'supplier',
      brand: 'brand',
      type: 'type',
      wareHouse: 'wareHouse',
      quantity: 'quantity'
    };
  }
}
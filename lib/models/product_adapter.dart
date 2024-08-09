import 'package:hive/hive.dart';
import 'product_model.dart'; // Ensure this path is correct

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final typeId = 0; // This should match the typeId used in Product class

  @override
  Product read(BinaryReader reader) {
    return Product(
      productName: reader.readString(),
      uniqueId: reader.readString(),
      purchasePrice: reader.readDouble(),
      salePrice: reader.readDouble(),
      quantity: reader.readInt(),
      inStock: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.writeString(obj.productName);
    writer.writeString(obj.uniqueId);
    writer.writeDouble(obj.purchasePrice);
    writer.writeDouble(obj.salePrice);
    writer.writeInt(obj.quantity);
    writer.writeBool(obj.inStock);
  }
}

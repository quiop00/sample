import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mid_term/models/product.dart';

class FirebaseService {
  final CollectionReference productCollection = FirebaseFirestore.instance
      .collection('products');

  // Thêm sản phẩm
  Future<void> addProduct(Product product) async {
    try {
      DocumentReference docRef = productCollection.doc(); // Tạo document ID tự động
      String id = docRef.id;
      product = product.copyWith(id: id);
      await docRef.set(product.toJson());
      print("Thêm sản phẩm thành công!");
    } catch (e) {
      print("Lỗi khi thêm sản phẩm: $e");
    }
  }

  // Tải ảnh lên Firebase Storage
  Future<String> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child(
        'products/$fileName',
      );
      UploadTask uploadTask = storageRef.putFile(imageFile);
      await uploadTask;
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Lỗi khi tải ảnh lên: $e");
      return '';
    }
  }

  // Lấy danh sách sản phẩm
  Stream<List<Product>> getProducts() {
    return productCollection
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Product.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();
        });
  }

  // Cập nhật sản phẩm
  Future<void> updateProduct(Product product) async {
    try {
      await productCollection.doc(product.id).update(product.toJson());
      print("Cập nhật sản phẩm thành công!");
    } catch (e) {
      print("Lỗi khi cập nhật sản phẩm: $e");
    }
  }

  // Xóa sản phẩm
  Future<void> deleteProduct(String id) async {
    try {
      await productCollection.doc(id).delete();
      print("Xóa sản phẩm thành công!");
    } catch (e) {
      print("Lỗi khi xóa sản phẩm: $e");
    }
  }
}

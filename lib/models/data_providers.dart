import 'package:medical_app/models/doctor.dart';
import 'package:medical_app/models/m_provider.dart';
import 'package:medical_app/models/order.dart';
import 'package:medical_app/models/stock.dart';
import 'package:medical_app/models/user.dart';

class OrderProvider extends  SDProvider<Order>{

  static Order orderFromJson(json) {
    return Order.fromJson(json);
    // Order.rand();
  }
  Order order = Order.rand();
}

class DoctorProvider extends  SDProvider<Doctor>{

  static Doctor docotorFromJson(json) {
    return Doctor.fromJson(json);
    // Doctor.rand();
  }
  Doctor doctor = Doctor.rand();
}

class StockProvider extends SDProvider<Stock> {
  
  static Stock stockFromJson(json) {
    return Stock.fromJson(json);
    // Stock.rand();
  }
  Stock stock = Stock.rand();
}

class UserProvider extends SDProvider<User> {

  static User userFromJson(json) {
    return User.fromJson(json);
    // User.rand();
  }
  User user = User.rand();
}

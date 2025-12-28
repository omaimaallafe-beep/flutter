import 'package:flutter/material.dart'; // استيراد مكتبة Flutter الأساسية
import '../widgets/trip_item.dart'; // استيراد Widget لعرض كل رحلة
import '../models/trip.dart'; // استيراد نموذج البيانات Trip

// شاشة عرض الرحلات المفضلة
class FavoritesScreen extends StatelessWidget {
  final List<Trip> favoriteTrips; // قائمة الرحلات المفضلة

  FavoritesScreen(this.favoriteTrips); // استقبال قائمة الرحلات عند إنشاء الشاشة

  @override
  Widget build(BuildContext context) {
    if (favoriteTrips.isEmpty) { // إذا كانت القائمة فارغة
      return Center( // وضع النص في وسط الشاشة
        child: Text('ليس لديك أي رحلة في قائمة المفضلة'), // رسالة للمستخدم
      );
    } else { // إذا كانت القائمة تحتوي على رحلات
      return ListView.builder( // إنشاء قائمة تمرير عمودية
        itemBuilder: (ctx, index) { // دالة لإنشاء كل عنصر في القائمة
          return TripItem(
            id: favoriteTrips[index].id, // معرف الرحلة
            title: favoriteTrips[index].title, // عنوان الرحلة
            imageUrl: favoriteTrips[index].imageUrl, // صورة الرحلة
            duration: favoriteTrips[index].duration, // مدة الرحلة
            tripType: favoriteTrips[index].tripType, // نوع الرحلة
            season: favoriteTrips[index].season, // موسم الرحلة
          );
        },
        itemCount: favoriteTrips.length, // عدد العناصر في القائمة
      );
    }
  }
}

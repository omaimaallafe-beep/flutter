import 'package:flutter/material.dart'; // استيراد مكتبة Flutter الأساسية
import '../models/trip.dart'; // استيراد موديل الرحلة Trip
import '../widgets/trip_item.dart'; // استيراد ويدجت عرض الرحلة TripItem

class CategoryTripsScreen extends StatefulWidget { // تعريف شاشة قسم الرحلات (قابلة للتغيير)
  static const screenRoute = '/category-trips'; // اسم المسار (Route) لهذه الشاشة

  final List<Trip> availableTrips; // قائمة الرحلات المتاحة القادمة من الشاشة السابقة

  CategoryTripsScreen(this.availableTrips); // constructor لاستقبال الرحلات

  @override
  _CategoryTripsScreenState createState() => _CategoryTripsScreenState(); // ربط الشاشة بالـState
}

class _CategoryTripsScreenState extends State<CategoryTripsScreen> { // تعريف حالة الشاشة
  late String categoryTitle; // اسم القسم (مثلاً: جبال)
  late List<Trip> displayTrips; // الرحلات التي ستُعرض في هذا القسم
  var _loadedInitData = false; // متغير لمنع تحميل البيانات أكثر من مرة

  @override
  void didChangeDependencies() { // دالة تُستدعى عند توفر context
    if (!_loadedInitData) { // التأكد أن الكود يُنفذ مرة واحدة فقط
      final routeArgument =
      ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      // جلب البيانات المرسلة من الشاشة السابقة

      final categoryId = routeArgument['id']; // استخراج id القسم
      categoryTitle = routeArgument['title']!; // استخراج عنوان القسم

      displayTrips = widget.availableTrips.where((trip) {
        return trip.categories.contains(categoryId); // تصفية الرحلات حسب القسم
      }).toList(); // تحويل النتائج إلى List

      _loadedInitData = true; // تحديد أن البيانات تم تحميلها
    }
    super.didChangeDependencies(); // استدعاء الدالة الأصلية
  }

  @override
  Widget build(BuildContext context) { // دالة بناء واجهة المستخدم
    return Scaffold( // الهيكل الأساسي للشاشة
      appBar: AppBar( // شريط أعلى الشاشة
        title: Text(
          categoryTitle, // عرض اسم القسم في العنوان
          style: Theme.of(context).textTheme.headlineMedium, // تنسيق النص
        ),
        backgroundColor: Colors.blue, // لون خلفية AppBar
        iconTheme: const IconThemeData(color: Colors.white), // لون سهم الرجوع
      ),

      body: ListView.builder( // قائمة لعرض الرحلات
        itemBuilder: (ctx, index) { // بناء كل عنصر في القائمة
          return TripItem( // ويدجت عرض الرحلة
            id: displayTrips[index].id, // معرف الرحلة
            title: displayTrips[index].title, // عنوان الرحلة
            imageUrl: displayTrips[index].imageUrl, // صورة الرحلة
            duration: displayTrips[index].duration, // مدة الرحلة
            tripType: displayTrips[index].tripType, // نوع الرحلة
            season: displayTrips[index].season, // موسم الرحلة
          );
        },
        itemCount: displayTrips.length, // عدد عناصر القائمة
      ),
    );
  }
}

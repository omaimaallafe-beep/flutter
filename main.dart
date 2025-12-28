import 'package:flutter/material.dart'; // استيراد مكتبة Flutter الأساسية
import '../screens/category_trip_screen.dart'; // شاشة الرحلات حسب التصنيف
import '../screens/trip_detail_screen.dart'; // شاشة تفاصيل الرحلة
import 'screens/filters_screen.dart'; // شاشة الفلترة
import 'screens/tabs_screen.dart'; // شاشة التبويبات
import 'package:flutter_localizations/flutter_localizations.dart'; // دعم اللغة العربية
import 'app_data.dart'; // ملف بيانات الرحلات
import 'models/trip.dart'; // موديل الرحلة
import 'screens/splash_screen.dart'; // شاشة البداية
import 'screens/aboutUs.dart'; // شاشة حول التطبيق

void main() { // نقطة بداية تشغيل التطبيق
  runApp(MyApp()); // تشغيل التطبيق
}

class MyApp extends StatefulWidget { // الكلاس الرئيسي للتطبيق
  @override
  _MyAppState createState() => _MyAppState(); // ربط الكلاس بالحالة
}

class _MyAppState extends State<MyApp> { // كلاس الحالة

  Map<String, bool> _filters = { // خريطة إعدادات الفلترة
    'summer': false, // فلترة الرحلات الصيفية
    'winter': false, // فلترة الرحلات الشتوية
    'family': false, // فلترة رحلات العائلات
  };

  List<Trip> _availableTrips = Trips_data; // الرحلات المتاحة حسب الفلترة
  List<Trip> _favoriteTrips = []; // الرحلات المفضلة

  void _changeFilters(Map<String, bool> filterData) { // دالة تغيير الفلاتر
    setState(() { // تحديث الواجهة
      _filters = filterData; // تحديث القيم
      _availableTrips = Trips_data.where((trip) { // فلترة الرحلات
        if (_filters['summer'] == true && trip.isInSummer != true) return false; // شرط الصيف
        if (_filters['winter'] == true && trip.isInWinter != true) return false; // شرط الشتاء
        if (_filters['family'] == true && trip.isForFamilies != true) return false; // شرط العائلات
        return true; // عرض الرحلة
      }).toList(); // تحويل النتيجة إلى List
    });
  }

  void _manageFavorite(String tripId) { // إضافة أو حذف من المفضلة
    final existingIndex = _favoriteTrips.indexWhere((trip) => trip.id == tripId); // البحث عن الرحلة
    if (existingIndex >= 0) { // إذا موجودة
      setState(() {
        _favoriteTrips.removeAt(existingIndex); // حذفها
      });
    } else { // إذا مش موجودة
      setState(() {
        _favoriteTrips.add(Trips_data.firstWhere((trip) => trip.id == tripId)); // إضافتها
      });
    }
  }


  // هده نقدر نغير بيها النجمة
  bool _isFovarite(String id) { // التحقق هل الرحلة مفضلة
    return _favoriteTrips.any((trip) => trip.id == id); // true إذا موجودة
  }

  @override
  Widget build(BuildContext context) { // بناء الواجهة
    return MaterialApp( // الجذر الأساسي للتطبيق
      localizationsDelegates: [ // خاصية لتفعيل دعم اللغات في التطبيق
        GlobalMaterialLocalizations.delegate, // يدعم ترجمة النصوص والمكونات الخاصة بـ Material Widgets
        GlobalWidgetsLocalizations.delegate, // يدعم ترجمة النصوص العامة في الواجهات
        GlobalCupertinoLocalizations.delegate, // يدعم ترجمة مكونات iOS (Cupertino Widgets)
      ],

      supportedLocales: [
        const Locale('ar', 'AE'), // اللغة العربية
      ],
      title: 'Travel App', // اسم التطبيق
      debugShowCheckedModeBanner: false, // إخفاء شريط Debug
      theme: ThemeData( // إعداد الثيم
        primarySwatch: Colors.blue, // اللون الأساسي
        fontFamily: 'ElMessiri', // الخط
        textTheme: ThemeData.light().textTheme.copyWith(
          headlineSmall: TextStyle(color: Colors.blue,fontSize: 24,fontFamily: 'ElMessiri',fontWeight: FontWeight.bold), // عنوان صغير
          headlineMedium: TextStyle(color: Colors.white,fontSize: 26,fontFamily: 'ElMessiri',fontWeight: FontWeight.bold), // عنوان متوسط
        ),
      ),
      initialRoute: '/splash', // أول شاشة
      routes: { // مسارات التنقل
        '/splash': (ctx) => SplashScreen(), // شاشة البداية
        '/': (ctx) => TabsScreen(_favoriteTrips), // الشاشة الرئيسية
        CategoryTripsScreen.screenRoute: (ctx) => CategoryTripsScreen(_availableTrips), // رحلات التصنيف
        TripDetailScreen.screenRoute: (ctx) => TripDetailScreen(_manageFavorite, _isFovarite), // تفاصيل الرحلة
        FiltersScreen.screenRoute: (ctx) => FiltersScreen(_filters, _changeFilters), // الفلترة
        AboutUsScreen.screenRoute: (ctx) => AboutUsScreen(), // حول التطبيق
      },
    );
  }
}

import 'package:flutter/material.dart'; // استيراد مكتبة Flutter الأساسية لعناصر Material Design
import '../widgets/app_drawer.dart';   // استيراد Drawer مخصص للشاشة الجانبية
import '../screens/catogries_screen.dart'; // استيراد شاشة التصنيفات
import './favorites_screen.dart';     // استيراد شاشة المفضلة
import '../models/trip.dart';         // استيراد نموذج البيانات Trip
// import '../widgets/app_drawer.dart'; // يمكن حذف هذا التكرار

class TabsScreen extends StatefulWidget { // تعريف شاشة Stateful لأنها تتغير
  final List<Trip> favoriteTrips; // قائمة الرحلات المفضلة القادمة من الشاشة السابقة

  const TabsScreen(this.favoriteTrips, {super.key}); // الكونستركتور لتخزين المفضلات

  @override
  _TabsScreenState createState() => _TabsScreenState(); // إنشاء الحالة المرتبطة بالشاشة
}

class _TabsScreenState extends State<TabsScreen> { // تعريف كلاس الحالة
  int _selectedScreenIndex = 0; // رقم الشاشة الحالية (0: التصنيفات، 1: المفضلة)
  late List<Map<String, dynamic>> _screens; // قائمة تحوي كل شاشة وعنوانها

  @override
  void initState() { // تنفذ مرة واحدة عند إنشاء الشاشة
    _screens = [
      {
        'Screen': CategoriesScreen(), // شاشة التصنيفات
        'Title': 'تصنيفات الرحلات',   // عنوان AppBar للشاشة
      },
      {
        'Screen': FavoritesScreen(widget.favoriteTrips), // شاشة المفضلة
        'Title': 'الرحلات المفضلة',  // عنوان AppBar للشاشة
      },
    ];
    super.initState(); // استدعاء initState() للأب
  }

  void _selectScreen(int index) { // تنفذ عند الضغط على أيقونة في BottomNavigationBar
    setState(() {
      _selectedScreenIndex = index; // تحديث الشاشة الحالية وإعادة البناء
    });
  }

  @override
  Widget build(BuildContext context) { // بناء واجهة المستخدم
    return Scaffold( // الهيكل الأساسي للشاشة
      appBar: AppBar( // شريط أعلى الشاشة
        title: Text(
          _screens[_selectedScreenIndex]['Title'], // عنوان حسب الشاشة
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: false, // النص بجانب الأيقونة
        elevation: 0, // إزالة الظل
        backgroundColor: Colors.blue, // لون الخلفية
        iconTheme: const IconThemeData(color: Colors.white), // لون الأيقونات أبيض
      ),
      drawer: AppDrawer(), // القائمة الجانبية
      body: _screens[_selectedScreenIndex]['Screen'] as Widget, // عرض الشاشة الحالية
      bottomNavigationBar: BottomNavigationBar( // شريط التنقل السفلي
        onTap: _selectScreen, // عند الضغط على أيقونة
        backgroundColor: Colors.blue, // لون الخلفية
        selectedItemColor: Colors.yellow, // اللون عند الاختيار
        unselectedItemColor: Colors.white, // اللون عند عدم الاختيار
        currentIndex: _selectedScreenIndex, // الشاشة الحالية
        type: BottomNavigationBarType.fixed, // شريط ثابت
        items: [ // العناصر
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), // أيقونة التصنيفات
            label: 'التصنيفات', // اسم الأيقونة
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star), // أيقونة المفضلة
            label: 'المفضلة', // اسم الأيقونة
          ),
        ],
      ),
    );
  }
}

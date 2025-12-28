import 'package:flutter/material.dart'; // استيراد مكتبة Flutter الأساسية
import '../app_data.dart'; // استيراد بيانات التصنيفات
import '../widgets/category_item.dart'; // استيراد Widget لكل تصنيف

// شاشة التصنيفات الرئيسية
class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(10), // مسافة داخلية حول الشبكة
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // أقصى عرض لكل عنصر في الشبكة
        childAspectRatio: 7 / 8, // نسبة العرض إلى الارتفاع لكل عنصر
        mainAxisSpacing: 10, // المسافة الرأسية بين الصفوف
        crossAxisSpacing: 10, // المسافة الأفقية بين الأعمدة
      ),
      //هالسطرين يعني: "خذ كل عنصر في categories_data، حوّله إلى CategoryItem، ثم ضعهم كلهم في شبكة GridView."
      children: categories_data.map(
            (categoryData) => CategoryItem(
          categoryData.id,       // معرف التصنيف لاستخدامه لاحقًا
          categoryData.title,    // اسم التصنيف للعرض
          categoryData.imageUrl, // صورة التصنيف
        ),
      ).toList(), // تحويل النتائج إلى قائمة Widgets
    );
  }
}

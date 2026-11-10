part of '../categories_screen.dart';

class _CategoriesCard extends StatelessWidget {
  const _CategoriesCard({required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppPages.productsScreen,
          arguments: {
            'title': category.localizedName,
            'categoryId': category.id,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: CustomNetworkImage(url: category.image, iconSize: 48),
            ),
            const SizedBox(height: 12),
            Text(
              category.localizedName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

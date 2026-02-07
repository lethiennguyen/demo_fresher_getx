part of 'home_page.dart';

Widget buildHomeBody(HomeController controller) {
  return Container(
    color: const Color(0xFFF5F5F5), // Màu nền xám nhạt để nổi bật Card trắng
    child: Obx(() => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: 1,
          itemBuilder: (context, index) {
            return _buildProductCard();
          },
        )),
  );
}

Widget buildIconButton(
  String icon,
  VoidCallback onTap, {
  double size = 30,
  EdgeInsets padding = const EdgeInsets.all(8),
}) {
  return IconButton(
    onPressed: onTap,
    padding: padding,
    constraints: const BoxConstraints(),
    icon: SvgPicture.asset(
      icon,
      width: size,
      height: size,
    ),
  );
}

Widget _buildProductCard() {
  return UtilWidget.baseCard(
    borderRadius: AppDimens.borderRadius16,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 8,
        spreadRadius: 1,
        offset: const Offset(0, 2),
      ),
    ],
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Ảnh Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/42/336623/realme-14-xam-6-638878505488627300-750x500.jpg",
              width: 80,
              height: 80,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
                child:
                    const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
          ),
          sdsSBWidth12,

          // 2. Thông tin chi tiết
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextUtils(
                  text: "dsvdsv",
                  availableStyle: StyleEnum.t16Bold,
                  maxLine: 1,
                ),
                sdsSBHeight4,
                TextUtils(
                  text: "dsvdsv",
                  availableStyle: StyleEnum.t13Regular,
                  color: AppColors.grey,
                ),
                sdsSBHeight8,
                TextUtils(
                  text: "dsvdsv",
                  availableStyle: StyleEnum.t16Bold,
                ),
                TextUtils(
                  text: "Kho: dsvdsv",
                  availableStyle: StyleEnum.t14Bold,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    ),
  );
}

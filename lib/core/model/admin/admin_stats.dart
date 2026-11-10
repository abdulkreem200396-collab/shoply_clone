class AdminStats {
  const AdminStats({
    required this.productsCount,
    required this.ordersCount,
    required this.pendingCount,
    required this.revenue,
  });

  final int productsCount;
  final int ordersCount;
  final int pendingCount;
  final double revenue;
}

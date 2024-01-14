import 'package:flutter/material.dart';
import 'package:sharing_world2/common/widgets/bottom_bar.dart';
import 'package:sharing_world2/common/widgets/loader.dart';
import 'package:sharing_world2/features/admin/models/sales.dart';
import 'package:sharing_world2/features/admin/services/admin_services.dart';
import 'package:sharing_world2/features/admin/widgets/category_products_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              const SizedBox(height: 20),
              Text(
                '총 수입 : $totalSales원',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(
                  seriesList: [
                    charts.Series(
                      id: 'Sales',
                      data: earnings!,
                      domainFn: (Sales sales, _) => sales.label,
                      measureFn: (Sales sales, _) => sales.earning,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the other page here
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                      const BottomBar(), // Replace 'OtherPage' with the actual page you want to navigate to
                    ),
                  );
                },
                child: const Text('상품 구매 페이지로 이동'),
              ),
            ],
          );
  }
}

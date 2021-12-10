import 'package:flutter/material.dart';
import 'package:machine_test/controller/api_controller.dart';
import 'package:machine_test/services/fetch.dart';
import 'package:machine_test/view/widgets/carousal_view.dart';
import 'package:machine_test/view/widgets/grid_image_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String route = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<ApiController>().setApiData(
          carousal: context.read<ApiService>().getImagesFromApi(count: "5"),
          grid: context.read<ApiService>().getImagesFromApi(count: "30"));
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiController = Provider.of<ApiController>(context);
    final apiService = Provider.of<ApiService>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cute Dogs",
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async => apiController.setApiData(
              carousal: apiService.getImagesFromApi(count: "5"),
              grid: apiService.getImagesFromApi(count: "30")),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                FutureBuilder(
                  future: apiController.carousalData,
                  builder: (context, snap) {
                    if (snap.hasData) {
                      List<String> data = snap.data as List<String>;
                      return CarousalView(
                        images: data,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(
                  height: 8.0,
                ),
                FutureBuilder(
                  future: apiController.gridData,
                  builder: (context, snap) {
                    if (snap.hasData) {
                      List<String> data = snap.data as List<String>;
                      return GridImageView(
                        images: data,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

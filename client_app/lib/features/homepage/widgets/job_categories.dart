import 'package:client_app/features/homepage/models/category.dart';
import 'package:client_app/features/homepage/models/pagination.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as pro;
import 'package:provider/provider.dart';
import '../../../providers/category_provider.dart';
import '../services/job_post_notifier.dart';

class JobCategories extends pro.ConsumerWidget {
  const JobCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, pro.WidgetRef ref) {
    return Column(
      children: [
        const Text(
          "Categories",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: _categoriesList(ref),
        )
      ],
    );
  }
}

Widget _categoriesList(pro.WidgetRef ref) {
  final categories = ref.watch(categoriesProvider(
    PaginationModel(
      page: 1,
      pageSize: 10,
    ),
  ));

  return categories.when(
    data: (list) {
      return _buildCategoryList(list!, ref);
    },
    error: (_, __) => const Center(
      child: Text("ERR"),
    ),
    loading: () => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget _buildCategoryList(
  List<Category> categories,
  pro.WidgetRef ref,
) {
  return Container(
    height: 100,
    alignment: Alignment.centerLeft,
    child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var jobprovider = Provider.of<JobPostNotifier>(context, listen: true);
          var data = categories[index];
          return GestureDetector(
            onTap: () {
              jobprovider.job.tags = data.categoryName;
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: Image.network(
                      data.fullImagePath,
                      height: 50,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data.categoryName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }),
  );
}

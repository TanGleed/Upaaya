import 'package:client_app/features/homepage/models/category.dart';
import 'package:client_app/features/homepage/models/pagination.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/category_provider.dart';

class JobCategories extends ConsumerWidget {
  const JobCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Categories",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _categoriesList(ref),
        )
      ],
    );
  }
}

Widget _categoriesList(WidgetRef ref) {
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

Widget _buildCategoryList(List<Category> categories, WidgetRef ref) {
  return Container(
    height: 100,
    alignment: Alignment.centerLeft,
    child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var data = categories[index];
          return GestureDetector(
            onTap: () {},
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
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 13,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }),
  );
}

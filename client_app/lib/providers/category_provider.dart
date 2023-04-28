//get categories
import 'package:client_app/features/auth/services/authservices.dart';
import 'package:client_app/features/homepage/models/pagination.dart';
import 'package:client_app/features/homepage/services/homepageServices.dart';
import 'package:client_app/providers/UserProvider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../api_service.dart/apiService.dart';
import '../features/homepage/models/category.dart';

final categoriesProvider =
    FutureProvider.family<List<Category>?, PaginationModel>(
  (ref, paginationModel) {
    final apiRepository = ref.watch(homepageAPI);
    return apiRepository.getCategories(
      paginationModel.page,
      paginationModel.pageSize,
    );
  },
);

import './models/pagination.dart';
import './models/job.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api_service.dart/apiService.dart';

final jobProvider = FutureProvider.family<List<Job>?, PaginationModel>(
  (ref, paginationModel) {
    final apiRepository = ref.watch(apiService);

    return apiRepository.getJobs(
      paginationModel.page,
      paginationModel.pageSize,
    );
  },
);

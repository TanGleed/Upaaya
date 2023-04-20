import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worker_app/pages/desc_page.dart';
import 'package:worker_app/widgets/nav_drawer_wid.dart';

import '../models/job.dart';
import '../models/pagination.dart';
import '../provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
      ),
      drawer: NavigationDrawerWidget(),
      body: _buildJobList(ref),
    );
  }

  Widget _buildJobList(WidgetRef ref) {
    final jobs = ref.watch(jobProvider(PaginationModel(
      page: 1,
      pageSize: 10,
    )));

    return jobs.when(
      data: (list) {
        return ListView.builder(
          itemCount: list?.length,
          itemBuilder: (context, index) {
            final job = list![index];
            return Card(
              color: Colors.grey[200],
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DescPage(job: job)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 27.5,
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.green,
                        backgroundImage: NetworkImage(job.media),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              job.id,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              job.location,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              job.description,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text('Error')),
    );
  }
}

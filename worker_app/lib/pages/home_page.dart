import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worker_app/models/job.dart';
import 'package:worker_app/pages/desc_page.dart';
import 'package:worker_app/widgets/nav_drawer_wid.dart';
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
      body: _jobList(ref),
    );
  }

  Widget _jobList(WidgetRef ref) {
    final jobs = ref.watch(jobProvider(PaginationModel(
      page: 1,
      pageSize: 10,
    )));
    print(jobs);
    return jobs.when(
      data: (list) {
        return _buildJobList(list!, ref);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text('Error')),
    );
  }

  ListView _buildJobList(List<Job> list, WidgetRef ref) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final job = list[index];
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
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 55,
                        height: 55,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.green,
                        ),
                      ),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            job.id,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            job.location,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            job.description,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

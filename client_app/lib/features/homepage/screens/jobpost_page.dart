import 'package:client_app/features/homepage/widgets/job_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:client_app/features/homepage/services/job_post_notifier.dart';
import 'package:client_app/theme/jobpost_text_field.dart';
import 'package:client_app/features/homepage/models/jobpost/jobpost.dart';

class JobPostPage extends StatelessWidget {
  //final List<String> tagOptions = ['option1', 'option2', 'option3'];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController additionalInfoController =
      TextEditingController();

  //String? selectedTag;

  void jobposting(BuildContext context) async {
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    String location = locationController.text.trim();
    List<String> tags = tagController.text.trim().split(',');
    //String tag = selectedTag ?? '';
    String additionalInfo = additionalInfoController.text.trim();

    JobPost job = JobPost(
      title: title,
      description: description,
      location: location,
      tags: tags,
      additionalInfo: additionalInfo,
    );
    var provider = Provider.of<JobPostNotifier>(context, listen: false);
    await provider.post(job);

    if (provider.isJobPosted) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Job Posted Successfully'),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Job Posting Failed'),
        ),
      );
    }
  }

  JobPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Consumer<JobPostNotifier>(
        builder: (context, data, child) {
          return data.isLoading
              ? Center(
                  child: SpinKitThreeBounce(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: index.isEven ? Colors.red : Colors.green,
                        ),
                      );
                    },
                  ),
                )
              : ListView(children: [
                  Column(
                    children: [
                      const JobCategories(),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textController: locationController,
                        hintText: 'Location',
                        icon: Icons.location_on,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textController: titleController,
                        hintText: 'Title',
                        icon: Icons.work,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        maxLines: 5,
                        textController: descriptionController,
                        hintText: 'Description',
                        icon: Icons.description,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textController: tagController,
                        hintText: 'Tags',
                        icon: Icons.tag,
                      ),
                      // DropdownButton<String>(
                      //   hint: const Text('Select Tag'),
                      //   value: selectedTag,
                      //   onChanged: (String? value) {
                      //     selectedTag = value;
                      //   },
                      //   items: tagOptions.map((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textController: additionalInfoController,
                        hintText: 'Additional Info',
                        icon: Icons.info,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          jobposting(context);
                        },
                        child: Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 23,
                          ),
                          margin: const EdgeInsets.only(
                            left: 40,
                            right: 40,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(4, 4),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(-4, -4),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Text(
                            'Post Job',
                            style: TextStyle(
                              color: Color.fromARGB(255, 21, 93, 122),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ]);
        },
      ),
    );
  }
}

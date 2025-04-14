import 'package:car_club/core/widgets/custom_text_field.dart';
import 'package:car_club/features/home/presentation/manager/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({
    super.key,
  });
  static String id = 'SearchPage';
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? query;
  bool isSearching = false;
  var searchResult;

  @override
  Widget build(BuildContext context) {
   // final s = S.of(context);
    var size = MediaQuery.of(context).size;
    //  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: CustomTextFrom(
                label:' search...',
                hint: '',
                onChanged: (data) async {
                  
                    query = data;

                    if (data.isEmpty) {
                      searchResult = null;
                    } else {
                    searchResult=  await  BlocProvider.of<SearchCubit>(context)
                          .searchCarsByName(data);
                    }
              setState(() {
                
              });
                },
              ),
            ),
        
                 Text('s.product_not_found'),
          ],
        ),
      ),
    );
  }
}

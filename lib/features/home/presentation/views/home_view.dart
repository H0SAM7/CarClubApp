import 'package:car_club/core/widgets/custom_loading_indecator.dart';
import 'package:car_club/features/home/presentation/manager/all_products_cubit/all_products_cubit.dart';
import 'package:car_club/features/home/presentation/views/widgets/products_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String id = 'HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  TextEditingController searchController = TextEditingController();

  // Filter Options
  String? selectedBrand;
  String? selectedPriceRange;
  String? selectedColor;

  //  filter choices
  final List<String> brands = ['Toyota', 'Honda', 'Chevrolet', 'Jetour'];
  final List<String> colors = ['Black', 'White', 'Blue', 'Silver'];
  final List<String> priceRanges = [
    'Below 30,000 SAR',
    '30,000 - 50,000 SAR',
    '50,000 - 70,000 SAR',
    '70,000 - 100,000 SAR',
    'Above 100,000 SAR',
  ];

  final List<Map<String, String>> carList = [
    {
      'image': 'assets/images/toyota.jpg',
      'name': 'Corolla XLI 2022',
      'price': '57,000 SAR',
      'brand': 'Toyota',
      'color': 'White',
    },

    {
      'image': 'assets/images/Honda.jpg',
      'name': 'Honda Accord 2021',
      'price': '95,000 SAR',
      'brand': 'Honda',
      'color': 'Silver',
    },
  ];

  List<Map<String, String>> filteredCars = [];

  @override
  void initState() {
    super.initState();
    filteredCars = List.from(carList);
  }

  void filterCars() {
    setState(() {
      filteredCars =
          carList.where((car) {
            bool matchesBrand =
                selectedBrand == null || car['brand'] == selectedBrand;
            bool matchesColor =
                selectedColor == null || car['color'] == selectedColor;
            bool matchesPrice =
                selectedPriceRange == null || _isPriceInRange(car['price']!);

            return matchesBrand && matchesColor && matchesPrice;
          }).toList();
    });
  }

  bool _isPriceInRange(String price) {
    double carPrice =
        double.tryParse(price.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
    if (selectedPriceRange == 'Below 30,000 SAR') return carPrice < 30000;
    if (selectedPriceRange == '30,000 - 50,000 SAR') {
      return carPrice >= 30000 && carPrice <= 50000;
    }
    if (selectedPriceRange == '50,000 - 70,000 SAR') {
      return carPrice > 50000 && carPrice <= 70000;
    }
    if (selectedPriceRange == '70,000 - 100,000 SAR') {
      return carPrice > 70000 && carPrice <= 100000;
    }
    if (selectedPriceRange == 'Above 100,000 SAR') return carPrice > 100000;
    return true;
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Filter Cars'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildDropdownFilter('Brand', brands, selectedBrand, (value) {
                  setState(() => selectedBrand = value);
                  filterCars();
                }),
                buildDropdownFilter('Color', colors, selectedColor, (value) {
                  setState(() => selectedColor = value);
                  filterCars();
                }),
                buildDropdownFilter(
                  'Price Range',
                  priceRanges,
                  selectedPriceRange,
                  (value) {
                    setState(() => selectedPriceRange = value);
                    filterCars();
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
              ),
            ],
          ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onDelete) {
    return Chip(
      label: Text(label),
      onDeleted: () {
        onDelete(); // Remove filter
        setState(() {
          // If all filters are removed, show all cars again
          if (selectedBrand == null &&
              selectedColor == null &&
              selectedPriceRange == null) {
            filteredCars = List.from(carList);
          } else {
            filterCars(); // Otherwise, apply remaining filters
          }
        });
      },
      backgroundColor: Colors.pink[100],
      deleteIconColor: Colors.red,
    );
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double itemSpacing = size.width * 0.002;
    double childAspectRatio = (size.width / 2) / (size.height * .53);
    return BlocBuilder<AllProductsCubit, AllProductsState>(
      builder: (context, state) {
        if (state is AllProductsSuccess) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            slivers: [
              SliverToBoxAdapter(child: Divider()),
 
      SliverToBoxAdapter(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
               // onChanged: ()async{},
                decoration: InputDecoration(
                  hintText: 'Search for cars...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: _showFilterDialog, // Opens filter dialog
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
        
            // Display Selected Filters
            Wrap(
              spacing: 10,
              children: [
                if (selectedBrand != null)
                  _buildFilterChip(
                    'Brand: $selectedBrand',
                    () => setState(() => selectedBrand = null),
                  ),
                if (selectedColor != null)
                  _buildFilterChip(
                    'Color: $selectedColor',
                    () => setState(() => selectedColor = null),
                  ),
                if (selectedPriceRange != null)
                  _buildFilterChip(
                    'Price: $selectedPriceRange',
                    () => setState(() => selectedPriceRange = null),
                  ),
              ],
            ),
        
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: filteredCars.length,
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap:
            //             () => Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder:
            //                     (context) => CarPage(
            //                       carName: filteredCars[index]['name']!,
            //                       carPrice: filteredCars[index]['price']!,
            //                       carImage: filteredCars[index]['image']!,
            //                     ),
            //               ),
            //             ),
            //         child: Card(
            //           child: ListTile(
            //             leading: Image.asset(
            //               filteredCars[index]['image']!,
            //               width: 80,
            //             ),
            //             title: Text(filteredCars[index]['name']!),
            //             subtitle: Text("Price: ${filteredCars[index]['price']}"),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
              ProductsListView(
                // size: size,
  
                products: state.products,
              ),
            ],
          );
        } else if (state is AllProductsFailure) {
          return Center(child: Text('Error loading products'));
        } else {
          return const Center(child: CustomLoadingIndicator());
        }
      },
    );
  }
}

// class CustomAppBar extends StatelessWidget {
//   const CustomAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               onPressed: () {},
//               icon: Image.asset(
//                 Assets.iconsMenu,
//                 color: redColor,
//               ),
//             ),
//             Center(
//               child: Image.asset(Assets.imagesLogo),
//             ),
//             IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.person,
//                   color: redColor,
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }



Widget buildDropdownFilter(
  String title,
  List<String> items,
  String? selectedItem,
  Function(String?) onChanged,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: DropdownButtonFormField<String>(
      value: selectedItem,
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      items:
          items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
      onChanged: onChanged,
    ),
  );
}
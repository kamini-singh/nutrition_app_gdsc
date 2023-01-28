import 'package:flutter/material.dart';
import 'package:nutrition_app_gdsc/widgets/nutrition_data.dart';

class MyCardWidget extends StatelessWidget {
  bool isLoading;
  final String text;
  var composition; //map
  final List<String> nutrients;
   final String? servingSize;

  MyCardWidget({required this.text, required this.nutrients, this.composition, this.servingSize, required this.isLoading});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 380,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(
            30,
          ),
          child: isLoading ?const  Center(
          child: CircularProgressIndicator(),
          )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //text on the card
              Text(
                '$text',
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text( servingSize == null ? " " : "Serving size: $servingSize"),

              const SizedBox(
                height: 20,
              ),

              //to display the nutrition composition
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 20.0,
                  children: List.generate(
                    nutrients.length,
                    (index) {
                      return NutritionData(
                          nutrientName: nutrients[index],
                          amountPresent: composition[nutrients[index]]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

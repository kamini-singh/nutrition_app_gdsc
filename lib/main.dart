import 'package:flutter/material.dart';
import 'package:nutrition_app_gdsc/widgets/card.dart';
import 'package:nutrition_app_gdsc/services/networking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
bool isLoading = false;

//List of strings to store the nutrient names
  List<String> nutrients = [
    'Sugar',
    'Fibre',
    'Total fats',
    'Calories',
    'Protien',
    'Carbs'
  ];

 NetworkHelper networkHelper = NetworkHelper();
//map to store nutrition composition of food
  var composition = Map();
String? servingSize;
//to store text in the Textfield
  String value = " ";
//text to be displayed on the card
  String textOnCard = 'Get nutrition composition of your food';

void updateUI(dynamic nutritionData){
setState(() {
textOnCard = value;
composition['Sugar'] = nutritionData[0]['sugar_g'].toString();
composition['Fibre'] = nutritionData[0]['fiber_g'].toString();
composition['Total fats'] = nutritionData[0]['fat_total_g'].toString();
var calories = nutritionData[0]['calories'].round();
composition['Calories'] = calories.toString();
composition['Protien'] = nutritionData[0]['protein_g'].toString(); 
composition['Carbs'] = nutritionData[0]['carbohydrates_total_g'].toString();
servingSize = nutritionData[0]['serving_size_g'].toString();
});
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'Nutrition App',
                ),
              ),
              backgroundColor: Colors.red[300],
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(
                    'assets/food.jpeg',
                  ),
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.3),
                    BlendMode.modulate,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: TextField(
                      onChanged: (textentered) {
                        value = textentered;
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              color: Colors.green,
                              onPressed: () async{
                              setState(() {
                                isLoading = true;
                              });
                              var nutritionData = await networkHelper.getData(value);
                              updateUI(nutritionData);

                              setState(() {
                                isLoading = false;
                              });
                              }),
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          labelText: 'Enter food item',
                          hintText: 'Example: Apple'),
                    ),
                  ),
                  MyCardWidget(text: textOnCard,nutrients: nutrients, composition: composition, servingSize: servingSize, isLoading: isLoading)
                ],
              ),
            )),
      ),
    );
  }
}

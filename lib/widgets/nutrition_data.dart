import 'package:flutter/material.dart';

//circular bubble to show nutrient amount along with nutrient name
class NutritionData extends StatelessWidget {
  final String nutrientName;
  String? amountPresent;
  NutritionData({required this.nutrientName, this.amountPresent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Container(
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width:3, 
            color: Colors.grey,)
          ),
           child: Padding(
              padding: const EdgeInsets.all(20),
              child: 
              //to display amount of nutrient present
              Text(  
                  amountPresent == null ? '0g' : '${amountPresent}g',  
                  style: const TextStyle(fontSize: 18.0,
                  )  
                ),
            ),
            ),
            //to display nutrient name
      Text( '$nutrientName',  
                style: const TextStyle(fontSize: 18.0,
                fontWeight: FontWeight.bold,)  
            ),
      ],
    );
  }
}  

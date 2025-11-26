import 'package:flutter/material.dart';
import 'package:font_scaler/font_scaler.dart';

void main() {
  // Need to Wrap MyApp with FontScaler
  runApp(FontScaler(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Need to Add FontScalerProvider.of(context).builder to reflect the changes
      builder: FontScalerProvider.of(context).builder,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Colors.deepPurpleAccent;
    // This will return the currentFontScale whenEver the fontScale Changes
    final currentFontScale = FontScalerProvider.of(context).currentFontScale;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Description"),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // updateFontScale will update font by given Enum
                  FontScalerProvider.of(
                    context,
                  ).updateFontScale(FontScale.micro);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color:
                        currentFontScale == FontScale.micro
                            ? primaryColor
                            : Colors.white,
                    border: Border.all(color: primaryColor),
                  ),
                  child: Icon(
                    Icons.text_fields_outlined,
                    size: 14,
                    color:
                        currentFontScale == FontScale.micro
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FontScalerProvider.of(
                    context,
                  ).updateFontScale(FontScale.fDefault);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color:
                        currentFontScale == FontScale.fDefault
                            ? primaryColor
                            : Colors.white,
                    border: Border.all(color: primaryColor),
                  ),
                  child: Icon(
                    Icons.text_fields_outlined,
                    size: 20,
                    color:
                        currentFontScale == FontScale.fDefault
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // updateFontScale will update font by given custom double value
                  FontScalerProvider.of(
                    context,
                  ).updateFontScale(FontScale.custom, customValue: 2.2);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color:
                        currentFontScale == FontScale.custom
                            ? primaryColor
                            : Colors.white,
                    border: Border.all(color: primaryColor),
                  ),
                  child: Icon(
                    Icons.text_fields_outlined,
                    size: 28,
                    color:
                        currentFontScale == FontScale.custom
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Size: 38 US", style: textTheme.titleLarge)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < sizeList.length; i++) ...[
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      shape: BoxShape.circle,
                      color: i == 0 ? primaryColor : Colors.white,
                    ),
                    child: Text(
                      sizeList[i].toString(),
                      style: textTheme.labelLarge?.copyWith(
                        color: i == 0 ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 20),
            Text("Product details", style: textTheme.titleLarge),
            SizedBox(height: 15),
            Text("* Feature 1", style: textTheme.titleSmall),
            SizedBox(height: 5),
            Text("* Feature 2", style: textTheme.titleSmall),
            SizedBox(height: 5),
            Text("* Feature 3", style: textTheme.titleSmall),
            SizedBox(height: 5),
            Text("* Feature 4", style: textTheme.titleSmall),
            SizedBox(height: 5),
            Text("* Feature 5", style: textTheme.titleSmall),
            SizedBox(height: 20),
            Text("Composition", style: textTheme.titleLarge),
            SizedBox(height: 15),
            Text(
              "Outer Material : Cotton 100%  Calf:Leather 100%  Lining: Polyester 100%",
              style: textTheme.titleSmall,
            ),
            SizedBox(height: 20),
            Text("Size and fit", style: textTheme.titleLarge),
            SizedBox(height: 15),
            Text(
              "- Fits true to size. Take your normal Size",
              style: textTheme.titleSmall,
            ),
            Text(
              "- Mid weight, Slightly strechy fabric",
              style: textTheme.titleSmall,
            ),
            Text(
              "- The model is weariing its size larger",
              style: textTheme.titleSmall,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(Icons.favorite, color: primaryColor),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      //  This Will Clear the change and remove from local storage and set back to default fontScale
                      FontScalerProvider.of(context).clear();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ADD TO CART",
                        style: textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<int> sizeList = [38, 40, 42, 44];

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  double slideValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        height: 100,
        child: Slider(
          min: 1,
          max: 5,
          value: slideValue,
          onChanged: (double value) {
            FontScalerProvider.of(
              context,
            ).updateFontScale(FontScale.custom, customValue: value);
            setState(() {
              slideValue = value;
            });
          },
        ),
      ),
    );
  }
}

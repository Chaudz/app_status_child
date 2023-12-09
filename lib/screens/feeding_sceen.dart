import 'package:flutter/material.dart';
import 'package:myapp/themes/app_colors.dart';
import 'package:myapp/themes/app_fonts.dart';

void main() {
  runApp(FeedingScreen());
}

class FeedingScreen extends StatefulWidget {
  const FeedingScreen({Key? key});

  @override
  State<FeedingScreen> createState() => _FeedingScreenState();
}

class _FeedingScreenState extends State<FeedingScreen> {
  int selectedButton = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feeding Screen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColor.background,
        body: Container(
          child: Column(
            children: [
              titleOne,
              Flexible(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var titleSection = data[index];
                    return Column(
                      children: [
                        TitleSectionContent(
                          image: titleSection.image,
                          title: titleSection.title,
                          onPressed: () {
                            setState(() {
                              selectedButton = index;
                            });
                          },
                          isSelected: selectedButton == index,
                        ),
                        SizedBox(height: 30.0),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: (selectedButton != -1)
                          ? () async {
                        Navigator.pushNamed(context, '/loadingData');
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        backgroundColor: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      child: Text(
                        'Tiếp',
                        style: AppFont.primaryFont.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60.0), // Khoảng cách bên dưới
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<TitleSection> data = [
  TitleSection(
    image: 'assets/images/icons8-bra-48.png',
    title: 'Cho con bú',
  ),
  TitleSection(
    image: 'assets/images/icons8-baby-bottle-64.png',
    title: 'Bú bình   ',
  ),
  TitleSection(
    image: 'assets/images/both.png',
    title: 'Bú kết hợp',
  ),
];

class TitleSection {
  final String image, title;

  TitleSection({
    required this.image,
    required this.title,
  });
}

Widget titleOne = new Container(
  padding: EdgeInsets.only(left: 30, top: 60, bottom: 30),
  child: new Row(
    children: [
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text('Chỉ định loại nuôi con',
                  style: AppFont.primaryFont.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  )),
              padding: EdgeInsets.only(bottom: 10.0),
            ),
          ],
        ),
      ),
    ],
  ),
);

class TitleSectionContent extends StatelessWidget {
  const TitleSectionContent({
    Key? key,
    required this.image,
    required this.title,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  final String image, title;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey[500] : Colors.black12,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 30.0),
              Image(image: AssetImage(image)),
              SizedBox(width: 60.0),
              Expanded(
                child: Text(

                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black,
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

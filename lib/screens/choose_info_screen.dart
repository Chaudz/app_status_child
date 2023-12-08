import 'package:flutter/material.dart';
import 'package:myapp/themes/app_colors.dart';
import 'package:myapp/themes/app_fonts.dart';

void main() {
  runApp(CreateInfo());
}

class CreateInfo extends StatefulWidget {
  const CreateInfo({Key? key});

  @override
  State<CreateInfo> createState() => _CreateInfoState();
}

// Color backgroundColor = Color.fromRGBO(64, 53, 61, 1.0);

class _CreateInfoState extends State<CreateInfo> {
  bool btn1 = false;
  bool btn2 = false;
  bool btn3 = false;
  bool btn4 = false;

  void setButton(index) {
    setState(() {
      if (index == 1) {
        btn1 = !btn1;
      } else if (index == 2) {
        btn2 = !btn2;
      } else if (index == 3) {
        btn3 = !btn3;
      } else {
        btn4 = !btn4;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'choose info',
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
                        setBtn: () =>
                            { setButton(index)},
                      ),
                      SizedBox(height: 30.0),
                    ],
                  );
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      child: ElevatedButton(
                    onPressed: (btn1 || btn2 || btn3 || btn4)
                        ? () async {
                            Navigator.pushNamed(context, '/chooseEatInfo');
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        backgroundColor: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0))),
                    child: Text(
                      'Tiếp',
                      style: AppFont.primaryFont.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
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
    title: 'Establishing breastfeeding',
  ),
  TitleSection(
    image: 'assets/images/icons8-moon-48.png',
    title: 'Creating a sleep and feeding routine',
  ),
  TitleSection(
    image: 'assets/images/icons8-arrow-48.png',
    title: 'Tracking growth and development',
  ),
  TitleSection(
    image: 'assets/images/icons8-milk-bottle-48.png',
    title: 'Pumping and collecting breast milk',
  )
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
            child: Text('Mark your goals',
                style: AppFont.primaryFont.copyWith(

                )
            ),
            padding: EdgeInsets.only(bottom: 10.0),
          ),
          Text(
            'Please select one or more item',
            style: AppFont.primaryFont.copyWith(
              fontSize: 15,
            ),
          )
        ],
      )),
    ],
  ),
);

class TitleSectionContent extends StatefulWidget {
  const TitleSectionContent(
      {Key? key,
      required this.image,
      required this.title,
      required this.setBtn});

  final String image, title;
  final setBtn;

  @override
  _TitleSectionContentState createState() => _TitleSectionContentState();
}

class _TitleSectionContentState extends State<TitleSectionContent> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.setBtn();

        setState(() {
          isPressed = !isPressed;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isPressed ?Color.fromRGBO(98, 85, 94, 1.0) : Colors.black12,
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Image(image: AssetImage(widget.image)),
              SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: isPressed ? Colors.white: Colors.black, )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

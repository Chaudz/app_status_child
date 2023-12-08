import 'package:flutter/material.dart';
import 'package:myapp/themes/app_fonts.dart';

class ChooseEatsBabyScreen extends StatefulWidget {
  const ChooseEatsBabyScreen({super.key});

  @override
  State<ChooseEatsBabyScreen> createState() => _ChooseEatsBabyScreenState();
}

class _ChooseEatsBabyScreenState extends State<ChooseEatsBabyScreen> {

  bool btn1 = false;
  bool btn2 = false;
  bool btn3 = false;
  int chooseIndex = 4;

  void setButton(index) {
    print("+=========");
    print(index);
    setState(() {
      btn1 = false;
      btn2 = false;
      btn3 = false;
      chooseIndex = index;
      print(chooseIndex);
      if (index == 0) {
        btn1 = !btn1;
      } else if (index == 1) {
        btn2 = !btn2;
      } else{
        btn3 = !btn3;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Xác định cách cho bé ăn',style: AppFont.primaryFont.copyWith(
            ),),
            SizedBox(height: 30),
            Flexible(
                child: ListView.builder(
                  itemCount: dataEatsBaby.length,
                  itemBuilder: (BuildContext context, int index) {
                    var titleSection = dataEatsBaby[index];
                    return Column(
                      children: [
                        TitleSectionContent(
                          image: titleSection.image,
                          title: titleSection.title,
                          index: index,
                          setBtn: () => { setButton(index)},
                          btnChoosed: chooseIndex
                        ),
                        SizedBox(height: 30.0),
                      ],
                    );
                  },
                )
            ),
            ElevatedButton(
              onPressed: (btn1 || btn2 || btn3)
                  ? () async {
                Navigator.pushNamed(context, '/loadingData');
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
          ],
        ),
      )
    );
  }
}

final List<TitleSection> dataEatsBaby = [
  TitleSection(
    image: 'assets/images/icons8-bra-48.png',
    title: 'Bú sữa mẹ',
  ),
  TitleSection(
    image: 'assets/images/icons8-milk-bottle-48.png',
    title: 'Bú sữa bình',
  ),
  TitleSection(
    image: 'assets/images/icons8-arrow-48.png',
    title: 'Kết hợp sữa mẹ và sửa bình',
  ),
];

class TitleSection {
  final String image, title;

  TitleSection({
    required this.image,
    required this.title,
  });
}

class TitleSectionContent extends StatefulWidget {
  const TitleSectionContent(
      {Key? key,
        required this.image,
        required this.title,
        required this.setBtn,
        required this.btnChoosed, this.index});

  final String image, title;
  final setBtn;
  final btnChoosed;
  final index;


  @override
  _TitleSectionContentState createState() => _TitleSectionContentState();
}

class _TitleSectionContentState extends State<TitleSectionContent> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    print(widget.btnChoosed);
    if(widget.index == widget.btnChoosed){
      isPressed = true;
    }
    else{
      isPressed = false;
    }

    return GestureDetector(
      onTap: () {
        widget.setBtn();
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

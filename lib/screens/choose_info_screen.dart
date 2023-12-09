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

class _CreateInfoState extends State<CreateInfo> {
  List<bool> buttonStates = [false, false, false, false];

  void setButton(index) {
    setState(() {
      buttonStates[index] = !buttonStates[index];
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
                          setBtn: () => {setButton(index)},
                          isSelected: buttonStates[index],
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
                      onPressed: (buttonStates.contains(true))
                          ? () async {
                        // Reset button states when navigating back
                        setState(() {
                          buttonStates = [false, false, false, false];
                        });
                        Navigator.pushNamed(
                            context, '/feedingScreen');
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
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
    title: 'Thiết lập việc nuôi con bằng sữa mẹ',
  ),
  TitleSection(
    image: 'assets/images/icons8-moon-48.png',
    title: 'Tạo thói quen ngủ và ăn uống',
  ),
  TitleSection(
    image: 'assets/images/icons8-arrow-48.png',
    title: 'Theo dõi tăng trưởng và phát triển',
  ),
  TitleSection(
    image: 'assets/images/icons8-milk-bottle-48.png',
    title: 'Hút và lưu trữ sữa mẹ',
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
              child: Text('Đánh dấu mục tiêu của bạn',
                  style: AppFont.primaryFont.copyWith(
                      fontSize: 30,
                    fontWeight: FontWeight.bold
                  )),
              padding: EdgeInsets.only(bottom: 10.0),
            ),
            Text(
              'Vui lòng chọn một hoặc nhiều mục',
              style: AppFont.primaryFont.copyWith(
                fontSize: 20,
              ),
            )
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
    required this.setBtn,
    required this.isSelected,
  }) : super(key: key);

  final String image, title;
  final VoidCallback setBtn;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: setBtn,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.grey[500]
                : Colors.black12,
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10.0),
              Image(image: AssetImage(image)),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

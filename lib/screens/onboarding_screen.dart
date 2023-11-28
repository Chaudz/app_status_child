import 'package:flutter/material.dart';
import 'package:myapp/themes/app_fonts.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
            Container(
              height: 40,
              child:    Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            ...List.generate(
                                data.length,
                                    (index) => Padding(padding: EdgeInsets.only(right: 4),
                                  child: DotIndicator(isActive: index == _pageIndex,),
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(_pageIndex < 2)
                    TextButton(
                        onPressed: ()=>{
                          Navigator.pushReplacementNamed(context, '/startScreen')
                        },
                        child: Text('Bỏ qua',style: AppFont.primaryFont.copyWith(
                          fontSize: 15
                        ),)),
                  if(_pageIndex >= 2)
                    SizedBox(
                      width: 100,
                    )
                ],
              ),
            ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                    onPageChanged: (index)=>{
                    setState((){
                      _pageIndex = index;
                    })
                    },
                    itemCount: data.length,
                    itemBuilder: (context,index)=> OnboardContent(
                  image: data[index].image,
                  title: data[index].title,
                  description: data[index].description,)
                ),
              ),
              SizedBox(
                height: 40,
                width: 90,
                child: ElevatedButton(
                  onPressed: ()=>{
                    if(_pageIndex >=2 ){
                      Navigator.pushReplacementNamed(context, '/startScreen')
                    }else{
                      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease)
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFAFAFA),
                    shadowColor: Colors.black,
                  ),
                  child: Text('Tiếp',style: AppFont.primaryFont.copyWith(
                    fontSize: 15
                  ),),
                ),
              )
            ],
          ),
        )

      ),
    );
  }
}
class Onboard{
  final String image, title, description;

  Onboard({
    required this.image,
    required this.title,
    required this.description
});
}
final List<Onboard> data = [
  Onboard(
    image: 'assets/images/logo.jpg',
    title: 'Hiểu thêm về em bé cuả bạn',
    description: 'Ghi âm định kỳ và lưu ý về các thói quen qua biểu ồ và số liệu thống kê'
  ),
  Onboard(
      image: 'assets/images/logo.jpg',
      title: 'Hỗ trợ cho bộ não thiếu ngủ của bạn',
      description: 'Sử dụng dữ liệu ứng dụng ở bổi hẹn khám với bác sĩ của bạn'
  ),
  Onboard(
      image: 'assets/images/logo.jpg',
      title: 'Bám sát theo chế độ',
      description: 'Nhắc nhở linh hoạt với việc cho bé ăn, ngủ, thay tả, vân vân'
  )
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({super.key, required this.image, required this.title, required this.description});

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                // color: Colors.lightGreen,
                image:  DecorationImage(
                  image: AssetImage('assets/images/onboard1.gif'),
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(title,style: AppFont.primaryFont,textAlign: TextAlign.center),
            SizedBox(
              height: 10,
            ),
            Text(description,style: AppFont.primaryFont.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.normal
            ),textAlign: TextAlign.center),
          ],
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, this.isActive = false});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive? 12: 4,
      width: 4,
      decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}


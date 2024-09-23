import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fontend_miniproject2/pages/login_user.dart';
import 'package:fontend_miniproject2/pages/login_rider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SelectLoginPage extends StatefulWidget {
  const SelectLoginPage({super.key});

  @override
  State<SelectLoginPage> createState() => _SelectLoginPageState();
}

class _SelectLoginPageState extends State<SelectLoginPage> {
  // PageController เพื่อควบคุม PageView
  final PageController _pageController = PageController();

  @override
  void dispose() {
    // ล้าง controller เมื่อไม่ใช้งานแล้ว
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 72, 0, 0),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(),
              child: Image.asset(
                'assets/images/Send-Photoroom.png',
                width: 240,
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController, // กำหนด controller ให้ PageView
                children: [
                  // หน้า "ผู้ใช้ทั่วไป"
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/pngtree-takeaway-delivery-food-delivery-png-image_6150345-Photoroom.png',
                        width: 250,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'ผู้ใช้ทั่วไป',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Text(
                          'คุณสามารถเรียกไรเดอร์ เพื่อมารับพัสดุของคุณถึงหน้าบ้าน และจัดส่งให้ถึงผู้รับปลายทางได้อย่างรวดเร็วและปลอดภัย',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),

                  // หน้า "ไรเดอร์"
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/pngtree-delivery-man-cute-with-box-cartoon-isolated-png-image_13881309-Photoroom.png',
                        width: 250,
                      ),
                      Text(
                        'ไรเดอร์',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Text(
                          'เป็นไรเดอร์กับ Send รับงานส่งสินค้าได้ง่าย ๆ ทุกที่ทุกเวลา! ไรเดอร์สามารถรอกดรับงาน จากนั้นนำสินค้าที่ได้รับมอบหมายไปส่งยังจุดหมายปลายทางอย่างรวดเร็วและปลอดภัย',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // แสดง SmoothPageIndicator ที่ด้านล่าง
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: SmoothPageIndicator(
                controller: _pageController, // จับคู่กับ PageView controller
                count: 2, // จำนวนหน้าที่จะแสดง
                effect: WormEffect(
                  dotColor: Colors.white30,
                  activeDotColor: Colors.white,
                  dotHeight: 7,
                  dotWidth: 7,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 170, // กำหนดความกว้างของปุ่ม
                    child: OutlinedButton(
                      child: const Text('ผู้ใช้งานทั่วไป',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: user,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 2.0), // สีและความหนาของเส้นขอบ
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 170, // กำหนดความกว้างของปุ่ม
                    child: FilledButton(
                      child: const Text(
                        'ไรเดอร์',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        foregroundColor: const Color.fromARGB(255, 72, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // มุมโค้งของปุ่ม
                        ),
                        elevation: 5, // เพิ่มเงาให้กับปุ่ม
                      ),
                      onPressed: rider,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void user() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginUserPage(),
      ),
    );
  }

  void rider() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginRiderPage(),
      ),
    );
  }
}

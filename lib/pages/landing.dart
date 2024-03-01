import 'package:flutter/material.dart';
import 'package:get_to_know_thiana/pages/chat.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/background.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 20,
            left: 30,
            child: Image.asset(
              'assets/chatgpt.png',
              width: 110,
              height: 110,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 140),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    children: [
                      SlidePage(
                        title: 'Get To Know THIANA',
                        subtitle: 'Chat with an open AI generator and learn more about me.',
                      ),
                      SlidePage(
                        title: 'Executive Software Engineer',
                        subtitle: 'I currently work as a SOFTWARE ENGINEER at Scicom (MSC) Berhad in Kuala Lumpur, Malaysia.',
                      ),
                      SlidePage(
                        title: 'What I like to do ?',
                        subtitle: 'I enjoy coding, learning new technologies and I play soccer.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => buildIndicator(index),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ElevatedButton(
                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Get Started'),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 5),
                const Text(
                  'AI Powered',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
      child: Container(
        width: 20,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: index == _currentPageIndex ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}

class SlidePage extends StatelessWidget {
  final String title;
  final String subtitle;

  SlidePage({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

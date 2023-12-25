import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_animate/flutter_animate.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SlidingCardsView(),
    );
  }
}





class SlidingCardsView extends StatefulWidget {
  const SlidingCardsView({super.key});

  @override
  State<SlidingCardsView> createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView>
    with TickerProviderStateMixin {
  // defining the Animation Controller
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );
  late final AnimationController _controller1 = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );
  late final AnimationController _controller3 = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );
  late final AnimationController _controller4 = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  // defining the Offset of the animation
  late Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  late PageController pageController;
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    pageController.addListener(() async {
      print('calllec == ${pageController.offset}');

      if (pageController.offset > 40) {
        if (_controller.isAnimating ||
            _controller1.isAnimating ||
            _controller2.isAnimating ||
            _controller3.isAnimating) {
          return;
        }
        print('calllec => $selectedPage');

        // _offsetAnimation = Tween<Offset>(
        //   begin: Offset.zero,
        //   end: const Offset(-10, 0.0),
        // ).animate(CurvedAnimation(
        //   parent: _controller,
        //   curve: Curves.elasticIn,
        // ));
        if (selectedPage == 0) {
          _controller.reverse();
          _controller1.reverse();
          _controller2.reverse();
          _controller3.reverse();
        } else {
          // _offsetAnimation = Tween<Offset>(
          //   begin: const Offset(1, 0.0),
          //   end: const Offset(0.0, 0.0),
          // ).animate(CurvedAnimation(
          //   parent: _controller,
          //   curve: Curves.elasticOut,
          // ));
          _controller.forward();
          _controller1.forward();
          _controller2.forward();
          _controller3.forward();
        }

        // await Future.delayed(const Duration(seconds: 1));

        // _controller.stop();
        // _controller.reset();
      }
      // _controller.forward();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView.builder(
        clipBehavior: Clip.none,
        controller: pageController,
        itemCount: 2,
        onPageChanged: (value) {
          selectedPage = value;
        },
        itemBuilder: (context, index) {
          // double offset = pageOffset - index;

          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double pageOffset = 0;
              if (pageController.position.haveDimensions) {
                pageOffset = pageController.page! - index;
              }
              double gauss =
                  math.exp(-(math.pow((pageOffset.abs() - 0.5), 2) / 0.08));
              return Transform.translate(
                offset: Offset(0, 0),
                child: Container(
                  clipBehavior: Clip.none,
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: const [
                      // BoxShadow(
                      //   color: Colors.black.withOpacity(0.1),
                      //   offset: const Offset(8, 20),
                      //   blurRadius: 24,
                      // ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      if (index == 0) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.red,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.green,
                                ),
                              ],
                            )
                                .animate(
                                    // controller: _controller,

                                    )
                                .slideX(
                                    end: -gauss,
                                    duration: const Duration(milliseconds: 3)),
                            const Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.yellow,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.black,
                                ),
                              ],
                            )
                                .animate(
                                    // controller: _controller1,
                                    )
                                .slideX(
                                    end: -gauss,
                                    duration: const Duration(milliseconds: 50)),
                            const Column(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.blue,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.pink,
                                ),
                              ],
                            )
                                .animate(
                                  controller: _controller2,
                                )
                                .slideX(
                                    end: -gauss,
                                    duration:
                                        const Duration(milliseconds: 100)),
                          ],
                        ),
                      ] else ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Column(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.red,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            )
                                .animate(
                                    // controller: _controller2,
                                    )
                                .slideX(
                                    end: gauss,
                                    duration:
                                        const Duration(milliseconds: 100)),
                            const Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.red,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            )
                                .animate(
                                    // controller: _controller3,
                                    )
                                .slideX(
                                    end: gauss,
                                    duration: const Duration(milliseconds: 3)),
                            const Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.red,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            )
                                .animate(
                                    // controller: _controller3,
                                    )
                                .slideX(
                                    end: gauss,
                                    duration: const Duration(milliseconds: 3)),
                          ],
                        ),
                      ]

                      // Image
                      // ClipRRect(
                      //   borderRadius: const BorderRadius.vertical(
                      //       top: Radius.circular(32)),
                      //   child: Image.asset(
                      //     'assets/${demoCardData[index].image}',
                      //     height: MediaQuery.of(context).size.height * 0.3,
                      //     alignment: Alignment(-pageOffset.abs(), 0),
                      //     fit: BoxFit.none,
                      //   ),
                      // ),
                      // Expanded(child: child!),
                    ],
                  ),
                ),
              );
            },
           
          );
        },
      ),
    );
  }
}
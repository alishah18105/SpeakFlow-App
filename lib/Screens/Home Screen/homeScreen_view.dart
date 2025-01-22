import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:voice_recognizer/Screens/Home%20Screen/homeScreen_viewModel.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        viewModel.initSpeech();
      },
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0xFF2C3E50), // Dark blue
                  Color(0xFF4B0082), // Dark purple
                  Color(0xFF8E44AD), // Deep pink-purple
                ],
                center: Alignment(0.8, -0.6),
                radius: 1.2,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                       
                        const Text(
                            "Speech To Text",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontFamily: "BebasNeue",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  offset: Offset(1, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                          
                       
                     
                      const SizedBox(height: 30),
                      GestureDetector(
                            onTap: () {
                              viewModel.speechToText.isNotListening
                                  ? viewModel.startListening()
                                  : viewModel.stopListening();
                            },
                            child: TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 1, end: viewModel.speechToText.isListening ? 1.2 : 1),
                              duration: Duration(milliseconds: 500),
                              builder: (context, scale, child) {
                                return Transform.scale(
                                  scale: scale,
                                  child: child,
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: viewModel.speechToText.isNotListening
                                      ? Color(0xFFE91E63) // Bright pink for "mic off"
                                      : Color(0xFFAB47BC), // Light purple for "mic on"
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  opacity: viewModel.speechToText.isListening ? 1.0 : 0.5,
                                  child: Icon(
                                    viewModel.speechToText.isNotListening ? Feather.mic_off : Feather.mic,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),

                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          viewModel.speechToText.isListening
                              ? 'Listening...'
                              : viewModel.speechEnabled
                                  ? 'Tap the microphone to start listening...'
                                  : 'Speech not available',
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        color: Color(0x88000000), // Semi-transparent black
                        elevation: 10,
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          height: 300,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Center(
                                        child: Text(
                                          "Recognized Text",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: "Oswald",
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFFFD700), // Gold
                                          ),
                                        ),
                                      ),
                                      const Divider(thickness: 2),
                                      const SizedBox(height: 10),
                                      TextField(
                                      controller: TextEditingController(text: viewModel.lastWords),
                                      onChanged: (value) {
                                        viewModel.lastWords = value;
                                      },
                                      maxLines: null, 
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        color: Colors.white70,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: "Start typing here...",
                                        hintStyle: TextStyle(color: Colors.white38),
                                        border: InputBorder.none,
                                      ),
                                      cursorColor: Colors.white,
                                    ),
                                    ],
                                  ),
                                ),
                                
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:Color(0xFF8E44AD) , // Bright pink
                                        radius: 25,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.copy,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Clipboard.setData(
                                              ClipboardData(text: viewModel.lastWords),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      CircleAvatar(
                                        backgroundColor: Color(0xFFFFD700), // Gold
                                        radius: 25,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.volume_up,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            viewModel.speakText(viewModel.lastWords);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft, // One button on the left
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Color(0xFF2C3E50), // Dark blue
                                        radius: 25,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            viewModel.clearTextField(); // Clear the text
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (viewModel.lastWords.isNotEmpty) {
                            Share.share(viewModel.lastWords);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No text available to share'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.share),
                        label: const Text("Share"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 10),
                          backgroundColor: Color(0xFFE91E63), // Purple
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

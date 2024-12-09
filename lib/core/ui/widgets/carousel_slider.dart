import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../constant/app_colors/app_colors.dart';
import 'cached_image.dart';

class CarouselWidget extends StatelessWidget {
  final List<String> images;
  final CarouselSliderController controller;
  final void Function(int index)? onTap;
  final Function(int index) onPageChanged;
  final int currentIndexIndicator;
  final double viewportFraction;
  final double padding;
  final double height;
  final BoxFit? photoFit;
  final bool hasImageModel;
  final bool autoPlay;
  final bool isEndix;
  final bool isZoomable;

  const CarouselWidget({
    super.key,
    required this.images,
    required this.controller,
    required this.onPageChanged,
    required this.currentIndexIndicator,
    required this.viewportFraction,
    this.hasImageModel = true,
    required this.padding,
    required this.height,
    this.onTap,
    this.photoFit,
    required this.autoPlay,
    this.isZoomable = false,
    this.isEndix = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: controller,
          options: CarouselOptions(
            height: height,
            initialPage: 0,
            enableInfiniteScroll: images.length > 1,
            autoPlay: autoPlay,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOutExpo,
            enlargeCenterPage: false,
            enlargeFactor: 0.1,
            viewportFraction: viewportFraction,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              onPageChanged(index);
            },
          ),
          items: images
              .asMap()
              .map((index, imageUrl) {
                return MapEntry(
                  index,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: GestureDetector(
                      onTap: isZoomable
                          ? () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: Colors.black,
                                    iconTheme: const IconThemeData(
                                        color: Colors.white),
                                  ),
                                  body: Center(
                                    child: CachedImage(
                                      imageUrl: imageUrl,
                                      fit: BoxFit.contain,
                                      height: double.infinity,
                                      width: double.infinity,
                                      isZoomable: true,
                                    ),
                                  ),
                                ),
                              ));
                            }
                          : (onTap != null ? () => onTap?.call(index) : null),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: CachedImage(
                          imageUrl: imageUrl,
                          fit: photoFit ?? BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                );
              })
              .values
              .toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        if (images.length > 1 && isEndix == true)
          Center(
            child: SizedBox(
              height: 7,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => currentIndexIndicator == index
                    ? Container(
                        height: 7,
                        width: 25,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      )
                    : const CircleAvatar(
                        radius: 5,
                        backgroundColor: AppColors.greyDD,
                      ),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 14,
                ),
                itemCount: images.length,
              ),
            ),
          )
      ],
    );
  }
}

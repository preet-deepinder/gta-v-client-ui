import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_test/data/constants/enums.dart';
import 'package:html_test/data/injectors/sender_injection.dart';

final ccProvider = ChangeNotifierProvider<CharactarCreationChangeProvider>(
  (_) => CharactarCreationChangeProvider(),
);

class CharactarCreationChangeProvider extends ChangeNotifier {
  int _gender = 0;
  int get gender => _gender;

////////

  double _fatherShape = 0;
  double _motherShape = 0;
  double _faceMix = 0;
  double _fatherSkin = 0;
  double _motherSkin = 0;
  double _skinMix = 0;
  double _eyes = 0;

////////

  int _hairs = 0;

////////

  int _blemishes = 0;
  int _facialHair = 0;
  int _eyeBrow = 0;
  int _ageing = 0;
  int _makeUp = 0;
  int _complexion = 0;
  int _blush = 0;
  int _sunDamage = 0;
  int _lipstick = 0;
  int _moles = 0;
  int _chestHair = 0;
  int _bodyBlemishes = 0;
  int _addBodyBlemish = 0;

////////

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 1;
  final int _maxPage = 3;

  PageController get pageController => _pageController;
  int get currentPage => _currentPage;

  // Page Controller

  onNextButton() {
    if (_currentPage < _maxPage) {
      _currentPage++;
      _pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.ease);
      notifyListeners();
    }
  }

  onBackButton() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.ease);
      notifyListeners();
    }
  }

  // GENDER

  void onGender(int i) {
    _gender = i;
    if (kReleaseMode) {
      emit(CharacterCreator.GENDER.name, i == 0 ? 'male' : 'female');
      emitHeadBlendAndEyes();
      emitPedHeadOverlay();
    }
  }

  // HEAD BLEND AND EYES

  void onFathershape(int i) {
    _fatherShape = i.toDouble();
    emitHeadBlendAndEyes();
  }

  void onMothershape(int i) {
    _motherShape = i.toDouble();
    emitHeadBlendAndEyes();
  }

  void onFatherSkin(int i) {
    _fatherSkin = i.toDouble();
    emitHeadBlendAndEyes();
  }

  void onMotherSkin(int i) {
    _motherSkin = i.toDouble();
    emitHeadBlendAndEyes();
  }

  void onShapeMix(double i) {
    _faceMix = i;
    emitHeadBlendAndEyes();
  }

  void onSkinMix(double i) {
    _skinMix = i;
    emitHeadBlendAndEyes();
  }

  void onEyes(int i) {
    _eyes = i.toDouble() + 1.0;
    emitHeadBlendAndEyes();
  }

  void emitHeadBlendAndEyes() {
    final data = [_fatherShape, _motherShape, _fatherSkin, _motherSkin, _faceMix, _skinMix, _eyes];
    if (kReleaseMode) emit(CharacterCreator.HEAD_BLEND_AND_EYES.name, data);
  }

  // HAIRS

  void onHairs(int i) {
    _hairs = i;
    emitHairs();
  }

  void emitHairs() {
    if (kReleaseMode) emit(CharacterCreator.HAIRS, _hairs);
  }

  // PED HEAD OVERLAY

  void onBlemishes(int i) {
    _blemishes = i;
    emitPedHeadOverlay();
  }

  void onFacialHair(int i) {
    _facialHair = i;
    emitPedHeadOverlay();
  }

  void onEyebrow(int i) {
    _eyeBrow = i;
    emitPedHeadOverlay();
  }

  void onAgeing(int i) {
    _ageing = i;
    emitPedHeadOverlay();
  }

  void onMakeUp(int i) {
    _makeUp = i;
    emitPedHeadOverlay();
  }

  void onBlush(int i) {
    _blush = i;
    emitPedHeadOverlay();
  }

  void onComplexion(int i) {
    _complexion = i;
    emitPedHeadOverlay();
  }

  void onSunDamage(int i) {
    _sunDamage = i;
    emitPedHeadOverlay();
  }

  void onLipstick(int i) {
    _lipstick = i;
    emitPedHeadOverlay();
  }

  void onMoles(int i) {
    _moles = i;
    emitPedHeadOverlay();
  }

  void onChestHairs(int i) {
    _chestHair = i;
    emitPedHeadOverlay();
  }

  void onBodyBlemishes(int i) {
    _bodyBlemishes = i;
    emitPedHeadOverlay();
  }

  void addBodyBlemishes(int i) {
    _addBodyBlemish = i;
    emitPedHeadOverlay();
  }

  void emitPedHeadOverlay() {
    final data = [
      _blemishes,
      _facialHair,
      _eyeBrow,
      _ageing,
      _makeUp,
      _blush,
      _complexion,
      _sunDamage,
      _lipstick,
      _moles,
      _chestHair,
      _bodyBlemishes,
      _addBodyBlemish,
    ];

    if (kReleaseMode) emit(CharacterCreator.PED_HEAD_OVERLAY.name, data);
  }
}

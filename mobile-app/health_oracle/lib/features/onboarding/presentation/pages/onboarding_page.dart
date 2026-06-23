import 'package:flutter/material.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../../../../main.dart';
import '../widgets/name_page.dart';
import '../widgets/birth_date_page.dart';
import '../widgets/sex_page.dart';
import '../widgets/height_page.dart';
import '../widgets/weight_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  int _currentPage = 0;
  DateTime? _birthDate;
  bool? _sex;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isKeyboardVisible = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  static const _primaryColor = Color(0xFFAC68F2);
  static const _secondaryColor = Color(0xFF4E00c9);
  static const _tricondaryColor = Color(0xFF1A1E4C);

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _nextPage() {
    FocusScope.of(context).unfocus();

    if (!_canProceed()) {
      _showValidationError();
      return;
    }

    if (_currentPage < 4) {
      _fadeController.reverse().then((_) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _fadeController.forward();
      });
    } else {
      _finish();
    }
  }

  void _previousPage() {
    FocusScope.of(context).unfocus();

    if (_currentPage > 0) {
      _fadeController.reverse().then((_) {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _fadeController.forward();
      });
    }
  }

  void _showValidationError() {
    String? message;
    switch (_currentPage) {
      case 0:
        message = 'Пожалуйста, введите ваше имя';
        break;
      case 1:
        message = 'Пожалуйста, выберите дату рождения';
        break;
      case 2:
        message = 'Пожалуйста, укажите ваш пол';
        break;
      case 3:
        message = 'Пожалуйста, укажите ваш рост';
        break;
      case 4:
        message = 'Пожалуйста, укажите ваш вес';
        break;
    }

    if (message != null && mounted) {
      setState(() => _errorMessage = message);
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _errorMessage = null);
      });
    }
  }

  bool _canProceed() {
    switch (_currentPage) {
      case 0:
        return _nameController.text.trim().isNotEmpty;
      case 1:
        return _birthDate != null;
      case 2:
        return _sex != null;
      case 3:
        return _heightController.text.isNotEmpty &&
            double.tryParse(_heightController.text) != null;
      case 4:
        return _weightController.text.isNotEmpty &&
            double.tryParse(_weightController.text) != null;
      default:
        return true;
    }
  }

  Future<void> _finish() async {
    if (!_canProceed()) return;

    setState(() => _isLoading = true);

    try {
      final profile = UserProfile(
        firstName: _nameController.text.trim(),
        birthDate: _birthDate,
        height: double.tryParse(_heightController.text),
        weight: double.tryParse(_weightController.text),
        sex: _sex,
      );

      await ProfileService.saveProfile(profile);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainNavigator(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Произошла ошибка при сохранении. Попробуйте ещё раз.';
        });
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) setState(() => _errorMessage = null);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_primaryColor, _secondaryColor, _tricondaryColor],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button and progress
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      opacity: _currentPage > 0 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: _currentPage > 0 ? 44 : 0,
                        height: 44,
                        child: _currentPage > 0
                            ? GestureDetector(
                                onTap: _previousPage,
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),

                    // Page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          List.generate(5, (index) => _buildDot(index)),
                    ),

                    const SizedBox(width: 44),
                  ],
                ),
              ),

              // Error message banner
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _errorMessage != null ? 48 : 0,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _errorMessage != null
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.info_outline,
                                color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              _errorMessage!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : null,
              ),

              // PageView
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    children: [
                      NamePage(
                        controller: _nameController,
                        onChanged: () => setState(() {}),
                        onKeyboardChanged: (visible) {
                          if (visible != _isKeyboardVisible) {
                            setState(() => _isKeyboardVisible = visible);
                          }
                        },
                      ),
                      BirthDatePage(
                        selectedDate: _birthDate,
                        onDateSelected: (date) =>
                            setState(() => _birthDate = date),
                      ),
                      SexPage(
                        selectedSex: _sex,
                        onSexSelected: (sex) => setState(() => _sex = sex),
                      ),
                      HeightPage(
                        controller: _heightController,
                        onChanged: () => setState(() {}),
                        onKeyboardChanged: (visible) {
                          if (visible != _isKeyboardVisible) {
                            setState(() => _isKeyboardVisible = visible);
                          }
                        },
                      ),
                      WeightPage(
                        controller: _weightController,
                        onChanged: () => setState(() {}),
                        onKeyboardChanged: (visible) {
                          if (visible != _isKeyboardVisible) {
                            setState(() => _isKeyboardVisible = visible);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Continue button
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed:
                        _canProceed() ? (_isLoading ? null : _nextPage) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _secondaryColor,
                      
                      disabledBackgroundColor: Colors.white.withValues(alpha: 0.4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: _primaryColor,
                            ),
                          )
                        : Text(
                            _currentPage == 4
                                ? context.l10n.onboardingFinish
                                : context.l10n.onboardingContinue,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    final isActive = index == _currentPage;
    final isPassed = index < _currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 28 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? Colors.white
            : isPassed
                ? Colors.white.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

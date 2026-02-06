import 'package:flutter/material.dart';
import '../../../core/constants/currencies.dart';
import '../../../core/services/preferences_service.dart';
import 'widgets/base_currency_page.dart';
import 'widgets/target_currency_page.dart';
import 'widgets/welcome_page.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({
    super.key,
    required this.onComplete,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final PreferencesService _prefsService = PreferencesService();

  int _currentPage = 0;
  String _selectedBaseCurrency = 'USD';
  List<String> _selectedTargetCurrencies = List.from(Currencies.defaultWatchList);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    // 기준 통화 저장
    await _prefsService.setBaseCurrency(_selectedBaseCurrency);

    // 관심 통화에서 기준 통화 제외
    final targetCurrencies = _selectedTargetCurrencies
        .where((c) => c != _selectedBaseCurrency)
        .toList();

    // 관심 통화 저장
    await _prefsService.setWatchList(targetCurrencies);

    // 온보딩 완료 표시
    await _prefsService.setOnboardingComplete(true);

    // 완료 콜백
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 페이지 인디케이터
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    IconButton(
                      onPressed: _previousPage,
                      icon: const Icon(Icons.arrow_back),
                    )
                  else
                    const SizedBox(width: 48),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // 페이지 뷰
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // 페이지 1: 환영
                  WelcomePage(
                    onNext: _nextPage,
                  ),

                  // 페이지 2: 기준 통화 선택
                  BaseCurrencyPage(
                    selectedCurrency: _selectedBaseCurrency,
                    onCurrencySelected: (currency) {
                      setState(() {
                        final oldBaseCurrency = _selectedBaseCurrency;
                        _selectedBaseCurrency = currency;

                        // 새 기준 통화를 관심 목록에서 제거
                        _selectedTargetCurrencies = _selectedTargetCurrencies
                            .where((c) => c != currency)
                            .toList();

                        // 이전 기준 통화를 관심 목록 맨 앞에 추가 (없는 경우)
                        if (!_selectedTargetCurrencies.contains(oldBaseCurrency)) {
                          _selectedTargetCurrencies = [
                            oldBaseCurrency,
                            ..._selectedTargetCurrencies,
                          ];
                        }
                      });
                    },
                    onNext: _nextPage,
                  ),

                  // 페이지 3: 관심 통화 선택
                  TargetCurrencyPage(
                    baseCurrency: _selectedBaseCurrency,
                    selectedCurrencies: _selectedTargetCurrencies,
                    onCurrenciesChanged: (currencies) {
                      setState(() {
                        _selectedTargetCurrencies = currencies;
                      });
                    },
                    onComplete: _completeOnboarding,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

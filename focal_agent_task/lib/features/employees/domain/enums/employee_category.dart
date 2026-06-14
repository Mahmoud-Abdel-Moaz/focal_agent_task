const iTText = 'IT';
const hRText = 'HR';

enum EmployeeCategory {
  iT(text: iTText),
  hR(text: hRText),
  none(text: '');

  const EmployeeCategory({required this.text});

  final String text;
}

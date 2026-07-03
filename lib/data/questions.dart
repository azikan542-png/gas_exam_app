import '../models/question.dart';

import 'gakushiki_r1_2.dart';
import 'gakushiki_r2_1.dart';
import 'gakushiki_r2_2.dart';
import 'gakushiki_r3_1.dart';
import 'gakushiki_r3_2.dart';
import 'gakushiki_r4_1.dart';
import 'gakushiki_r4_2.dart';
import 'gakushiki_r5_1.dart';
import 'gakushiki_r5_2.dart';
import 'gakushiki_r6_1.dart';

final List<Question> questions = [
  ...gakushikiR1_2,
  ...gakushikiR2_1,
  ...gakushikiR2_2,
  ...gakushikiR3_1,
  ...gakushikiR3_2,
  ...gakushikiR4_1,
  ...gakushikiR4_2,
  ...gakushikiR5_1,
  ...gakushikiR5_2,
  ...gakushikiR6_1,
];
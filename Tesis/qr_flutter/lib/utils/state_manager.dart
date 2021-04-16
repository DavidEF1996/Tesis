import 'package:qr_flutter/model/diagnostico.dart';
import 'package:riverpod/riverpod.dart';

final diagnosticoState = StateNotifierProvider((ref) => DiagnosticoList([]));

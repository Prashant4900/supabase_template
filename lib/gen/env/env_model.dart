// Env Reader Auto-Generated Model File
// Created at 2025-03-30 23:31:44.490139
// 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀
import 'package:env_reader/env_reader.dart';

/// This class represents environment variables parsed from the .env file.
/// Each static variable corresponds to an environment variable,
/// with default values provided for safety
/// `false` for [bool], `0` for [int], `0.0` for [double] and `VARIABLE_NAME` for [String].
class EnvModel {
  /// Value of `SUPABASE_PASSWORD` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('SUPABASE_PASSWORD') ?? 'SUPABASE_PASSWORD';
  /// ```
  static String supabasePassword = Env.read<String>('SUPABASE_PASSWORD') ?? 'SUPABASE_PASSWORD';

  /// Value of `SUPABASE_URL` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('SUPABASE_URL') ?? 'SUPABASE_URL';
  /// ```
  static String supabaseUrl = Env.read<String>('SUPABASE_URL') ?? 'SUPABASE_URL';

  /// Value of `SUPABASE_ANON` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('SUPABASE_ANON') ?? 'SUPABASE_ANON';
  /// ```
  static String supabaseAnon = Env.read<String>('SUPABASE_ANON') ?? 'SUPABASE_ANON';

}

import 'dart:convert';
import 'package:cryptography/cryptography.dart';

Future<void> initCrypto() async {

}

enum HashAlgo { sha256, sha512, blake2b160, blake2b256 }
enum MacAlgo { hmacSha256, hmacSha512 }
enum KdfAlgo { pbkdf2HmacSha256, pbkdf2HmacSha512 }

class CryptoService {
  Future<List<int>> hash(HashAlgo algo, String text) async {
    final bytes = utf8.encode(text);

    final HashAlgorithm a;
    switch (algo) {
      case HashAlgo.sha256:
        a = Sha256();
        break;
      case HashAlgo.sha512:
        a = Sha512();
        break;
      case HashAlgo.blake2b160:
        a = Blake2b(hashLengthInBytes: 20); // 160 bits
        break;
      case HashAlgo.blake2b256:
        a = Blake2b(hashLengthInBytes: 32); // 256 bits
        break;
    }

    final digest = await a.hash(bytes);
    return digest.bytes;
  }

  static String toHex(List<int> bytes) =>
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

  static String toBase64(List<int> bytes) => base64Encode(bytes);
}

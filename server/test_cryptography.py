import unittest
from utils.cryptography import AES
from utils.generator import random_string


class TestCryptoGraphy(unittest.TestCase):

    def test_aes_1(self):
        gen_key: str = AES.generate_secret_key()
        rand_base64: str = random_string(2000)

        encrypted_str: str = AES.encrypt_audio(rand_base64, gen_key)
        decrypted_str: str = AES.decrypt_audio(encrypted_str, gen_key)

        self.assertEqual(rand_base64, decrypted_str)

    def test_aes_2(self):
        gen_key: str = AES.generate_secret_key()
        rand_base64 = random_string(30000)

        encrypted_str: str = AES.encrypt_audio(rand_base64, gen_key)
        decrypted_str: str = AES.decrypt_audio(encrypted_str, gen_key)

        self.assertEqual(rand_base64, decrypted_str)

    def test_aes_3(self):
        gen_key: str = AES.generate_secret_key()
        rand_base64 = random_string(50000)

        encrypted_str: str = AES.encrypt_audio(rand_base64, gen_key)
        decrypted_str: str = AES.decrypt_audio(encrypted_str, gen_key)

        self.assertEqual(rand_base64, decrypted_str)

    def test_aes_4(self):
        gen_key: str = AES.generate_secret_key()
        rand_base64 = random_string(70000)

        encrypted_str: str = AES.encrypt_audio(rand_base64, gen_key)
        decrypted_str: str = AES.decrypt_audio(encrypted_str, gen_key)

        self.assertEqual(rand_base64, decrypted_str)

    def test_aes_5(self):
        gen_key: str = AES.generate_secret_key()
        rand_base64 = random_string(100000)

        encrypted_str: str = AES.encrypt_audio(rand_base64, gen_key)
        decrypted_str: str = AES.decrypt_audio(encrypted_str, gen_key)

        self.assertEqual(rand_base64, decrypted_str)

    def test_aes_6(self):
        gen_key: str = AES.generate_secret_key()
        rand_base64 = random_string(200000)

        encrypted_str: str = AES.encrypt_audio(rand_base64, gen_key)
        decrypted_str: str = AES.decrypt_audio(encrypted_str, gen_key)

        self.assertEqual(rand_base64, decrypted_str)

    def test_aes_7(self):
        gen_key: str = AES.generate_secret_key()
        rand_base64 = random_string(500000)

        encrypted_str: str = AES.encrypt_audio(rand_base64, gen_key)
        decrypted_str: str = AES.decrypt_audio(encrypted_str, gen_key)

        self.assertEqual(rand_base64, decrypted_str)


if __name__ == "__main__":
    unittest.main()

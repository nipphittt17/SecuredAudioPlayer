from utils.generator import random_string
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
import os
import base64
from base64 import b64encode


class AES:

    def generate_secret_key() -> str:
        LENGTH_FOR_SECRET_KEY = 32
        # return os.urandom(LENGTH_FOR_SECRET_KEY)
        return random_string(LENGTH_FOR_SECRET_KEY)
    

    @staticmethod
    def decrypt_audio(encrypted_audio_file_base64: str, secret_key: str) -> str:
        backend = default_backend()
        encrypted_data = base64.b64decode(encrypted_audio_file_base64)

        # Split the encrypted data into the IV and the encrypted audio file
        iv = encrypted_data[:16]
        secret_key_bytes = secret_key.encode()
        cipher = Cipher(algorithms.AES(secret_key_bytes), modes.CBC(iv), backend=backend)

        encrypted_audio_file = encrypted_data[16:]
        # Decrypt the ciphertext
        decryptor = cipher.decryptor()
        decrypted_padded_plaintext = decryptor.update(encrypted_audio_file) + decryptor.finalize()

        # Remove the padding from the decrypted plaintext
        padding_length = decrypted_padded_plaintext[-1]
        decrypted_audio_file_base64 = decrypted_padded_plaintext[:-padding_length]
        return decrypted_audio_file_base64.decode()

    @staticmethod
    def encrypt_audio(raw_audio_file_base64: str, secret_key: str) -> str:
        raw_audio_file_bytes = raw_audio_file_base64.encode()
        secret_key_bytes = secret_key.encode()

        # Generate a random initialization vector
        iv = os.urandom(16)

        # Create an AES cipher with CBC mode and the specified key and IV
        cipher = Cipher(algorithms.AES(secret_key_bytes), modes.CBC(iv), backend=default_backend())

        # Pad the plaintext to a multiple of the block size
        block_size = algorithms.AES.block_size // 8
        padding_length = block_size - len(raw_audio_file_bytes) % block_size
        padded_plaintext = raw_audio_file_bytes + bytes([padding_length] * padding_length)

        # Encrypt the padded plaintext
        encryptor = cipher.encryptor()
        encrypted_audio_file = encryptor.update(padded_plaintext) + encryptor.finalize()

        # Concatenate the IV and the encrypted audio file, and return the result as a base64-encoded string
        encrypted_data = iv + encrypted_audio_file
        encrypted_audio_file_base64 = b64encode(encrypted_data).decode()
        return encrypted_audio_file_base64
  

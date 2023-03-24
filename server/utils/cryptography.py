from generator import random_string


class AES:

    @staticmethod
    def generate_secret_key() -> str:
        LENGTH_FOR_SECRET_KEY = 44
        return random_string(LENGTH_FOR_SECRET_KEY)

    @staticmethod
    def decrypt_audio(encrypted_audio_file_base64: str, secret_key: str) -> str:
        # Add the logic here
        # This is just a placeholder, replace with correct logic

        decrypted_audio_file_base64 = encrypted_audio_file_base64 + secret_key
        return decrypted_audio_file_base64

    @staticmethod
    def encrypt_audio(raw_audio_file_base64: str, secret_key: str) -> str:
        # Add the logic here
        # This is just a placeholder, replace with correct logic

        encrypted_audio_file_base64 = raw_audio_file_base64 + secret_key
        return encrypted_audio_file_base64

from utils.generator import random_string
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
import os
import base64
from base64 import b64encode


class AES:

    @staticmethod
    def generate_secret_key() -> str:
        LENGTH_FOR_SECRET_KEY = 16
        return random_string(LENGTH_FOR_SECRET_KEY)
    



    @staticmethod
    def encrypt_audio(raw_audio_file_base64: str, secret_key: str) -> str:

        #.encode() -> convert to byte object (built-in method for Python strings)
        # we have to convert audio(base64) and secret key as byte objects
        raw_audio_file_bytes = raw_audio_file_base64.encode()
        secret_key_bytes = secret_key.encode()

        # generate a random initialization vector (iv) using an operating system-specific random number generator
        iv = os.urandom(16) #IV has to be 16 bytes as the block size of AES (128 bits - 6 bytes)

        #the default cryptographic backend for the system it is running on
        backend=default_backend()

        # Create an cipher object as AES cipher with CBC mode
        cipher = Cipher(algorithms.AES(secret_key_bytes),
                modes.CBC(iv), backend)
        # Encrypt the padded plaintext
        encryptor = cipher.encryptor() #encryptor object


        # Pad the plaintext to a multiple of the block size
        block_size = algorithms.AES.block_size // 8 #change bits to byte  128 -> 16 
        #calculate the pad length to add -> so the plaintext will be divisible by the block size (16)
        padding_length = block_size - len(raw_audio_file_bytes) % block_size
        padded_plaintext = raw_audio_file_bytes + \
            bytes([padding_length] * padding_length) #create byte object that has len = padding_length + contain the padding_length num
        #same number as size bc its PKCS#7 padding scheme -> to ensure that  the padding can be easily removed after decryption, 
        # since the padding length can be inferred from the value of the last padding byte

        encrypted_audio_file = encryptor.update( #returns a bytes object containing the encrypted ciphertext for the input plaintext
            padded_plaintext) + encryptor.finalize()

        # Concatenate the IV and the encrypted audio file, and return the result as a base64-encoded string
        encrypted_data = iv + encrypted_audio_file
        encrypted_audio_file_base64 = b64encode(encrypted_data).decode()
        return encrypted_audio_file_base64


    @staticmethod
    def decrypt_audio(encrypted_audio_file_base64: str, secret_key: str) -> str:
        backend = default_backend()
        encrypted_data = base64.b64decode(encrypted_audio_file_base64) #?????
        # encrypted_data = encrypted_audio_file_base64.encode()

        # Split the encrypted data into the IV and the encrypted audio file
        iv = encrypted_data[:16] #first 16 bytes??

        secret_key_bytes = secret_key.encode()
        

        encrypted_audio_file = encrypted_data[16:]

        # Decrypt the ciphertext
        cipher = Cipher(algorithms.AES(secret_key_bytes),
                        modes.CBC(iv), backend=backend)
        decryptor = cipher.decryptor()
        decrypted_padded_plaintext = decryptor.update(
            encrypted_audio_file) + decryptor.finalize()

        # Remove the padding from the decrypted plaintext
        padding_length = decrypted_padded_plaintext[-1]
        decrypted_audio_file_base64 = decrypted_padded_plaintext[:-padding_length]
        return decrypted_audio_file_base64.decode()

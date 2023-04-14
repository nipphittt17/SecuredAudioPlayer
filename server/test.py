import os
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend


def pad_key(key):
    valid_key_sizes = [16, 24, 32]
    key_length = len(key)
    if key_length in valid_key_sizes:
        return key
    elif key_length < valid_key_sizes[0]:
        return key + b'\0' * (valid_key_sizes[0] - key_length)
    elif key_length < valid_key_sizes[1]:
        return key + b'\0' * (valid_key_sizes[1] - key_length)
    else:
        return key + b'\0' * (valid_key_sizes[2] - key_length)


# Generate a random 256-bit key and IV
key = os.urandom(32)
iv = os.urandom(16)

# Pad the key to the valid length
key = pad_key(key)

# Define the plaintext to be encrypted
plaintext = "Hello, world!"

# Create an AES cipher with CBC mode and the specified key and IV
backend = default_backend()
cipher = Cipher(algorithms.AES(key), modes.CBC(iv), backend=backend)

# Pad the input string to a multiple of the block size
block_size = algorithms.AES.block_size // 8
padding_length = block_size - len(plaintext) % block_size
padded_plaintext = plaintext.encode(
) + bytes([padding_length] * padding_length)

# Encrypt the padded plaintext
encryptor = cipher.encryptor()
ciphertext = encryptor.update(padded_plaintext) + encryptor.finalize()

# Decrypt the ciphertext
decryptor = cipher.decryptor()
padded_decrypted_text = decryptor.update(ciphertext) + decryptor.finalize()

# Remove the padding from the decrypted text
padding_length = padded_decrypted_text[-1]
decrypted_text = padded_decrypted_text[:-padding_length].decode()

# Print the results
print("Key:", key)
print("IV:", iv)
print("Plaintext:", plaintext)
print("Ciphertext:", ciphertext)
print("Decrypted text:", decrypted_text)

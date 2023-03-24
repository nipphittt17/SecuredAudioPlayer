import random
import string


def random_string(length: int) -> str:
    characters = string.ascii_letters + string.digits
    return ''.join(random.choice(characters) for _ in range(length))

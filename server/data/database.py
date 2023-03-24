from typing import Optional


class Database:
    __secretKeysMap: dict[str, str]

    def __init__(self) -> None:
        self.__secretKeysMap = {}

    def add_key(self, filename: str, secret_key: str) -> None:
        self.__secretKeysMap[filename] = secret_key

    def get_secret_key(self, filename: str) -> Optional[str]:
        if filename not in self.__secretKeysMap:
            return None
        return self.__secretKeysMap[filename]

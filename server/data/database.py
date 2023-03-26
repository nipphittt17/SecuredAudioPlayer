from typing import Optional


class Database:
    __secretKeysMap: dict[str, dict[str, str]]

    def __init__(self) -> None:
        self.__secretKeysMap = {}

    def isValidFilename(self, id: str, filename: str) -> bool:
        if id not in self.__secretKeysMap:
            return True
        if filename in self.__secretKeysMap.get(id):
            return False
        return True

    def add_key(self, id: str, filename: str, secret_key: str) -> None:
        if id not in self.__secretKeysMap:
            self.__secretKeysMap[id] = {}
        self.__secretKeysMap[id].update({filename: secret_key})

    def get_secret_key(self, id: str, filename: str) -> Optional[str]:
        if filename not in self.__secretKeysMap[id]:
            return None
        return self.__secretKeysMap[id].get(filename)

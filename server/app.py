from flask import Flask, request, jsonify
from utils.cryptography import AES
from data.database import Database

app = Flask(__name__)
db = Database()


@app.route('/encrypt-audio-file', methods=['POST'])
def encrypt_audio_file():
    data = request.get_json()
    device_id: str = data.get("DeviceId")
    filename: str = data.get("Filename")
    raw_audio_file_base64: str = data.get('RawAudioFileBase64')

    if not device_id or not filename or not raw_audio_file_base64:
        return jsonify({'error': 'Some fields are not provided'}), 400

    generated_secret_key = AES.generate_secret_key()

    if not db.isValidFilename(device_id, filename):
        return jsonify({'error': 'Duplicated filename is not allowed'}), 400

    # store secret key in database
    db.add_key(device_id, filename, generated_secret_key)

    encrypted_audio_file_base64 = AES.encrypt_audio(
        raw_audio_file_base64,
        generated_secret_key,
    )

    return jsonify({
        'EncryptedAudioFileBase64': encrypted_audio_file_base64,
    })


@app.route('/decrypt-audio-file', methods=['POST'])
def decrypt_audio_file():
    data = request.get_json()
    device_id: str = data.get("DeviceId")
    filename: str = data.get("Filename")
    encrypted_audio_file_base64: str = data.get('EncryptedAudioFileBase64')

    if not device_id or not filename or not encrypted_audio_file_base64:
        return jsonify({'error': 'Some fields are not provided'}), 400

    secret_key = db.get_secret_key(device_id, filename)

    if secret_key is None:
        return jsonify({'error': 'No secret key is found'}), 400

    decrypted_audio_file_base64 = AES.decrypt_audio(
        encrypted_audio_file_base64,
        secret_key,
    )

    return jsonify({
        'DecryptedAudioFileBase64': decrypted_audio_file_base64,
    })


if __name__ == "__main__":
    app.run(debug=True)

    # Production
    # app.run(debug=False, host="0.0.0.0", port=8080)

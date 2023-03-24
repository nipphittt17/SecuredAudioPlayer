from flask import Flask, request, jsonify
from utils.cryptography import AES
from data.database import Database

app = Flask(__name__)
db = Database()


@app.route('/encrypt-audio-file', methods=['POST'])
def encrypt_audio_file():
    data = request.get_json()
    filename: str = data.get("Filename")
    raw_audio_file_base64: str = data.get('RawAudioFileBase64')

    if not filename and not raw_audio_file_base64:
        return jsonify({'error': 'Both Filename and RawAudioFileBase64 are not provided'}), 400
    if not filename:
        return jsonify({'error': 'Filename is not provided'}), 400
    if not raw_audio_file_base64:
        return jsonify({'error': 'RawAudioFileBase64 is not provided'}), 400

    generated_secret_key = AES.generate_random_secret_key()

    # store secret key in database
    db.add_key(filename, generated_secret_key)

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
    filename: str = data.get("Filename")
    encrypted_audio_file_base64: str = data.get('EncryptedAudioFileBase64')

    if not filename and not encrypted_audio_file_base64:
        return jsonify({'error': 'Both Filename and EncryptedAudioFileBase64 are not provided'}), 400
    if not filename:
        return jsonify({'error': 'Filename is not provided'}), 400
    if not encrypted_audio_file_base64:
        return jsonify({'error': 'EncryptedAudioFileBase64 is not provided'}), 400

    secret_key = db.get_secret_key(filename)

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

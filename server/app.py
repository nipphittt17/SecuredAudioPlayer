from flask import Flask, request, jsonify
from utils.decryption import decrypt_audio
from utils.encryption import encrypt_audio

app = Flask(__name__)


@app.route('/decrypt-audio-file', methods=['POST'])
def decrypt_audio_file():
    data = request.get_json()
    raw_audio_file_base64 = data.get('RawAudioFileBase64')

    if not raw_audio_file_base64:
        return jsonify({'error': 'RawAudioFileBase64 not provided'}), 400

    encrypted_audio_file_base64 = encrypt_audio(raw_audio_file_base64)

    return jsonify({
        'EncryptedAudioFileBase64': encrypted_audio_file_base64,
    })


@app.route('/encrypt-audio-file', methods=['POST'])
def encrypt_audio_file():
    data = request.get_json()
    encrypted_audio_file_base64 = data.get('EncryptedAudioFileBase64')

    if not encrypted_audio_file_base64:
        return jsonify({'error': 'EncryptedAudioFileBase64 not provided'}), 400

    decrypted_audio_file_base64 = decrypt_audio(encrypted_audio_file_base64)

    return jsonify({
        'DecryptedAudioFileBase64': decrypted_audio_file_base64,
    })


if __name__ == "__main__":
    app.run(debug=True)

    # Production
    # app.run(debug=False, host="0.0.0.0", port=8080)

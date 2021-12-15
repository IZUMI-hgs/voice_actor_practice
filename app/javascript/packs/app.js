// set up basic variables for app
import axios from 'axios';
axios.defaults.headers['X-Requested-With'] = 'XMLHttpRequest';
axios.defaults.headers['X-CSRF-TOKEN'] = document.getElementsByName('csrf-token')[0].getAttribute('content');
// for html
const downloadLink = document.getElementById('download');
const playback = document.getElementById('play');
const result = document.getElementById('result');

// for audio
let stream = null;
let audio_sample_rate = null;
let scriptProcessor = null;
let audioContext = null;
let mediastreamsource = null;

// audio data
let audioData = [];
let bufferSize = 1024;
let micBlobUrl = null;


//document.getElementById("start").disabled = false;
//document.getElementById("rec").disabled = true;
//document.getElementById("stop").disabled = true;
//document.getElementById("playid").disabled = true;

//録音の開始
document.addEventListener("DOMContentLoaded", function() {
    // getUserMedia
    if (!stream) {
        // getUserMediaはpromise を返す
        navigator.mediaDevices.getUserMedia({
            video: false,
            audio: true
        })
            .then(function (audio) { // promiseのresultをaudioStreamに格納
                stream = audio;
            })
            .catch(function (error) { // error
                console.error('mediaDevice.getUserMedia() error:', error);
                return;
            });
    }
    //document.getElementById("start").disabled = true;
    //document.getElementById("rec").disabled = false;
    //document.getElementById("stop").disabled = true;
    //document.getElementById("playid").disabled = true;

    return stream;
});

document.getElementById('rec').onclick = function() {
    audioData = [];
    audioContext = new AudioContext();
    audio_sample_rate = audioContext.sampleRate;
    scriptProcessor = audioContext.createScriptProcessor(bufferSize, 2, 2);
    mediastreamsource = audioContext.createMediaStreamSource(stream);
    mediastreamsource.connect(scriptProcessor);
    scriptProcessor.onaudioprocess = onAudioProcess;
    scriptProcessor.connect(audioContext.destination);
    //document.getElementById("rec").disabled = true;
    //document.getElementById("stop").disabled = false;
    //document.getElementById("playid").disabled = true;
};

// save audio data
var onAudioProcess = function (e) {
    var input = e.inputBuffer.getChannelData(0);
    var bufferData = new Float32Array(bufferSize);
    for (var i = 0; i < bufferSize; i++) {
        bufferData[i] = input[i];
    }
    audioData.push(bufferData);
};

//録音の停止
document.getElementById('stop').onclick = function() {
    saveAudio();
    //document.getElementById("rec").disabled = false;
    //document.getElementById("stop").disabled = true;
    //document.getElementById("playid").disabled = false;
}

//再生
document.getElementById('playid').onclick = function(audioBlob) {
    if (micBlobUrl) {
        playback.src = micBlobUrl;
        // 再生終了時
        playback.onended = function () {
            playback.pause();
            playback.src = "";
        };
        // 再生
        playback.play();
    }
};

//WAVに変換
let exportWAV = function (audioData) {
    let encodeWAV = function (samples, sampleRate) {
        let buffer = new ArrayBuffer(44 + samples.length * 2);
        let view = new DataView(buffer);

        let writeString = function (view, offset, string) {
            for (let i = 0; i < string.length; i++) {
                view.setUint8(offset + i, string.charCodeAt(i));
            }
        };

        let floatTo16BitPCM = function (output, offset, input) {
            for (let i = 0; i < input.length; i++, offset += 2) {
                let s = Math.max(-1, Math.min(1, input[i]));
                output.setInt16(offset, s < 0 ? s * 0x8000 : s * 0x7FFF, true);
            }
        };

        writeString(view, 0, 'RIFF');  // RIFFヘッダ
        view.setUint32(4, 32 + samples.length * 2, true); // これ以降のファイルサイズ
        writeString(view, 8, 'WAVE'); // WAVEヘッダ
        writeString(view, 12, 'fmt '); // fmtチャンク
        view.setUint32(16, 16, true); // fmtチャンクのバイト数
        view.setUint16(20, 1, true); // フォーマットID
        view.setUint16(22, 1, true); // チャンネル数
        view.setUint32(24, sampleRate, true); // サンプリングレート
        view.setUint32(28, sampleRate * 2, true); // データ速度
        view.setUint16(32, 2, true); // ブロックサイズ
        view.setUint16(34, 16, true); // サンプルあたりのビット数
        writeString(view, 36, 'data'); // dataチャンク
        view.setUint32(40, samples.length * 2, true); // 波形データのバイト数
        floatTo16BitPCM(view, 44, samples); // 波形データ
        return view;
    };

    let mergeBuffers = function (audioData) {
        let sampleLength = 0;
        for (let i = 0; i < audioData.length; i++) {
            sampleLength += audioData[i].length;
        }
        let samples = new Float32Array(sampleLength);
        let sampleIdx = 0;
        for (let i = 0; i < audioData.length; i++) {
            for (let j = 0; j < audioData[i].length; j++) {
                samples[sampleIdx] = audioData[i][j];
                sampleIdx++;
            }
        }
        return samples;
    };

    let dataview = encodeWAV(mergeBuffers(audioData), audio_sample_rate);
    let audioBlob = new Blob([dataview], { type: 'audio/wav' });
    micBlobUrl = window.URL.createObjectURL(audioBlob);
    console.log(dataview);

    let myURL = window.URL || window.webkitURL;
    let url = myURL.createObjectURL(audioBlob);
    downloadLink.href = url;
};

let saveAudio = function () {
    exportWAV(audioData);
    downloadLink.download = 'test.wav';
    audioContext.close().then(function () {
    });
};

result.onclick = function() {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', document.querySelector('#download').href, true);
  xhr.responseType = 'blob';
  xhr.send();
  xhr.onload = function(e) {
    var myBlob = this.response;
    // myBlob is now the blob that the object URL pointed to.
  let formData = new FormData();
    formData.append('quote_id', document.querySelector('#quote_id').value)
    formData.append('voice_data', myBlob, 'voice.wav');
    axios.post(document.querySelector('#voiceform').action,  formData, {
    headers: {
    'content-type': 'multipart/form-data',
    }
    }).then(response => {
      let data = response.data
      window.location.href = data.url
      }).catch(error => {
      console.log(error.response)
    })
  } 
};

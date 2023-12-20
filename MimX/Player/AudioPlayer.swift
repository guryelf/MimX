//
//  AudioPlayer.swift
//  MimX
//
//  Created by Furkan Güryel on 25.12.2023.
//

import Foundation
import AVFoundation

class AudioPlayer {
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioPlayerNode: AVAudioPlayerNode!
    var pitchEffect: AVAudioUnitTimePitch!
    var reverbEffect: AVAudioUnitReverb!
    
    init(url : String) {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        pitchEffect = AVAudioUnitTimePitch()
        reverbEffect = AVAudioUnitReverb()
        do {
            let audioURL = URL(string: url)!
            audioFile = try AVAudioFile(forReading: audioURL)
        } catch {
            fatalError("\(error.localizedDescription)")
        }
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(pitchEffect)
        audioEngine.attach(reverbEffect)
        audioEngine.connect(audioPlayerNode, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
        audioEngine.connect(pitchEffect, to: reverbEffect, format: audioFile.processingFormat)
        audioEngine.connect(reverbEffect, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
        do {
            try audioEngine.start()
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
    
    
    func play() {
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        audioPlayerNode.play()
    }
    func pause(){
        audioPlayerNode.pause()
    }
    func stop() {
        audioPlayerNode.stop()
        audioPlayerNode.reset()
    }
    func setPitch(_ pitch: Float) {
        pitchEffect.pitch = pitch
    }
    
    func setReverb(_ reverb: Float) {
        reverbEffect.wetDryMix = reverb
    }
    func setRate(_ rate: Float){
        pitchEffect.rate = rate
    }

}




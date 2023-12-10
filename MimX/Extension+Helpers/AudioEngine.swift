//
//  AudioEngine.swift
//  MimX
//
//  Created by Furkan Güryel on 6.12.2023.
//

import AVFoundation

class AudioEngineManager : ObservableObject{
    private var audioEngine = AVAudioEngine()
    private var audioPlayerNode = AVAudioPlayerNode()
    private var audioUnitTimePitch = AVAudioUnitTimePitch()

    init() {
        setupAudioEngine()
    }

    func startEngine() {
        do {
            try audioEngine.start()
        } catch {
            print("\(error.localizedDescription)")
        }
    }

    func stopEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }

    func connectNodes() {
        audioEngine.connect(audioPlayerNode, to: audioUnitTimePitch, format: nil)
        audioEngine.connect(audioUnitTimePitch, to: audioEngine.mainMixerNode, format: nil)
    }

    func attachNodes() {
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(audioUnitTimePitch)
    }

    func prepareNodes() {
        audioEngine.prepare()
    }

    func setPitchValue(_ value: Float) {
        audioUnitTimePitch.pitch = value
    }

    func play() {
        audioPlayerNode.play()
    }

    func pause() {
        audioPlayerNode.pause()
    }

    func stop() {
        audioPlayerNode.stop()
    }

    private func setupAudioEngine() {
        attachNodes()
        connectNodes()
        prepareNodes()
    }
}




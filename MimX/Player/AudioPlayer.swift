import AVFoundation

class AudioPlayer {
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFile: AVAudioFile!
    var pitchEffect: AVAudioUnitTimePitch!
    var reverbEffect: AVAudioUnitReverb!
    
    init() {
        setupAudioEngine()
    }
    
    func setupAudioEngine() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        pitchEffect = AVAudioUnitTimePitch()
        reverbEffect = AVAudioUnitReverb()
        
        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(pitchEffect)
        audioEngine.attach(reverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: pitchEffect, format: nil)
        audioEngine.connect(pitchEffect, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.mainMixerNode, format: nil)
        
        do {
            try audioEngine.start()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func playSound(withFileName fileName: String, time: Double) {
        do {
            audioFile = try AVAudioFile(forReading: URL(string: fileName)!)
            let sampleRate = audioFile.processingFormat.sampleRate
            let startFrame = AVAudioFramePosition(time * sampleRate)
            audioPlayerNode.stop()
            audioPlayerNode.scheduleSegment(audioFile, startingFrame: startFrame, frameCount: AVAudioFrameCount(audioFile.length - startFrame), at: nil, completionHandler: nil)
            
            if !audioEngine.isRunning{
                try audioEngine.start()
            }
            print("sound")
            audioPlayerNode.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stopSound() {
        audioPlayerNode.stop()
        audioPlayerNode.reset()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func updatePitch(_ pitch: Float) {
        pitchEffect.pitch = pitch
    }
    func updateRate(_ rate: Float){
        pitchEffect.rate = rate
    }
    func updateReverb(_ reverb : Float){
        reverbEffect.wetDryMix = reverb
    }
}

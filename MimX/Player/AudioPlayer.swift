import AVFoundation

class AudioPlayer {
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFile: AVAudioFile!
    var pitchEffect: AVAudioUnitTimePitch!
    
    init() {
        setupAudioEngine()
    }
    
    func setupAudioEngine() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        pitchEffect = AVAudioUnitTimePitch()

        audioEngine.attach(audioPlayerNode)
        audioEngine.attach(pitchEffect)

        audioEngine.connect(audioPlayerNode, to: pitchEffect, format: nil)
        audioEngine.connect(pitchEffect, to: audioEngine.mainMixerNode, format: nil)

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
}

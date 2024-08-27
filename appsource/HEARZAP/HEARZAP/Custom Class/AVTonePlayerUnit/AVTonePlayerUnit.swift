//
//  AVTonePlayerUnit.swift
//  HEARZAP
//
//  Created by Purushoth on 06/12/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import AVFoundation

class AVTonePlayerUnit: AVAudioPlayerNode {
    let bufferCapacity: AVAudioFrameCount = 512
    var sampleRate: Double = 44_100.0
    
    var frequency: Double = 440.0
    var amplitude: Double = 0.25
    
    private var theta: Double = 0.0
    private var audioFormat: AVAudioFormat!
    
    override init() {
        super.init()
        audioFormat = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
    }
    
    func prepareBuffer() -> AVAudioPCMBuffer {
        let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: bufferCapacity)!
        fillBuffer(buffer)
        return buffer
    }
    
    func fillBuffer(_ buffer: AVAudioPCMBuffer) {
        let data = buffer.floatChannelData?[0]
        let numberFrames = buffer.frameCapacity
        var theta = self.theta
        //        Math.round(1000000000*0.00002*Math.pow(10,decibel/20))/1000000000;
        let thetaIncrement = 2.0 * .pi * self.frequency / self.sampleRate
        for frame in 0..<Int(numberFrames) {
            data?[frame] = Float32(sin(theta) * (amplitude / 100))
            
            theta += thetaIncrement
            if theta > 2.0 * .pi {
                theta -= 2.0 * .pi
            }
        }
        buffer.frameLength = numberFrames
        self.theta = theta
        //        let data = buffer.floatChannelData?[0]
        //        let numberFrames = buffer.frameCapacity
        //        var theta = self.theta
        //        let thetaIncrement = 2.0 * .pi * 6000 / self.sampleRate
        //        for frame in 0..<Int(numberFrames) {
        //            data?[frame] = Float32(sin(theta) * 85)
        //
        //            theta += thetaIncrement
        //            if theta > 2.0 * .pi {
        //                theta -= 2.0 * .pi
        //            }
        //        }
        //        buffer.frameLength = numberFrames
        //        self.theta = theta
        //
    }
    func scheduleBuffer() {
        let buffer = prepareBuffer()
        self.scheduleBuffer(buffer) {
            if self.isPlaying {
                self.scheduleBuffer()
            }
        }
    }
    func preparePlaying() {
        scheduleBuffer()
        scheduleBuffer()
        scheduleBuffer()
        scheduleBuffer()
    }
}

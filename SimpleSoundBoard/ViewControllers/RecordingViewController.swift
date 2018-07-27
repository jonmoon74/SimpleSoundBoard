//
//  RecordingViewController.swift
//  SimpleSoundBoard
//
//  Created by Jon Moon on 22/07/2018.
//  Copyright © 2018 Jon Moon. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class RecordingViewController: UIViewController {
    
    @IBOutlet weak var recordStopButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nameTextField: UILabel!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
        saveButton.isEnabled = false
        playButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    func setupRecorder() {
        //create an audio session
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            
            //create url for audio file
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.mp3"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            
            // create settings for audioRecorder
            var settings :[String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEGLayer3) as AnyObject
            settings[AVEncoderAudioQualityKey] = AVAudioQuality.medium as AnyObject
            settings[AVSampleRateKey] = 44100.0 as AnyObject
            settings[AVNumberOfChannelsKey] = 2 as AnyObject
            
            
            //create audioRecorder object
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch {
            
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        
        let sound = Sound()
        sound.name = nameTextField.text!
        sound.audio = NSData(contentsOf: audioURL!) as Data?
        
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        } catch {}
    }
    
    @IBAction func recordStopButton(_ sender: Any) {
        
        if audioRecorder!.isRecording {
            
            //stop the recording
            audioRecorder?.stop()
            
            //change button title to record
            recordStopButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
            saveButton.isEnabled = true
        } else {
            
            //start recording
            audioRecorder?.record()
            
            //change button title to stop
            recordStopButton.setTitle("Stop", for: .normal)
        }
        
    }
    
}







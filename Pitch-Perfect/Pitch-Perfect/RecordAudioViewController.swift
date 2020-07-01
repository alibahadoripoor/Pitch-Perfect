//
//  RecordAudioViewController.swift
//  Pitch-Perfect
//
//  Created by Ali Bahadori on 20.06.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    // MARK: Audio Recorder
    
    var audioRecorder: AVAudioRecorder!
    
    // MARK: View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notRecording)
    }
    
    // MARK: Actions
    
    @IBAction func record(_ sender: AnyObject){
        startRecording()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject){
        stopRecording()
    }
    
}



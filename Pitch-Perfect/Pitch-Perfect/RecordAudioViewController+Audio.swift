//
//  RecordAudioViewController+Audio.swift
//  Pitch-Perfect
//
//  Created by Ali Bahadori on 01.07.20.
//  Copyright © 2020 Ali Bahadori. All rights reserved.
//

import UIKit
import AVFoundation

//MARK: - RecordAudioViewController: AVAudioRecorderDelegate

extension RecordAudioViewController: AVAudioRecorderDelegate{
    
    //MARK: Recording states
    
    enum RecordingState{ case recording, notRecording }
    
    //MARK: Recording Functions
    
    func startRecording(){
        do{
            configureUI(.recording)
            
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
            let recordingName = "recordedVoice.wav"
            let pathArray = [dirPath, recordingName]
            let filePath = URL(string: pathArray.joined(separator: "/"))

            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

            try audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        }catch{
            showAlert(Alerts.RecordingFailedTitle, message: String(describing: error))
        }
    }
    
    func stopRecording(){
        do{
            configureUI(.notRecording)
            
            audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setActive(false)
        }catch{
            showAlert(Alerts.RecordingFailedMessage, message: String(describing: error))
        }
    }
    
    // MARK: AVAudioRecorderDelegate Functions
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: recorder.url)
        }else{
            showAlert(Alerts.RecordingFailedMessage, message: "Recording was not successful")
        }
    }
    
    // MARK: Preparing Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            if let playSoundVC = segue.destination as? PlaySoundsViewController,
                let url = sender as? URL{
                playSoundVC.recordedAudioURL = url
            }
        }
    }
    
    //MARK: UI Functions
    
    func configureUI(_ recordState: RecordingState){
        switch recordState {
        case .recording:
            recordingLabel.text = "Recording in Progress..."
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        case .notRecording:
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
            recordingLabel.text = "Tap to Record"
        }
    }
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

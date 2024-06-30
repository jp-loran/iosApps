//
//  ViewController.swift
//  P1-M9
//
//  Created by Juan Pablo Alvarez Loran on 29/06/24.
//

import UIKit
import Network
import Foundation
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    @IBOutlet weak var playPauseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkInternetAndDownload()
    }

    @IBAction func playTapped(_ sender: Any) {
        if isPlaying {
             audioPlayer?.pause()
             playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
         } else {
             audioPlayer?.play()
             playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
         }
         isPlaying.toggle()
    }
    
    func checkInternetConnection(completion: @escaping (Bool, Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        
        monitor.pathUpdateHandler = { path in
            let isConnected = path.status == .satisfied
            
            let isWiFi = path.usesInterfaceType(.wifi)
            
            let wiredEthernet = path.usesInterfaceType(.wiredEthernet)
            
            completion(isConnected, isWiFi || wiredEthernet)
            monitor.cancel()
        }
        
        monitor.start(queue: queue)
    }
    
    
    func downloadAudioFile(to destinationURL: URL) {
        guard let url = URL(string: "http://janzelaznog.com/DDAM/iOS/imperial-march.mp3") else { return }
        let task = URLSession.shared.downloadTask(with: url) { localURL, response, error in
            if let localURL = localURL {
                do {
                    try FileManager.default.moveItem(at: localURL, to: destinationURL)
                    print("Descargado en: \(destinationURL)")
                    self.prepareAudioPlayer(with: destinationURL)
                } catch {
                    self.showAlert(message: "Error al guardar archivo: \(error.localizedDescription)")
                }
            } else if let error = error {
                self.showAlert(message: "Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func showAlert(message: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
    }
        
    
    func checkInternetAndDownload() {
           checkInternetConnection { (isConnected, isWiFiOrEthernet) in
               if isConnected {
                   if isWiFiOrEthernet {
                       self.downloadAudioFileIfNeeded()
                   } else {
                       self.showAlert(message: "Necesitas una conexión wifi para la descarga.")
                   }
               } else {
                   self.showAlert(message: "No hay conexión a internet.")
               }
           }
       }
    
    func downloadAudioFileIfNeeded() {
          let libraryDirectory = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
          let destinationURL = libraryDirectory.appendingPathComponent("imperial-march.mp3")
          
          // Verificar si el archivo ya existe
          if FileManager.default.fileExists(atPath: destinationURL.path) {
              print("Ya existe el archivo: \(destinationURL)")
              self.prepareAudioPlayer(with: destinationURL)
          } else {
              downloadAudioFile(to: destinationURL)
          }
      }
    
    func prepareAudioPlayer(with url: URL) {
          do {
              audioPlayer = try AVAudioPlayer(contentsOf: url)
              audioPlayer?.prepareToPlay()
          } catch {
              showAlert(message: "Error en el reproductor de audio: \(error.localizedDescription)")
          }
    }
}


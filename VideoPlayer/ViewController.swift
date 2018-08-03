//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Soemsak on 3/8/2561 BE.
//  Copyright © 2561 Soemsak. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var containerView: UIImageView!
    private var imageView: UIImageView!
    private var isUserSubscribed = true
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.tag = 1
        
        // Video
        let url = URL(string: "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")!
        let avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
        let avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.frame = containerView.bounds
        containerView.layer.insertSublayer(avPlayerLayer, at: 0)
        
        // Image
        imageView = UIImageView(image: UIImage(named: "someImage"))
        imageView.frame = containerView.frame
        containerView.addSubview(imageView)
        
        // Condition
        if isUserSubscribed {
            imageView.isHidden = true
            loopVideo(videoPlayer: avPlayer)
        } else {
            imageView.isHidden = false
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(tapGestureRecognizer)
        
        if containerView.tag == 1 {
            avPlayer.isMuted = false
        } else {
            avPlayer.isMuted = true
        }
    }

    func loopVideo(videoPlayer: AVPlayer) {
        videoPlayer.play()
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            videoPlayer.seek(to: kCMTimeZero)
            videoPlayer.play()
            videoPlayer.isMuted = true
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if tapGestureRecognizer.view?.tag == 0 {
            tapGestureRecognizer.view?.tag = 1
        } else {
            tapGestureRecognizer.view?.tag = 0
        }
        view.reloadInputViews()
        print("Data" , tapGestureRecognizer.view?.tag)
    }
    
}


//
//  ViewController.swift
//  Images
//
//  Created by jinn on 23/10/2022.
//

import UIKit
import FirebaseStorage


class ViewController: UIViewController {
    var file : String?
    @IBOutlet var uploadImage: UIImageView!
    @IBOutlet var downloadImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()}

    @IBAction func uploadButton(_ sender: UIButton) {
        guard let image = uploadImage.image , let file = file else {return}
        guard let imageData = image.pngData() else {return}
        let ref = Storage.storage().reference()
        let uploadRef = ref.child("IMAGES").child(file)
        let upload = uploadRef.putData(imageData, metadata: nil) { metadata, error in
            if error == nil {
                print("success upload")
            }
        }
        upload.observe(.progress) { snap in
            print(snap.progress)
        }
        upload.resume()
        
    }
    
    @IBAction func downloadButton(_ sender: UIButton) {
        let refd = Storage.storage().reference().child("IMAGES").child("nature.jpg")
        let download = refd.getData(maxSize: 1024 * 1024 * 12) { data, error in
            if let data = data {
                let image = UIImage(data: data)
                self.downloadImage.image = image
            }
        }
        download.observe(.progress) { snap in
            print(snap.progress)
        }
        download.resume()
    }
}


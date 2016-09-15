//
//  FeedVC.swift
//  SocialMediaApp
//
//  Created by Grzegorz Kwaśniewski on 10/09/16.
//  Copyright © 2016 Grzegorz Kwaśniewski. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var posts = [Post]()
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectImageButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // we set observer to listen for changes on POSTS end point
        DataService.ds.REF_POSTS.observe(.value, with: {(snapshot) in
            self.posts = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    if let snapDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key // it default property from Firebase
                        let post = Post(postID: key, postData: snapDictionary)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CellFeed") as? CellFeed {
            cell.configureCell(post: posts[indexPath.row])
            return cell
        } else {
            return CellFeed()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                selectImageButton.image = image
        } else {
            print("Valid image was not selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPhotoAction(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func forTestsOnlyAction(_ sender: AnyObject) {
        let keychainResult = KeychainWrapper.removeObjectForKey(KEY_UID)
        print("KEYCHAIN: Keychain was removed - \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        self.dismiss(animated: true, completion: nil)
    }
}

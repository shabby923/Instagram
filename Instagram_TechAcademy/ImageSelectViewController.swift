//
//  ImageSelectViewController.swift
//  Instagram_TechAcademy
//
//  Created by 櫻井 敬紹 on 2016/12/04.
//  Copyright © 2016年 shabby923. All rights reserved.
//

import UIKit

class ImageSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,AdobeUXImageEditorViewControllerDelegate {
    
    @IBAction func handleLibraryButton(_ sender: Any) {
        //ライブラリを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCameraButton(_ sender: Any) {
        //カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        //画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if info[UIImagePickerControllerOriginalImage] != nil {
            
        // 撮影/選択された画像を取得する
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //後でadobeUXImageEditorを起動する
        //AdobeUXImageEditorで、受けとったimageを加工できる
        //ここでpresentViewControllerを呼び出しても表示されないためメソッドが終了してから呼ばれるようにする
            DispatchQueue.main.async {
                //adobeImageEditorを起動する
                let adobeViewController = AdobeUXImageEditorViewController(image: image)
                adobeViewController.delegate = self
                self.present(adobeViewController, animated: true, completion: nil)
            }
            
        }
        //閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func photoEditor(_ editor: AdobeUXImageEditorViewController, finishedWith image: UIImage?) {
        
        //画像加工画面を閉じる
        editor.dismiss(animated: true, completion: nil)
        
        //投稿の画面を開く
        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        postViewController.image = image
        present(postViewController, animated: true, completion: nil)
    }
    
    //AdobeImageEditorで加工をキャンセルした時に呼ばれる
    func photoEditorCanceled(_ editor: AdobeUXImageEditorViewController) {
        //加工画面を閉じる
        editor.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

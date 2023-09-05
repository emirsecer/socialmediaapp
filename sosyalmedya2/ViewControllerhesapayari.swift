import UIKit
import CoreData

class ViewControllerhesapayari: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var iimageview: UIImageView!
    
    // Core Data'da kullanılacak değişkenler
    var managedContext: NSManagedObjectContext!
    var fotografVeri: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Core Data context'ini alın
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        iimageview.isUserInteractionEnabled = true
        iimageview.addGestureRecognizer(tapGestureRecognizer)
        
        // Kaydedilmiş fotoğraf varsa, görüntüyü yükle
        fetchFotografVeri()
    }
    
    @objc func imageTapped() {
        openImagePicker()
    }
    
    func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true // Düzenleme aktif
        present(imagePicker, animated: true, completion: nil)
    }
    
    func saveImageToCoreData(imageData: Data) {
        // Core Data'ya kaydetme işlemi
        if let entity = NSEntityDescription.entity(forEntityName: "Fotograf_veri", in: managedContext) {
            if fotografVeri == nil {
                fotografVeri = NSManagedObject(entity: entity, insertInto: managedContext)
            }
            
            fotografVeri?.setValue(imageData, forKey: "fotograf")
            
            do {
                try managedContext.save()
                print("Fotoğraf başarıyla kaydedildi.")
            } catch let error as NSError {
                print("Kaydetme hatası: \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetchFotografVeri() {
        // Kaydedilmiş fotoğrafı çekme işlemi
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Fotograf_veri")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let fetchedFotografVeri = results.first as? NSManagedObject,
               let imageData = fetchedFotografVeri.value(forKey: "fotograf") as? Data,
               let image = UIImage(data: imageData) {
                iimageview.image = image
                fotografVeri = fetchedFotografVeri
            }
        } catch let error as NSError {
            print("Fotoğraf çekme hatası: \(error), \(error.userInfo)")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if let imageData = editedImage.pngData() {
                saveImageToCoreData(imageData: imageData)
            }
            iimageview.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let imageData = originalImage.pngData() {
                saveImageToCoreData(imageData: imageData)
            }
            iimageview.image = originalImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


import UIKit

class ViewControllergiris: UIViewController, UITextFieldDelegate {
    let appdelagate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    @IBOutlet weak var sifretext: UITextField!
    @IBOutlet weak var epostatext: UITextField!

    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        epostatext.delegate = self
        sifretext.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @IBAction func girisyapbutton(_ sender: Any) {
        if let savedEmail = userDefaults.string(forKey: "email"),
           let savedPassword = userDefaults.string(forKey: "password") {
            if epostatext.text == savedEmail && sifretext.text == savedPassword {
                // Doğru e-posta ve şifre, giriş yapabilirsiniz.
                performSegue(withIdentifier: "toanasayfavc", sender: nil)
               
            } else {
                // Hatalı e-posta veya şifre, hata mesajı göster.
                alertOlustur(titleGirdisi: "Hata!", messageGirdisi: "Yanlış E-posta veya Şifre")
            }
        } else {
            // Kayıtlı e-posta veya şifre yok.
            alertOlustur(titleGirdisi: "Hata!", messageGirdisi: "Kayıtlı Kullanıcı Bulunamadı")
        }
        
        
        
    }

    func setupBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.brown.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func alertOlustur(titleGirdisi: String, messageGirdisi: String) {
        let uyariMesaji = UIAlertController(title: titleGirdisi, message: messageGirdisi, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            print("OK butonuna tıklandı")
        }
        
        uyariMesaji.addAction(okButton)
        
        self.present(uyariMesaji, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}


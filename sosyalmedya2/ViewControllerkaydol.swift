import UIKit

class ViewControllerkaydol: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!

    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        password2TextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        navigationController?.navigationBar.tintColor = UIColor.black
    }

    @IBAction func signUpTiklandi(_ sender: Any) {
        if emailTextField.text == "" {
            alertOlustur(titleGirdisi: "Hata!", messageGirdisi: "Email Eksik")
        } else if !isValidEmail(emailTextField.text) {
            alertOlustur(titleGirdisi: "Hata!", messageGirdisi: "Geçerli Bir E-posta Giriniz")
        } else if passwordTextField.text == "" {
            alertOlustur(titleGirdisi: "Hata!", messageGirdisi: "Parola Eksik")
        } else if passwordTextField.text?.count ?? 0 < 6 {
            alertOlustur(titleGirdisi: "Hata!", messageGirdisi: "Parola En Az 6 Karakter Olmalı")
        } else if passwordTextField.text != password2TextField.text {
            alertOlustur(titleGirdisi: "Hata!", messageGirdisi: "Parolalar Uyuşmuyor")
        } else {
            // Başarılı kayıt: Kullanıcıyı UserDefaults'a kaydet.
            if let enteredEmail = emailTextField.text,
               let enteredPassword = passwordTextField.text {
                saveUser(email: enteredEmail, password: enteredPassword)
                alertOlustur(titleGirdisi: "Tebrikler!", messageGirdisi: "Kullanıcı Oluşturuldu")
                
            }
        }
    }

    func isValidEmail(_ email: String?) -> Bool {
        if let email = email {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        }
        return false
    }

    func alertOlustur(titleGirdisi: String, messageGirdisi: String) {
        let uyariMesaji = UIAlertController(title: titleGirdisi, message: messageGirdisi, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            print("OK butonuna tıklandı")
        }
        
        uyariMesaji.addAction(okButton)
        
        self.present(uyariMesaji, animated: true, completion: nil)
    }
    
    func setupBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.brown.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Klavyeyi kapat
        return true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // Boş bir yere tıklanınca klavyeyi kapat
    }
    
    // Kullanıcıyı UserDefaults'a kaydetme
    func saveUser(email: String, password: String) {
        userDefaults.set(email, forKey: "email")
        userDefaults.set(password, forKey: "password")
        userDefaults.set(true, forKey: "loggedIn")
        userDefaults.synchronize() // Değişiklikleri kaydet
    }
}



import UIKit
import InPlayerSDK
import SafariServices
class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var accountNameLabel: UILabel!

    var socialURLs: [InPlayerSocialUrl] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        getSocialURLs()
    }

    private func getSocialURLs() {
        InPlayer.Account.getSocialUrls(redirectUri: "app.inplayer://", success: { (socialUrls) in
            self.socialURLs = socialUrls
            self.tableView.reloadData()
        }) { (error) in
            self.accountNameLabel.text = error.localizedDescription
        }
    }

    private func loginWithSocial(index: Int) {
        let social = socialURLs[index]
        if let url = social.url {
            InPlayer.Account.socialLogin(withUrl: url) { (account, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let account = account, let accountName = account.fullName {
                        self.accountNameLabel.text = "Welcome " + accountName
                    }
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loginWithSocial(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialURLs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.textAlignment = .center

        let social = socialURLs[indexPath.row]
        cell.textLabel?.text = social.name?.capitalized

        return cell
    }
}

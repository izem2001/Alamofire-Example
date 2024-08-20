import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AF.request("https://jsonplaceholder.typicode.com/posts").responseDecodable(of:[Post].self ){response in
            switch response.result {
            case .success(let posts):
                self.posts = posts
                self.tableView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }

        
        tableView.dataSource = self
        tableView.delegate = self
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let post = posts[indexPath.row]
        cell.textLabel?.text = "\(post.id)-\(post.title)"
        return cell
    }

}
struct Post: Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

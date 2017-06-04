
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref:FIRDatabaseReference!
    var users: [String] = []
    
    let refreshControl = UIRefreshControl()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // pull to refresh
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        ref = FIRDatabase.database().reference()
        
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref = FIRDatabase.database().reference()
        ref.child("users").child(userID!).child("teams").observeSingleEvent(of: .value, with: { (snapshot) in
            var newItems: [String] = []
            if !(snapshot.value is NSNull){
                var value = (snapshot.value as? Array<String>)!
                
                for item in value{
                    newItems.append(item)
                }
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.users = newItems
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func refresh() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    //creates new user
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! iQuizTableViewCell
        let groceryItem = users[indexPath.row]
        print("cell # \(indexPath.row) selected")
        
        cell.questionLabel.text = groceryItem
        
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
}



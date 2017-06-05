
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var ref:FIRDatabaseReference!
  var users: [String] = []
  var selectedName = ""
  let refreshControl = UIRefreshControl()
  
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.refreshControl = refreshControl
    tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    
update()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  func refresh() {
    update()
    tableView.reloadData()
    tableView.refreshControl?.endRefreshing()
  }
  
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
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! iQuizTableViewCell
    let groceryItem = users[indexPath.row]
    print("cell # \(indexPath.row) selected")
    
    selectedName =  groceryItem
    
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! TeamDetailViewController
    vc.team = selectedName
    self.present(vc, animated: true, completion: nil)
  }
    
    func update(){
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//      
//        if segue.identifier == "toTeamDetail" {
//            let destination = segue.destination as! TeamDetailViewController
//            destination.team = selectedName // replace with selected team/firebase identifier
//        }
//    }
}



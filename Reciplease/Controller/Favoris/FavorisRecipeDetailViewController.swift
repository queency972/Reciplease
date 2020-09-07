//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Steve Bernard on 29/07/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

class FavoriteListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    private var coreDataManager: CoreDataManager?
    private var dataInCoreData = [RecipeEntity]()
    private var recipeEntity: RecipeEntity?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // Transition, data controller to controller (Prepare Seg)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // guard let favoriteDetailsVC = segue.destination as?
        // Modif favoriteDetails...
        //            RecipeDetailViewController else {return}
        //       favoriteDetailsVC.coreDataManager = coreDataManager
    }
}

extension FavoriteListViewController: UITableViewDataSource, UITableViewDelegate {
    // Number of element in recipes.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.recipes.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipesCell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell
            else { return UITableViewCell() }

        recipesCell.recipeEntity = coreDataManager?.recipes[indexPath.row]
        return recipesCell
    }
    // Set height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    // Allowing to get information for the cell Selected from XIB.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Run transition.
        performSegue(withIdentifier: "favoris", sender: nil)
    }
    // Use heightForFooterInSection (line) if necessary
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.recipes.isEmpty ?? true ? 50 : 0
    }
}
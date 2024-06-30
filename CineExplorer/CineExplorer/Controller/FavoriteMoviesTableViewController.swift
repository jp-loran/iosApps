//
//  FavoriteMoviesTableViewController.swift
//  CineExplorer
//
//  Created by Juan Pablo Alvarez Loran on 06/06/24.
//

import UIKit
import CoreData

class FavoriteMoviesTableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favoriteMovies: [FavoriteMovie] = []
    let manager = MovieServiceManager()
    var noFavoritesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noFavoritesLabel = UILabel()
        noFavoritesLabel.text = "No favorite movies"
        noFavoritesLabel.textAlignment = .center
        noFavoritesLabel.textColor = .gray
        noFavoritesLabel.font = UIFont.systemFont(ofSize: 20)
        
        fetchFavoriteMovies()

    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            fetchFavoriteMovies()
    }
    
    func fetchFavoriteMovies() {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        
        do {
            favoriteMovies = try context.fetch(fetchRequest)
            print(favoriteMovies)
            if favoriteMovies.isEmpty {
                tableView.backgroundView = noFavoritesLabel
            } else {
                tableView.backgroundView = nil
            }
            tableView.reloadData()
        } catch {
            print("Error fetching favorite movies: \(error.localizedDescription)")
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell", for: indexPath) as! FavoriteMoviesTableViewCell
        
        let favoriteMovie = favoriteMovies[indexPath.row]
        
        cell.movieTitle?.text = favoriteMovie.title
        
        let posterPath = favoriteMovie.posterPath!
        let urlString = manager.getPoster(posterPath: posterPath)
        if let url = URL(string: urlString) {
            cell.movieImage.sd_setImage(with: url)
        }
            
        cell.movieAdult?.text = favoriteMovie.adult ? "Yes" : "No"
        cell.movieLanguage?.text = favoriteMovie.originalLanguage?.uppercased()
        cell.movieRating.voteAverage = favoriteMovie.voteAverage / 2.0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return "Favorite Movies"
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
               guard let self = self else { return }
               let favoriteMovieToDelete = self.favoriteMovies[indexPath.row]
               
               self.context.delete(favoriteMovieToDelete)
               do {
                   try self.context.save()
                   self.favoriteMovies.remove(at: indexPath.row)
                   tableView.deleteRows(at: [indexPath], with: .automatic)
                   if self.favoriteMovies.isEmpty {
                       self.tableView.backgroundView = self.noFavoritesLabel
                   }
                   let snackBar = SnackBar(message: "Favorite movie deleted")
                   snackBar.show(in: self.view)
               } catch {
                   print("Error deleting favorite movie: \(error.localizedDescription)")
               }
               
               completionHandler(true)
           }
           
           deleteAction.backgroundColor = .red
           
           let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
           configuration.performsFirstActionWithFullSwipe = true
           
           return configuration
       }
}

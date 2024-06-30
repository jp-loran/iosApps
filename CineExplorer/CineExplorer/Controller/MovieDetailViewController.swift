//
//  MovieDetailViewController.swift
//  CineExplorer
//
//  Created by Juan Pablo Alvarez Loran on 28/05/24.
//

import UIKit
import SDWebImage
import CoreData

class MovieDetailViewController: UIViewController {

    var movie: Movie?
    let manager = MovieServiceManager()
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var starRating: StarRatingView!
    @IBOutlet weak var movieRelease: UILabel!
    @IBOutlet weak var movieOnlyAdults: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    var isFavorite = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
          if let movie = movie {

              let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
              fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)
              fetchRequest.fetchLimit = 1
              
              do{
                  let existsFavorite = try context.fetch(fetchRequest)
                  if let existsFavorite = existsFavorite.first {
                      favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                      isFavorite=true
                  } else {
                      favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
                      isFavorite=false
                  }
              }catch {
                 print("Error")
              }
              
              
              movieTitle.text=movie.title
              let urlString = URL(string: manager.getPoster(posterPath: movie.posterPath))
              moviePoster.sd_setImage(with: urlString)
              
              movieOverview.isEditable = false
              movieOverview.text = movie.overview
              starRating.voteAverage = movie.voteAverage / 2.0
              movieRelease.text = movie.releaseDate
              movieOnlyAdults.text = movie.adult ? "Yes" : "No"
              movieLanguage.text = movie.originalLanguage.uppercased()
          }
      }
    
    
    @IBAction func favoriteButtonTap(_ sender: Any) {
        isFavorite.toggle()
       
       if isFavorite {
           favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
           
           let newFavorite = FavoriteMovie(context: self.context)
           if let movieId = movie?.id {
               newFavorite.id = Int64(movieId)
           }
           newFavorite.title = movie?.title
           newFavorite.adult = ((movie?.adult) != nil)
           newFavorite.releaseDate = movie!.releaseDate
           newFavorite.voteAverage = movie!.voteAverage
           newFavorite.originalLanguage = movie?.originalLanguage
           newFavorite.posterPath = movie?.posterPath
           newFavorite.overview = movie?.overview
           
           do {
               try context.save()
               let snackBar = SnackBar(message: "Favorite movie added")
               snackBar.show(in: self.view)
               
           } catch {
               print("Error al guardar")
           }
       } else {
           favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
           if let movieId = movie?.id {
                     let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
                     fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
                     fetchRequest.fetchLimit = 1
                     
                     do {
                         let existsFavorite = try context.fetch(fetchRequest)
                         if let favoriteToDelete = existsFavorite.first {
                             context.delete(favoriteToDelete)
                             try context.save()
                             let snackBar = SnackBar(message: "Favorite movie removed")
                             snackBar.show(in: self.view)
                         }
                     } catch {
                         print("Error deleting favorite movie: \(error.localizedDescription)")
                     }
                 } else {
                     print("Movie ID is nil")
                 }
       }
        
        
    }
}

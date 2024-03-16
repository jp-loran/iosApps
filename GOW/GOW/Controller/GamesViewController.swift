//
//  GamesViewController.swift
//  GOW
//
//  Created by Juan Pablo Alvarez Loran on 08/03/24.
//

import UIKit

class GamesViewController: UIViewController {

    let gamePoster = Array(0...7)
    @IBOutlet weak var gamePosterPageControl: UIPageControl!
    @IBOutlet weak var gamePosterImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gamePosterPageControl.numberOfPages = gamePoster.count
        gamePosterImage.image = UIImage(named: String(gamePoster.first!))
        // Do any additional setup after loading the view.
    }
    

    @IBAction func leftSwipeAction(_ sender: Any) {
        if gamePosterPageControl.currentPage == gamePoster.count-1  {
            gamePosterPageControl.currentPage = 0
            gamePosterImage.image = UIImage(named: String(gamePoster[gamePosterPageControl.currentPage]))
        }
        else{
            gamePosterPageControl.currentPage = gamePosterPageControl.currentPage + 1
            gamePosterImage.image = UIImage(named: String(gamePoster[gamePosterPageControl.currentPage]))
        }
        gamePosterPageControl.setCurrentPageIndicatorImage(UIImage(named: "gow_logo"), forPage: gamePosterPageControl.currentPage)
    }
    @IBAction func rightSwipeAction(_ sender: Any) {
        if gamePosterPageControl.currentPage == 0 {
             gamePosterPageControl.currentPage = gamePoster.count - 1
         } else {
             gamePosterPageControl.currentPage = gamePosterPageControl.currentPage - 1
         }
         gamePosterImage.image = UIImage(named: String(gamePoster[gamePosterPageControl.currentPage]))

         gamePosterPageControl.setCurrentPageIndicatorImage(UIImage(named: "gow_logo"), forPage: gamePosterPageControl.currentPage)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

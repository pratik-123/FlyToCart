//
//  ViewController.swift
//  FlyToCart
//
//  Created by Pratik Lad on 03/09/17.
//  Copyright © 2017 Pratik Lad. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var buttonCart: UIButton!
    @IBOutlet weak var lableNoOfCartItem: UILabel!
    @IBOutlet weak var tableViewProduct: UITableView!
    
    var counterItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewProduct.delegate = self
        tableViewProduct.dataSource = self
        
        lableNoOfCartItem.layer.cornerRadius = lableNoOfCartItem.frame.size.height / 2
        lableNoOfCartItem.clipsToBounds = true
        
    }
    
    //MARK: TableView Delegate method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductCell.self)) as! ProductCell
        
        
        return cell
    }
    
    
    @IBAction func buttonHandlerAddToCart(_ sender: UIButton) {
        
        let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: self.tableViewProduct)
        
        let indexPath = self.tableViewProduct.indexPathForRow(at: buttonPosition)!
        
        let cell = tableViewProduct.cellForRow(at: indexPath) as! ProductCell
        
        let imageViewPosition : CGPoint = cell.imageViewProduct.convert(cell.imageViewProduct.bounds.origin, to: self.view)
        
        
        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.imageViewProduct.frame.size.width, height: cell.imageViewProduct.frame.size.height))
        
        imgViewTemp.image = cell.imageViewProduct.image
        
        animation(tempView: imgViewTemp)
        
    }
    
    
    func animation(tempView : UIView)  {
        self.view.addSubview(tempView)
        UIView.animate(withDuration: 1.0,
                       animations: {
                        tempView.animationZoom(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                tempView.animationZoom(scaleX: 0.2, y: 0.2)
                tempView.animationRoted(angle: CGFloat(Double.pi))
                
                tempView.frame.origin.x = self.buttonCart.frame.origin.x
                tempView.frame.origin.y = self.buttonCart.frame.origin.y
                
            }, completion: { _ in
                
                tempView.removeFromSuperview()
                
                UIView.animate(withDuration: 1.0, animations: {
                    
                    self.counterItem += 1
                    self.lableNoOfCartItem.text = "\(self.counterItem)"
                    self.buttonCart.animationZoom(scaleX: 1.4, y: 1.4)
                }, completion: {_ in
                    self.buttonCart.animationZoom(scaleX: 1.0, y: 1.0)
                })
                
            })
            
        })
    }
}

extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
}

import UIKit

    class MenuDrawerViewTableCell: UITableViewCell {

        let menuTitleView = UILabel()
        let menuIconImageView = UIImageView()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            let screenSize = UIScreen.main.bounds.width*0.7
            let width1Third = screenSize/3
            let width2Third = width1Third*2
            let widthQuarter = screenSize/4

            //menuTitleView.translatesAutoresizingMaskIntoConstraints = false
            menuTitleView.frame = CGRect(x: 60, y: 12.5, width: width2Third, height: 20)
            menuTitleView.font = UIFont.systemFont(ofSize: 14)
            menuTitleView.textColor = UIColor(red: 84/255.0, green: 96/255.0, blue: 103/255.0, alpha: 1.0) //DARK Grey
            contentView.addSubview(menuTitleView)
            
            //menuIconImageView.translatesAutoresizingMaskIntoConstraints = false
            menuIconImageView.frame = CGRect(x: 20, y: 10, width: 25, height: 25)
            menuIconImageView.alpha = 0.8
            //menuIconImageView.image = #imageLiteral(resourceName: "LogoCircle")
            contentView.addSubview(menuIconImageView)
            
            /*
            NSLayoutConstraint.activate([
                hatchName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                hatchName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
                hatchName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                hatchName.heightAnchor.constraint(equalToConstant: 50)
            ])
     */
        }
        
        
        
      
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }


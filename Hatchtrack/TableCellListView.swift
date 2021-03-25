import UIKit

class TableCellListView: UITableViewCell {

    let hatchName = UILabel()
    let eggCountType = UILabel()
    let speciesLabel = UILabel()
    let dayCount = UILabel()
    let completedDayCount = UILabel()
    let customImageView = UIImageView()
    var hatchUUID = String()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let cellWidth = UIScreen.main.bounds.width
        let width1Third = cellWidth/3
        let width2Third = width1Third*2

        let hatchtrackRed = UIColor(red: 208/255.0, green: 105/255.0, blue: 80/255.0, alpha: 1.0)
        
        let titleOffsetX:CGFloat = 100.0
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: cellWidth - 20, height: 110))

        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.8])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.05
        contentView.addSubview(whiteRoundedView)
        //cell.contentView.sendSubview(toBack: whiteRoundedView)
        
        
        //speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        speciesLabel.frame = CGRect(x: titleOffsetX, y: 15, width: width1Third*3-90, height: 30)
        speciesLabel.textColor = hatchtrackRed
        speciesLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 27.0)
        contentView.addSubview(speciesLabel)
        
        //eggCountType.translatesAutoresizingMaskIntoConstraints = false
        eggCountType.frame = CGRect(x: cellWidth - 98, y: 17, width: 80, height: 28)
        eggCountType.textColor = hatchtrackRed
        eggCountType.textAlignment = .center
        eggCountType.layer.borderWidth = 1.0
        eggCountType.layer.borderColor = hatchtrackRed.cgColor
        eggCountType.layer.cornerRadius = 14.0
        eggCountType.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        contentView.addSubview(eggCountType)
        
        //hatchName.translatesAutoresizingMaskIntoConstraints = false
        hatchName.frame = CGRect(x: titleOffsetX+1, y: 46, width: width2Third, height:27)
        hatchName.textColor = hatchtrackRed
        hatchName.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(hatchName)
                        
       // dayCount.translatesAutoresizingMaskIntoConstraints = false
        dayCount.frame = CGRect(x: titleOffsetX, y: 75, width: width2Third, height: 30)
        dayCount.textColor = UIColor(red: 67/255.0, green: 93/255.0, blue: 132/255.0, alpha: 1.0)
        dayCount.font = UIFont.systemFont(ofSize: 26)
        contentView.addSubview(dayCount)
        
       // completedDayCount.translatesAutoresizingMaskIntoConstraints = false
        completedDayCount.frame = CGRect(x: titleOffsetX, y: 75, width: width2Third, height: 30)
        completedDayCount.textColor = UIColor(red: 0, green: 195/255.0, blue: 0, alpha: 1.0) //Green
        completedDayCount.font = UIFont.systemFont(ofSize: 20) //compeled = 20, daycount = 26, hatchname = 20, species = 16
        completedDayCount.isHidden = true
        contentView.addSubview(completedDayCount)
        
        let imageViewSpeciesHeight = 90.0
        let imageViewSpeciesWidth = imageViewSpeciesHeight*0.75
        //customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.frame = CGRect(x: 20, y: 18, width: imageViewSpeciesWidth, height: imageViewSpeciesHeight)
        //customImageView.clipsToBounds = true
        //customImageView.layer.cornerRadius = CGFloat(imageViewSpeciesHeight/2)
        //customImageView.alpha = 0.3
        //customImageView.image = #imageLiteral(resourceName: "species_chicken")
        contentView.addSubview(customImageView)
        
        
        
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

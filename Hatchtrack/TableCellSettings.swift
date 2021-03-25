import UIKit

class TableCellSettings: UITableViewCell {

    let toggle_switch = UISwitch()
    let settings_input = UITextField()
    let borderBottom:UIView = UIView()
    let titleLabel:UILabel = UILabel()
    let eggPicker:UIPickerView = UIPickerView()
    //let eggCountType = UILabel()
    //let dayCount = UILabel()
    //let customImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let padding:CGFloat = 20.0
        let cellWidth:CGFloat = UIScreen.main.bounds.width - padding*2
        let width1Third:CGFloat = cellWidth/3
        
        let switchWidth:CGFloat = 51.0;
        let switchHeight:CGFloat = 44.0;
        
        titleLabel.frame = CGRect(x: padding, y: 0, width: cellWidth, height: switchHeight)
        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.isHidden = true
        contentView.addSubview(titleLabel)
        
        settings_input.frame = CGRect(x: padding, y: 0, width: cellWidth, height: switchHeight)
        settings_input.textColor = .gray
        settings_input.font = UIFont.systemFont(ofSize: 18)
        settings_input.isHidden = true
        contentView.addSubview(settings_input)
        
        borderBottom.frame = CGRect(x: 0, y: switchHeight-1, width: cellWidth, height: 1)
        borderBottom.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
        settings_input.addSubview(borderBottom)
        
        toggle_switch.frame = CGRect(x: cellWidth-switchWidth+padding, y: 0, width: switchWidth, height: switchHeight)
        toggle_switch.isHidden = true
        contentView.addSubview(toggle_switch)
        
        eggPicker.frame = CGRect(x: padding, y: 0-padding, width: width1Third*2, height: switchHeight+padding)
        eggPicker.isHidden = true
        contentView.addSubview(eggPicker)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

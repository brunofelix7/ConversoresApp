import UIKit

class ViewController: UIViewController {
    
    //  MARK: Outlets
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var btUnit1: UIButton!
    @IBOutlet weak var btUnit2: UIButton!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var lbResultUnit: UILabel!
    @IBOutlet weak var lbUnit: UILabel!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //  MARK: Ação do botão que exibe a próxima medida
    @IBAction func showNext(_ sender: UIButton) {
        switch lbUnit.text! {
            case MeasureEnum.temperature.rawValue:
                lbUnit.text = MeasureEnum.weight.rawValue
                btUnit1.setTitle(WeightEnum.kilogram.rawValue, for: .normal)
                btUnit2.setTitle(WeightEnum.pound.rawValue, for: .normal)
            case MeasureEnum.weight.rawValue:
                lbUnit.text = MeasureEnum.currency.rawValue
                btUnit1.setTitle(CurrencyEnum.real.rawValue, for: .normal)
                btUnit2.setTitle(CurrencyEnum.dollar.rawValue, for: .normal)
            case MeasureEnum.currency.rawValue:
                lbUnit.text = MeasureEnum.distance.rawValue
                btUnit1.setTitle(DistanceEnum.meter.rawValue, for: .normal)
                btUnit2.setTitle(DistanceEnum.kilometer.rawValue, for: .normal)
            default:
                lbUnit.text = MeasureEnum.temperature.rawValue
                btUnit1.setTitle(TemperatureEnum.celsius.rawValue, for: .normal)
                btUnit2.setTitle(TemperatureEnum.farenheint.rawValue, for: .normal)
        }
        convert(nil)
    }
    
    //  MARK: Ação do botão calcular
    @IBAction func convert(_ sender: UIButton?) {
        if let sender = sender {
            if sender == btUnit1 {
                btUnit2.alpha = 0.5
            } else {
                btUnit1.alpha = 0.5
            }
            sender.alpha = 1.0
        }
        switch lbUnit.text! {
            case MeasureEnum.temperature.rawValue:
                calcTemperature()
            case MeasureEnum.weight.rawValue:
                calcWeight()
            case MeasureEnum.currency.rawValue:
                calcCurrency()
            default:
                calcDistance()
        }
        
        //  MARK: Esconde o teclado
        view.endEditing(true)
        
        //  MARK: Formata o resultado da conversão
        let result = Double(lbResult.text!)!
        
        lbResult.text = String(format: "%.2f", result)
    }
    
    //  MARK: Conversão de temperatura
    func calcTemperature() {
        //  Semelhante ao if let, mais a variavel pode ser usada fora do bloco
        guard let temperature = Double(tfValue.text!) else {return}
        
        if btUnit1.alpha == 1.0 {
            lbResultUnit.text = TemperatureEnum.farenheint.rawValue
            lbResult.text = String(temperature * 1.8 + 32.0)
        } else {
            lbResultUnit.text = TemperatureEnum.celsius.rawValue
            lbResult.text = String((temperature - 32.0) / 1.8)
        }
    }
    
    //  MARK: Conversão de peso
    func calcWeight() {
        guard let weight = Double(tfValue.text!) else {return}
        
        if btUnit1.alpha == 1.0 {
            lbResultUnit.text = WeightEnum.pound.rawValue
            lbResult.text = String(weight / 2.2046)
        } else {
            lbResultUnit.text = WeightEnum.kilogram.rawValue
            lbResult.text = String(weight * 2.2046)
        }
    }
    
    //  MARK: Conversão de moeda
    func calcCurrency() {
        guard let currency = Double(tfValue.text!) else {return}
        
        if btUnit1.alpha == 1.0 {
            lbResultUnit.text = CurrencyEnum.dollar.rawValue
            lbResult.text = String(currency / 5.24)
        } else {
            lbResultUnit.text = CurrencyEnum.real.rawValue
            lbResult.text = String(currency * 5.24)
        }
    }
    
    //  MARK: Conversão de distância
    func calcDistance() {
        guard let distance = Double(tfValue.text!) else {return}
        
        if btUnit1.alpha == 1.0 {
            lbResultUnit.text = DistanceEnum.kilometer.rawValue
            lbResult.text = String(distance / 1000.0)
        } else {
            lbResultUnit.text = DistanceEnum.meter.rawValue
            lbResult.text = String(distance * 1000.0)
        }
    }
    
}

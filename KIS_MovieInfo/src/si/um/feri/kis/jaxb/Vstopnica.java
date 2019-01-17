package si.um.feri.kis.jaxb;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlValue;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "Vstopnica")
public class Vstopnica {

    @XmlAttribute
    private String tipPredstave;

    @XmlAttribute
    private String valuta;

    @XmlValue
    private String cena;

	public String getTipPredstave() {
		return tipPredstave;
	}
	public void setTipPredstave(String tipPredstave) {
		this.tipPredstave = tipPredstave;
	}
	public String getValuta() {
		return valuta;
	}
	public void setValuta(String valuta) {
		this.valuta = valuta;
	}
	public String getCena() {
		return cena;
	}
	public void setCena(String cena) {
		this.cena = cena;
	}
}
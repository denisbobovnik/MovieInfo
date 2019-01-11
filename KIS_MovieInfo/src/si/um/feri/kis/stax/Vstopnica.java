package si.um.feri.kis.stax;

public class Vstopnica {
	
	private String valuta, tipPredstave;
	private double cena;
	
	public Vstopnica() {
		
	}
	public Vstopnica(String valuta, String tipPredstave, double cena) {
		this.valuta = valuta;
		this.tipPredstave = tipPredstave;
		this.cena = cena;
	}
	
	public String getValuta() {
		return valuta;
	}
	public void setValuta(String valuta) {
		this.valuta = valuta;
	}
	public String getTipPredstave() {
		return tipPredstave;
	}
	public void setTipPredstave(String tipPredstave) {
		this.tipPredstave = tipPredstave;
	}
	public double getCena() {
		return cena;
	}
	public void setCena(double cena) {
		this.cena = cena;
	}
}
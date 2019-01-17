package si.um.feri.kis.jaxb;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "ShowtimeList")
@XmlAccessorType (XmlAccessType.FIELD)
public class ShowtimeList {
    @XmlElement(name = "Showtime")
    private List<Showtime> ShowtimeList = null;

    public void dodajPredstavo(Showtime s) {
    	if(ShowtimeList==null)
    		ShowtimeList = new ArrayList<Showtime>();
    	ShowtimeList.add(s);
    }
    
	public List<Showtime> getShowtimeList() {
		return ShowtimeList;
	}
	public void setShowtimeList(List<Showtime> ShowtimeList) {
		this.ShowtimeList = ShowtimeList;
	}
}
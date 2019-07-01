package cafe;

public class PageInfo {
	private int pageb;
	private int pagebn;
	private int pagen;
	
	
	public PageInfo() {}
	public PageInfo(int pageb, int pagebn, int pagen) {
		super();
		this.pageb = pageb;
		this.pagebn = pagebn;
		this.pagen = pagen;
	}
	public int getPageb() {
		return pageb;
	}
	public void setPageb(int pageb) {
		this.pageb = pageb;
	}
	public int getPagebn() {
		return pagebn;
	}
	public void setPagebn(int pagebn) {
		this.pagebn = pagebn;
	}
	public int getPagen() {
		return pagen;
	}
	public void setPagen(int pagen) {
		this.pagen = pagen;
	}	
}

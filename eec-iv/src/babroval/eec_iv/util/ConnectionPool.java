package babroval.eec_iv.util;

public final class ConnectionPool {

	private String comport;
	
	private ConnectionPool() {
	}
	
	private static class PoolHolder {
		private static final ConnectionPool POOL = new ConnectionPool();
	}
	
	public static ConnectionPool getPool() {
		return PoolHolder.POOL;
	}
	
	public void getConnection() {

//		this.url = url;
//		this.user = user;
//		this.password = password;

		try {
			
		
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}

package babroval.eec_iv.util;

import jssc.SerialPort;

public final class ConnectionPool {

	private static SerialPort serialPort = new SerialPort("COM7");

	private ConnectionPool() {
	}

	private static class PoolHolder {
		private static final ConnectionPool POOL = new ConnectionPool();
	}

	public static ConnectionPool getPool() {
		return PoolHolder.POOL;
	}

	public SerialPort getConnection() {

		try {
			serialPort.openPort();
			serialPort.setParams(SerialPort.BAUDRATE_38400, SerialPort.DATABITS_8, SerialPort.STOPBITS_2,
					SerialPort.PARITY_NONE);

			return serialPort;

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
}

package babroval.eec_iv.util;

import jssc.SerialPort;
import jssc.SerialPortEvent;
import jssc.SerialPortEventListener;
import jssc.SerialPortList;

public final class ConnectionPool {

	private static Boolean isPortDetected = false;
	private static String portName = "";
	private static SerialPort serialPort = new SerialPort(portName);

	private ConnectionPool() {
	}

	private static class PoolHolder {
		private static final ConnectionPool POOL = new ConnectionPool();
	}

	public static ConnectionPool getPool() {
		return PoolHolder.POOL;
	}

	public SerialPort getPort() {
		try {
			String[] portNames = SerialPortList.getPortNames();

			for (int i = 0; i < portNames.length; i++) {

				portName = portNames[i];
//				System.out.println(portName);
				serialPort = new SerialPort(portName);
				try {
					serialPort.openPort();
				} catch (Exception e) {
					continue;
				}
				serialPort.setParams(SerialPort.BAUDRATE_38400, SerialPort.DATABITS_8, SerialPort.STOPBITS_2,
						SerialPort.PARITY_NONE);
				serialPort.addEventListener(new PortReader(), SerialPort.MASK_RXCHAR);
				Thread.sleep(100);
				serialPort.writeByte((byte) 7);
				Thread.sleep(100);
				if (isPortDetected) {
					return serialPort;
				}
				serialPort.closePort();
			}
			throw new RuntimeException();

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
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

	private static class PortReader implements SerialPortEventListener {

		@Override
		public void serialEvent(SerialPortEvent event) {
			if (event.isRXCHAR() && event.getEventValue() > 0) {
				try {
					String receivedData = serialPort.readHexString(event.getEventValue());
//					System.out.println(receivedData);
					if (receivedData.equals("0C 0C")) {
						serialPort.writeByte((byte) 0);
						isPortDetected = true;
					}
				} catch (Exception e) {
					throw new RuntimeException(e);
				}
			}
		}
	}
}

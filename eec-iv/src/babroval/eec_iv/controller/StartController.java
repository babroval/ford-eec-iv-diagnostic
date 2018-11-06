package babroval.eec_iv.controller;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

import javax.swing.JLabel;
import javax.swing.JOptionPane;

import babroval.eec_iv.view.StartView;
import jssc.SerialPort;
import jssc.SerialPortEvent;
import jssc.SerialPortEventListener;
import jssc.SerialPortException;
import jssc.SerialPortList;

public class StartController extends Thread {

	static SerialPort serialPort = new SerialPort("COM7");;

	static StartView view = new StartView();

	public StartController() {
	}

	public void initController() {

		view.getErrors().addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent ae) {
				try {

					serialPort.openPort();

					serialPort.setParams(SerialPort.BAUDRATE_38400,
										 SerialPort.DATABITS_8,
										 SerialPort.STOPBITS_2,
										 SerialPort.PARITY_NONE);

					serialPort.addEventListener(new PortReader(), SerialPort.MASK_RXCHAR);

					Thread.sleep(1000);
					serialPort.writeByte((byte) 5);
					Thread.sleep(500);
					serialPort.writeByte((byte) 1);

					JOptionPane.showMessageDialog(view.getPanel(), "Interface is connected.",
							"Message", JOptionPane.INFORMATION_MESSAGE);

				} catch (Exception e) {
					JOptionPane.showMessageDialog(view.getPanel(), "no interface connection", "",
							JOptionPane.ERROR_MESSAGE);
				}
			}
		});
	}

	private static class PortReader implements SerialPortEventListener {

		@Override
		public void serialEvent(SerialPortEvent event) {
			if (event.isRXCHAR() && event.getEventValue() > 0) {
				try {
					String receivedData = serialPort.readHexString(event.getEventValue());
					System.out.println("Received response: " + receivedData);
					if(receivedData.equals("19 A1")) {
						JOptionPane.showMessageDialog(view.getPanel(), "no connection with engine control unit (switch on the ignition)", "",
						JOptionPane.ERROR_MESSAGE);
					
						serialPort.closePort();
					}
				} catch (SerialPortException ex) {
					System.out.println("Error in receiving string from COM-port: " + ex);
				}
			}
		}
	}
}

package babroval.eec_iv.controller;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JOptionPane;

import babroval.eec_iv.view.StartView;
import jssc.SerialPort;
import jssc.SerialPortEvent;
import jssc.SerialPortEventListener;
import jssc.SerialPortException;

public class StartController extends Thread {

	static SerialPort serialPort = new SerialPort("COM7");;

	static StartView view = new StartView();

	public StartController() {
	}

	public void initController() {

		resetFrame();
		view.getDisconnect().addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent arg0) {
				try {
			
						serialPort.closePort();
						resetFrame();
					
				} catch (SerialPortException ex) {
					JOptionPane.showMessageDialog(view.getPanel(),
							"port closing failed", "",
							JOptionPane.ERROR_MESSAGE);
					view.dispose();
				}

			}
		});
		
		view.getErrors().addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent ae) {
				try {

					serialPort.openPort();

					serialPort.setParams(SerialPort.BAUDRATE_38400, SerialPort.DATABITS_8, SerialPort.STOPBITS_2,
							SerialPort.PARITY_NONE);

					serialPort.addEventListener(new PortReader(), SerialPort.MASK_RXCHAR);

					Thread.sleep(1000);
					serialPort.writeByte((byte) 5);
					Thread.sleep(500);
					serialPort.writeByte((byte) 1);

					view.getErrors().setEnabled(false);
					view.getBaud().setEnabled(false);
					view.getDisconnect().setEnabled(true);
					view.getLabelConnect().setText("Interface is connected");

				} catch (Exception e) {
					JOptionPane.showMessageDialog(view.getPanel(), "no interface connection", "",
							JOptionPane.ERROR_MESSAGE);
					resetFrame();

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
					if (receivedData.equals("19 A1")) {
						JOptionPane.showMessageDialog(view.getPanel(),
								"no connection with engine control unit (switch on the ignition)", "",
								JOptionPane.ERROR_MESSAGE);
						serialPort.closePort();
						resetFrame();
					}
				} catch (SerialPortException ex) {
					System.out.println("Error in receiving string from COM-port: " + ex);
				}
			}
		}
	}

	private static void resetFrame() {
		view.getErrors().setEnabled(true);
		view.getBaud().setEnabled(true);
		view.getKoeo().setEnabled(false);
		view.getData().setEnabled(false);
		view.getDisconnect().setEnabled(false);
		view.getLabel().setText("");
		view.getLabelConnect().setText("Interface is disconnected");
	}
}

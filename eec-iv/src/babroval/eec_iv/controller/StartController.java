package babroval.eec_iv.controller;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.swing.JOptionPane;

import babroval.eec_iv.util.FileUtil;
import babroval.eec_iv.view.StartView;
import jssc.SerialPort;
import jssc.SerialPortEvent;
import jssc.SerialPortEventListener;
import jssc.SerialPortException;

public class StartController extends Thread {

	private static final String FILE_FAULTS_PATH = "EECIVFaults.txt";

	private static SerialPort serialPort = new SerialPort("COM7");;

	private static StartView view = new StartView();

	private static List<String> allFaults = new ArrayList<String>();
	private static List<String> faults = new ArrayList<String>();
	private static Boolean timeOut = new Boolean(false);

	{
		resetFrame();
		allFaults = FileUtil.loadAllFaults(FILE_FAULTS_PATH);
	}

	public StartController() {
	}

	public void initController() {

		view.getDisconnect().addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent arg0) {
				resetFrame();
			}
		});

		view.getFaults().addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent ae) {

				try {

					timeOut = Boolean.TRUE;

					serialPort.openPort();
					serialPort.setParams(SerialPort.BAUDRATE_38400, SerialPort.DATABITS_8, SerialPort.STOPBITS_2,
							SerialPort.PARITY_NONE);
					serialPort.addEventListener(new PortReader(), SerialPort.MASK_RXCHAR);
					Thread.sleep(1000);

					view.getFaults().setEnabled(false);
					view.getBaud().setEnabled(false);
					view.getDisconnect().setEnabled(false);
					view.getLabelConnect().setText("Interface is connected");

					if (view.getBaud().isSelected()) {
						serialPort.writeByte((byte) 4);
					} else {
						serialPort.writeByte((byte) 5);
					}
					Thread.sleep(500);

					serialPort.writeByte((byte) 1);

					Timer timer = new Timer();
					timer.schedule(new TimerTask() {
						@Override
						public void run() {

							try {
								serialPort.closePort();

								if (timeOut.booleanValue()) {
									resetFrame();
									if (!view.getBaud().isSelected()) {
										JOptionPane.showMessageDialog(view.getPanel(),
												"Switch the ignition OFF, reconnect diagnostic cable in the car, select checkbox 'other ECU', switch the ignition ON and press 'FAULTS' button again",
												"", JOptionPane.WARNING_MESSAGE);
									} else {
										JOptionPane.showMessageDialog(view.getPanel(),
												"Switch the ignition OFF, reconnect diagnostic cable in the car, deselect checkbox 'other ECU', switch the ignition ON and press 'FAULTS' button again",
												"", JOptionPane.WARNING_MESSAGE);
									}
								} else {
									view.getLabel().setVisible(true);
									view.getFaults().setEnabled(false);
									view.getKoeo().setEnabled(true);
									view.getDisconnect().setEnabled(true);
								}
							} catch (SerialPortException e) {
								resetFrame();
							}
						}
					}, 30000);

				} catch (Exception e) {
					resetFrame();
					JOptionPane.showMessageDialog(view.getPanel(), "COM-port connection fault (check USB wiring)", "",
							JOptionPane.ERROR_MESSAGE);
				}
			}
		});

		view.getKoeo().addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent ae) {

				try {
					serialPort.openPort();
					serialPort.setParams(SerialPort.BAUDRATE_38400, SerialPort.DATABITS_8, SerialPort.STOPBITS_2,
							SerialPort.PARITY_NONE);
					serialPort.addEventListener(new PortReader(), SerialPort.MASK_RXCHAR);
					Thread.sleep(1000);

					faults.clear();
					view.getLabel().setVisible(false);
					view.getKoeo().setEnabled(false);
					view.getDisconnect().setEnabled(false);

					if (view.getBaud().isSelected()) {
						serialPort.writeByte((byte) 4);
					} else {
						serialPort.writeByte((byte) 5);
					}
					Thread.sleep(500);

					serialPort.writeByte((byte) 2);

					Timer timer = new Timer();
					timer.schedule(new TimerTask() {
						@Override
						public void run() {
							try {
								serialPort.closePort();

								view.getLabel().setVisible(true);
								view.getData().setEnabled(true);
								view.getDisconnect().setEnabled(true);

							} catch (SerialPortException e) {
								resetFrame();
							}
						}
					}, 30000);

				} catch (Exception e) {
					resetFrame();
					JOptionPane.showMessageDialog(view.getPanel(), "COM-port connection fault (check USB wiring)",
							"", JOptionPane.ERROR_MESSAGE);
				}
			}
		});
	}

	private static class PortReader implements SerialPortEventListener {

		@Override
		public void serialEvent(SerialPortEvent event) {
			if (event.isRXCHAR() && event.getEventValue() > 0) {
				try {
					timeOut = Boolean.FALSE;
					String receivedData = serialPort.readHexString(event.getEventValue());
					System.out.println(receivedData);

					if (receivedData.equals("19 A1")) {
						resetFrame();
						JOptionPane.showMessageDialog(view.getPanel(),
								"There is no connection with the engine control unit (switch the ignition ON)", "",
								JOptionPane.ERROR_MESSAGE);
					} else {
						Integer i = Integer.valueOf(receivedData.substring(4, 5) + receivedData.substring(0, 2));
						faults.add(allFaults.get(i - 1));

						String s = "<html>";
						for (String fault : faults) {
							s = s + fault + "<br>";
						}
						view.getLabel().setText(s);
					}
				} catch (SerialPortException ex) {
					System.out.println("Unable to receive string from COM-port: " + ex);
				}
			}
		}
	}

	private static void resetFrame() {
		try {
			if (serialPort.isOpened()) {
				serialPort.closePort();
			}
		} catch (SerialPortException e) {
			view.dispose();
			JOptionPane.showMessageDialog(view.getPanel(),
					"COM-port connection fault (check USB wiring and restart application)", "",
					JOptionPane.ERROR_MESSAGE);
			
			System.exit(1);
		}
		faults.clear();
		view.getBaud().setEnabled(true);
		view.getFaults().setEnabled(true);
		view.getKoeo().setEnabled(false);
		view.getData().setEnabled(false);
		view.getDisconnect().setEnabled(false);
		view.getLabel().setVisible(false);
		view.getLabelConnect().setText("Interface is disconnected.");
		
	}
}
